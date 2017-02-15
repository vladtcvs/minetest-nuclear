nuclear.calculate_moderate_coeffs = function(k_f, k_s, m)
	local cf = math.exp(-(k_f + m))
	local ds = 0
	local df = 0
	local d = k_s - k_f - m
	if (d ~= 0) then
		ds = math.exp(-k_s)
		df = m/d * (math.exp(-(k_f + m)) - math.exp(-k_s))
	else
		ds = math.exp(-k_s)
		df = m * math.exp(-k_s)
	end
	local coeffs = {c_f = cf, d_s = ds, d_f = df}
	return coeffs
end

nuclear.blocks_intersection = function(center, position, blocks)
	local diff = vector.subtract(position, center)
	local dl = vector.length(diff)
	local to_source = vector.multiply(diff, 1/dl)
	local crossed = {}
	for i,block in pairs(blocks) do
		local to_block = vector.subtract(block, center)
		local s = vector.scalar(to_source, to_block)
		if (s < dl and s > 0) then
			local h = vector.subtract(to_block, vector.multiply(to_source, s))
			local hl = vector.length(h)
			if hl < 0.5 then
				table.insert(crossed, minetest.get_node(block))
			end
		end
	end
	return crossed
end

nuclear.neutron_source = function(node_info)
	return node_info.u235_radiation +
	       node_info.pu239_radiation +
	       node_info.u238_radiation +
	       node_info.waste * nuclear.waste_natural_neutrons
end

nuclear.moderating = function(node)
	return minetest.registered_nodes[node.name].coeffs
end

nuclear.calculate_neutrons = function(source, receiver, source_amount)
	local receiver_amount = {slow = 0, fast = source_amount}
	local distance = vector.distance(source, receiver)
	local group = "group:neutron_moderator"
	local blocks = {}

	for i,block in pairs(blocks) do
		local coeffs         = nuclear.moderating(block)
		local fast = receiver_amount.fast * coeffs.c_f
		local slow = receiver_amount.slow * coeffs.d_s + receiver_amount.fast * coeffs.d_f
		receiver.amount_fast = fast
		receiver.amount_slow = slow
	end

	receiver_amount.fast = receiver_amount.fast / (distance * distance + 1)
	receiver_amount.slow = receiver_amount.slow / (distance * distance + 1)
	return receiver_amount
end

nuclear.calculate_received_neutrons = function(receiver)
	local minp = vector.subtract(receiver, nuclear.dist);
	local maxp = vector.add(receiver, nuclear.dist);
	local neigbours = minetest.find_nodes_in_area(minp, maxp, "group:radioactive")
	local total = {slow = 0, fast = 0}
	for i,npos in pairs(neigbours) do
		local diff = vector.subtract(npos, receiver)
		local dist2 = vector.scalar(diff, diff)
		local neutron_stream = nuclear.neutron_source(nuclear.get_meta(npos))
		local received = nuclear.calculate_neutrons(npos, receiver, neutron_stream)
		total.slow = total.slow + received.slow
		total.fast = total.fast + received.fast
	end
	return total
end

minetest.register_abm({
	nodenames = {"group:fissionable"},
	interval = 10,
	chance = 1,
	action = function(pos)
		local meta = nuclear.get_meta(pos)
		--print("Before T: "..meta.temperature.." Waste: "..meta.waste.." U235: "..meta.u235.." U238: "..meta.u238.." Pu239: "..meta.pu239)
		local received_neutrons = nuclear.calculate_received_neutrons(pos)

		local u235_neutrons_absorbed  = received_neutrons.slow * nuclear.u235_absorbtion * meta.u235
		local pu239_neutrons_absorbed = received_neutrons.slow * nuclear.pu239_absorbtion * meta.pu239
		local u238_neutrons_absorbed  = received_neutrons.fast * nuclear.u238_absorbtion * meta.u238

		meta.u235_radiation  = nuclear.u235_natural_neutrons * meta.u235  + u235_neutrons_absorbed * nuclear.u235_reproduce_k
		meta.u238_radiation  = nuclear.u238_natural_neutrons * meta.u238
		meta.pu239_radiation = nuclear.pu239_natural_neutrons * meta.pu239 + pu239_neutrons_absorbed * nuclear.pu239_reproduce_k

		local reacted_u235  = u235_neutrons_absorbed
		local reacted_pu239 = pu239_neutrons_absorbed
		local reacted_u238  = u238_neutrons_absorbed

		--print("reacted u235: "..reacted_u235.." pu239: "..reacted_pu239.." u238: "..reacted_u238)
		local decayed_u235 = nuclear.u235_natural_neutrons * meta.u235
		local decayed_pu239 = nuclear.pu239_natural_neutrons * meta.pu239
		local decayed_u238 = nuclear.u238_natural_neutrons * meta.u238

		meta.u235  = meta.u235 - reacted_u235 - decayed_u235
		meta.u238  = meta.u238 - reacted_u238 - decayed_u238
		meta.pu239 = meta.pu239 - reacted_pu239 + reacted_u238 - decayed_pu239
		meta.waste = meta.waste + reacted_u235 + reacted_pu239 + decayed_u235 + decayed_pu239 + decayed_u238

		local energy = nuclear.u235_react_energy  * (reacted_u235 + decayed_u235) +
		               nuclear.pu239_react_energy * (reacted_pu239 + decayed_pu239) +
		               nuclear.u238_react_energy  * decayed_u238

		meta.temperature = meta.temperature + energy - (meta.temperature + energy/2 - nuclear.air_temperature) * nuclear.thermal_conductivity;

		nuclear.set_meta(pos, meta)
		print("["..minetest.get_node(pos).name.."] T: "..meta.temperature.." Waste: "..meta.waste)
		      --" U235: "..meta.u235_radiation/meta.u235..
		      --" Pu239: "..meta.pu239_radiation/meta.pu239)
		if (meta.waste >= 1) then
			minetest.add_node(pos, {name="nuclear:uranium_waste"})
		end
	end,
})
