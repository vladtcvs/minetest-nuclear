nuclear.calculate_moderate_coeffs = function(k_s, k_f, m)
	return {f_f = (1 - k_f)*(1 - m), s_s = (1 - k_s), f_s = (1 - k_f)*m}
end

nuclear.blocks_intersection = function(from, to)
	-- centers of cubes
	local crossed = {}
	if (from == to) then
		return crossed
	end
	local start = {x = from.x + 0.5, y = from.y + 0.5, z = from.z + 0.5}
	local finish = {x = to.x + 0.5, y = to.y + 0.5, z = to.z + 0.5}
	local dist = vector.distance(from, to)
	local dir = vector.direction(start, finish)
	local dirlen = vector.length(dir)
	dir = vector.multiply(dir, 1 / dirlen)
	local dl = 0.2
	local curlen = 0
	local pos = start
	local prev_c = nil
	while curlen < dist do
		pos.x = pos.x + dir.x * dl
		pos.y = pos.y + dir.y * dl
		pos.z = pos.z + dir.z * dl
		local cell = {x = math.floor(pos.x),
		              y = math.floor(pos.y),
		              z = math.floor(pos.z)}
		if (prev_c == nil or (not vector.equals(cell, prev_c))) then
			local node = minetest.get_node(cell)
			table.insert(crossed, node)
			prev_c = cell
		end
		curlen = curlen + dl
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
	local blocks = nuclear.blocks_intersection(source, receiver)

	for i,block in pairs(blocks) do
		local coeffs         = nuclear.moderating(block)
		if coeffs ~= nil then
			local fast = receiver_amount.fast * coeffs.f_f
			local slow = receiver_amount.slow * coeffs.s_s + receiver_amount.fast * coeffs.f_s
			receiver_amount.fast = fast
			receiver_amount.slow = slow
			if receiver_amount.fast == 0 and receiver_amount.slow == 0 then
				break
			end
		end
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

		meta.temperature = nuclear.calculate_cooling(pos, meta.temperature + energy)

		nuclear.set_meta(pos, meta)
		if (meta.waste >= 0.99) then
			minetest.add_node(pos, {name="nuclear:uranium_waste"})
		end
	end,
})
