nuclear={}

nuclear.uranium_melting = 1405.5
nuclear.uranium_boiling = 4018
nuclear.uranium_hot = 900
nuclear.air_temperature = 300
nuclear.decay_energy = 600
nuclear.dist = {x = 5, y = 5, z = 5}
nuclear.thermal_conductivity = 0.15
nuclear.waste_k = 0.00001
nuclear.bottommelt = 0.4
nuclear.sidemelt = 0.2
nuclear.obsidian_mk = 10

nuclear.get_meta = function(pos)
	local meta = minetest.get_meta(pos)
	local data = {
		temperature          = meta:get_float("temperature"),
		waste                = meta:get_float("waste"),
		u235                 = meta:get_float("u235"),
		u238                 = meta:get_float("u238"),
		pu239                = meta:get_float("pu239"),
		u235_decay           = meta:get_float("u235_decay"),
		pu239_decay          = meta:get_float("pu239_decay"),
	}
	return data
end

nuclear.set_meta = function(pos, data)
	local meta = minetest.get_meta(pos)
	meta:set_float("temperature", data.temperature)
	meta:set_float("waste", data.waste)
	meta:set_float("u235_decay", data.u235_decay)
	meta:set_float("pu239_decay", data.pu239_decay)
	meta:set_float("u235", data.u235)
	meta:set_float("u238", data.u238)
	meta:set_float("pu239", data.pu239)
end

minetest.register_node("nuclear:radioactive_water_source", {
	description = "Radioactive Water Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "nuclear_radioactive_water_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name = "nuclear_radioactive_water_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
			backface_culling = false,
		},
	},
	alpha = 160,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	light_source = default.LIGHT_MAX - 3,
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "nuclear:radioactive_water_flowing",
	liquid_alternative_source = "nuclear:radioactive_water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, puts_out_fire = 1},
	damage_per_second = 1,
})

minetest.register_node("nuclear:radioactive_water_flowing", {
	description = "Flowing Radioactive Water",
	drawtype = "flowingliquid",
	tiles = {"nuclear_radioactive_water.png"},
	special_tiles = {
		{
			name = "nuclear_radioactive_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
		{
			name = "nuclear_radioactive_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
	},
	alpha = 160,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	light_source = default.LIGHT_MAX - 3,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "nuclear:radioactive_water_flowing",
	liquid_alternative_source = "nuclear:radioactive_water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, puts_out_fire = 1,
		not_in_creative_inventory = 1},
	damage_per_second = 1,
})

minetest.register_node("nuclear:melted_uranium_source", {
	description = "Melted Uranium Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "nuclear_melted_uranium_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name = "default_water_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
			backface_culling = false,
		},
	},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	light_source = default.LIGHT_MAX,
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "nuclear:melted_uranium_flowing",
	liquid_alternative_source = "nuclear:melted_uranium_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {fissionable = 1, liquid = 2, hot = 3, igniter = 1, falling_node = 1, radioactive = 1},
	damage_per_second = 16*2,
})

minetest.register_node("nuclear:melted_uranium_flowing", {
	description = "Flowing Melted Uranium",
	drawtype = "flowingliquid",
	tiles = {"nuclear_melted_uranium_flowing_animated.png"},
	special_tiles = {
		{
			name = "nuclear_melted_uranium_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "nuclear_melted_uranium_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
	},

	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	light_source = default.LIGHT_MAX,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_viscosity = 7,
	liquid_renewable = false,
	liquid_alternative_flowing = "nuclear:melted_uranium_flowing",
	liquid_alternative_source = "nuclear:melted_uranium_source",
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {fissionable = 1, liquid = 2, hot = 3, igniter = 1, not_in_creative_inventory = 1, radioactive = 1},
	damage_per_second = 16*2,
})

minetest.register_node("nuclear:graphite", {
	description = "Graphite block",
	tiles = {"nuclear_graphite.png"},
	neutron_moderate = 1,
	groups = {cracky = 3, neutron_moderator = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nuclear:uranium_waste", {
	description = "Uranium waste",
	tiles = {"nuclear_waste.png"},
	groups = {cracky = 3, radioactive = 1},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = {temperature = nuclear.air_temperature,
		              waste = 1,
		              u235 = 0,
		              pu239 = 0,
		              u238 = 0,
		              u235_decay = 0,
		              pu239_decay = 0,
		}
		nuclear.set_meta(pos, meta)
	end,
})

minetest.register_node("nuclear:uranium", {
	description = "uranium",
	tiles = {"nuclear_uranium.png"},
	groups = {cracky = 3, fissionable = 1, radioactive = 1},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = {temperature = nuclear.air_temperature,
		              waste = 0,
		              u235 = 0.0325,
		              pu239 = 0,
		              u238 = 1 - 0.0325,
		              u235_decay = 0,
		              pu239_decay = 0,
		}
		nuclear.set_meta(pos, meta)
	end,
})

minetest.register_node("nuclear:uranium_overheat", {
	description = "Overheated uranium",
	tiles = {"nuclear_uranium_overheat.png"},
	groups = {cracky = 3, hot = 3, fissionable = 1, radioactive = 1},
	light_source = default.LIGHT_MAX,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})

vector.scalar = function(vec1, vec2)
	return vec1.x * vec2.x + vec1.y * vec2.y + vec1.z * vec2.z
end


nuclear.melt_node = function(pos, k)
	local prob = k
	local node = minetest.get_node(pos)
	if (node.name == "nuclear:melted_uranium_source" or
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
		nuclear.melt_node(posn, nuclear.sidemelt)

		posn = pos;
		posn.x = pos.x - 1;
		nuclear.melt_node(posn, nuclear.sidemelt)

		posn = pos;
		posn.z = pos.z + 1;
		nuclear.melt_node(posn, nuclear.sidemelt)

		posn = pos;
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

nuclear.has_intersection = function(center, position, blocks)
	local diff = vector.subtract(position, center)
	local dl = vector.length(diff)
	local to_source = vector.multiply(diff, 1/dl)
	for i,block in pairs(blocks) do
		local to_block = vector.subtract(block, center)
		local s = vector.scalar(to_source, to_block)
		if (s < dl and s > 0) then
			local h = vector.subtract(to_block, vector.multiply(to_source, s))
			local hl = vector.length(h)
			if hl < 0.5 then
				return true
			end
		end
	end
	return false
end

minetest.register_abm({
	nodenames = {"group:fissionable"},
	interval = 10,
	chance = 1,
	action = function(pos)
		local minp = vector.subtract(pos, nuclear.dist);
		local maxp = vector.add(pos, nuclear.dist);
		local neigbours = minetest.find_nodes_in_area(minp, maxp, "group:fissionable")
		local graphite = minetest.find_nodes_in_area(minp, maxp, "group:neutron_moderator")
		local meta = nuclear.get_meta(pos)
		for i,npos in pairs(neigbours) do
			if ((not vector.equals(pos, npos)) and nuclear.has_intersection(pos, npos, graphite)) then
			--	print("has intersection")
				local diff = vector.subtract(npos, pos)
				local dist2 = vector.scalar(diff, diff)
				local decayed = 1/dist2;
				meta.temperature  = meta.temperature + nuclear.decay_energy * decayed
				meta.waste = meta.waste + nuclear.waste_k * decayed
			end
		end
		local diffT = meta.temperature - nuclear.air_temperature
		meta.temperature = meta.temperature - diffT * nuclear.thermal_conductivity;
		nuclear.set_meta(pos, meta)
		minetest.log("info", "Pos: ".."["..pos.x..","..pos.y..","..pos.z.."] T: "..meta.temperature.." Waste: "..meta.waste)
		if (meta.waste >= 1) then
			minetest.add_node(pos, {name="nuclear:uranium_waste"})
		end
	end,
})

minetest.register_abm({
	nodenames = {"nuclear:melted_uranium_source"},
	interval = 10,
	chance = 1,
	action = function(pos)
		local meta = nuclear.get_meta(pos)
		if (meta.temperature < nuclear.uranium_melting) then
			minetest.add_node(pos, {name="nuclear:uranium_overheat"})
			nuclear.set_meta(pos, meta)
			minetest.log("info", "Melted uranium is freezed! T = "..meta.temperature)
		end
	end,
})

minetest.register_abm({
	nodenames = {"nuclear:uranium_overheat"},
	interval = 10,
	chance = 1,
	action = function(pos)
		local meta = nuclear.get_meta(pos)
		if (meta.temperature >= nuclear.uranium_melting) then
			minetest.add_node(pos, {name="nuclear:melted_uranium_source"})
			nuclear.set_meta(pos, meta)
			nodeupdate(pos)
			minetest.log("info","Uranium melts! T = "..meta.temperature)
		elseif (meta.temperature < nuclear.uranium_hot) then
			minetest.add_node(pos, {name="nuclear:uranium"})
			nuclear.set_meta(pos, meta)
			minetest.log("info","Uranium is cooled! T = "..meta.temperature)
		end
	end,
})

minetest.register_abm({
	nodenames = {"nuclear:uranium"},
	interval = 10,
	chance = 1,
	action = function(pos)
		local meta = nuclear.get_meta(pos)
		if (meta.temperature >= nuclear.uranium_hot) then
			minetest.add_node(pos, {name="nuclear:uranium_overheat"})
			nuclear.set_meta(pos, meta)
			minetest.log("info","Uranium became hot! T = "..meta.temperature)
		end
	end,
})

minetest.register_node("nuclear:stone_with_uranium", {
	description = "Uranium Ore",
	tiles = {"default_stone.png^nuclear_mineral_uranium.png"},
	groups = {cracky = 3},
	drop = 'nuclear:uranium_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("nuclear:uranium_lump", {
	description = "Uranium Lump",
	inventory_image = "nuclear_uranium_lump.png",
})

minetest.register_craftitem("nuclear:uranium_ignot", {
	description = "Uranium Ignot",
	inventory_image = "nuclear_uranium_ignot.png",
})

minetest.register_craft({
	output = "nuclear:uranium",
	recipe = {{"nuclear:uranium_ignot", "nuclear:uranium_ignot", "nuclear:uranium_ignot"},
		  {"nuclear:uranium_ignot", "nuclear:uranium_ignot", "nuclear:uranium_ignot"},
		  {"nuclear:uranium_ignot", "nuclear:uranium_ignot", "nuclear:uranium_ignot"}}
})

minetest.register_craft({
	type = "cooking",
	output = 'nuclear:graphite',
	recipe = 'default:coalblock',
})

minetest.register_craft({
	type = "cooking",
	output = 'nuclear:uranium_ignot',
	recipe = 'nuclear:uranium_lump',
})

