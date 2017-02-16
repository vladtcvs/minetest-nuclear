nuclear.melt_node = function(pos, k)
	local prob = k
	local node = minetest.get_node(pos)
	if (node.name == "air" or
	    node.name == "nuclear:melted_uranium_source" or
	    node.name == "nuclear:melted_uranium_flowing") then
		return 1
	end

	if (node.name == "default:obsidian" or
	    node.name == "default:obsidianbrick") then
		prob = k / nuclear.obsidian_mk
	end

	if (math.random() > prob) then
		return 0
	end
	minetest.log("action", "melted uranium has melted "..node.name.." under it!")
	minetest.remove_node(pos)
	return 1
end

minetest.register_abm({
	nodenames = {"nuclear:melted_uranium_source",
	             "nuclear:melted_uranium_flowing"},
	interval = 5,
	chance = 1,
	action = function(pos)
		local posorig = pos

		pos.y = pos.y - 1;
		local bmelted = nuclear.melt_node(pos, nuclear.bottommelt)
		if (bmelted == 0) then
			return
		end

		local posn = pos;
		posn.x = pos.x + 1;
		posn.y = pos.y;
		posn.z = pos.z
		nuclear.melt_node(posn, nuclear.sidemelt)

		posn.x = pos.x - 1;
		posn.y = pos.y;
		posn.z = pos.z
		nuclear.melt_node(posn, nuclear.sidemelt)

		posn.x = pos.x;
		posn.y = pos.y;
		posn.z = pos.z + 1;
		nuclear.melt_node(posn, nuclear.sidemelt)

		posn.x = pos.x;
		posn.y = pos.y;
		posn.z = pos.z - 1;
		nuclear.melt_node(posn, nuclear.sidemelt)

		nodeupdate(posorig)
	end
})

minetest.register_abm({
	nodenames = {"group:radioactive"},
	interval = 10,
	chance = 1,
	action = function(pos)
		local data = nuclear.get_meta(pos)
		if (data.waste == 0) then
			return
		end
		local minp = vector.subtract(pos, nuclear.dist);
		local maxp = vector.add(pos, nuclear.dist);
		local water = minetest.find_nodes_in_area(minp, maxp, "group:water")
		for i,wp in pairs(water) do
			--[[local node = minetest.get_node(wp)
			local type = minetest.registered_nodes[node.name].liquidtype;
			if (node.name ~= "nuclear:radioactive_water_source" and
			    node.name ~= "nuclear:radioactive_water_flowing") then
				if (type == "source") then
					minetest.add_node(wp, {name="nuclear:radioactive_water_source"})
				elseif (type == "flowing") then
					local level = minetest.get_node_level(wp)
					minetest.add_node(wp, {name="nuclear:radioactive_water_flowing"})
					minetest.set_node_level(wp, level)
				end
				nodeupdate(wp)
			end]]--
			local node = minetest.get_node(wp)
			local wmeta = minetest.get_meta(wp)
			wmeta:set_float("radioactivity", 1)
			node.light = LIGHT_MAX
			print("setting radioactivity to "..node.name)
		end
	end
})
