nuclear={}

nuclear.uranium_melting = 1405.5
nuclear.uranium_hot = 900
nuclear.air_temperature = 300
nuclear.decay_energy = 450
nuclear.dist = {x = 5, y = 5, z = 5}
nuclear.thermal_conductivity = 0.16
nuclear.waste_k = 0.0001

minetest.register_node("nuclear:radioactive_water_source", {
	description = "Radioactive Water Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "default_water_source_animated.png",
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
	tiles = {"default_water.png"},
	special_tiles = {
		{
			name = "default_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
		{
			name = "default_water_flowing_animated.png",
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
	liquid_viscosity = 14,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {fissionable = 1, liquid = 2, hot = 3, igniter = 1, falling_node = 1},
	damage_per_second = 16*2,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_float("temperature", nuclear.uranium_melting + 1)
		meta:set_float("waste", 0)
	end,
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
	liquid_viscosity = 14,
	liquid_alternative_flowing = "nuclear:melted_uranium_flowing",
	liquid_alternative_source = "nuclear:melted_uranium_source",
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {fissionable = 1, liquid = 2, hot = 3, igniter = 1, not_in_creative_inventory = 1},
	damage_per_second = 16*2,
})

minetest.register_node("nuclear:graphite", {
	description = "Graphite block",
	tiles = {"nuclear_graphite.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nuclear:uraniumblock", {
	description = "Uranium block",
	tiles = {"nuclear_uranium.png"},
	groups = {cracky = 3},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nuclear:uranium_waste", {
	description = "Uranium waste",
	tiles = {"nuclear_waste.png"},
	groups = {cracky = 3},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_float("waste", 1)
	end,
})

minetest.register_node("nuclear:enriched_uranium", {
	description = "Enriched uranium",
	tiles = {"nuclear_enriched_uranium.png"},
	groups = {cracky = 3, fissionable = 1},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_float("temperature", nuclear.air_temperature)
		meta:set_float("waste", 0)
	end,
})

minetest.register_node("nuclear:enriched_uranium_overheat", {
	description = "Overheated enriched uranium",
	tiles = {"nuclear_enriched_uranium_overheat.png"},
	groups = {cracky = 3, hot = 3, fissionable = 1},
	light_source = default.LIGHT_MAX,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_float("temperature", nuclear.uranium_hot + 1)
		meta:set_float("waste", 0)
	end,
})

vector.scalar = function(vec1, vec2)
	return vec1.x * vec2.x + vec1.y * vec2.y + vec1.z * vec2.z
end

nuclear.has_intersection = function(center, position, blocks)
	local diff = vector.subtract(position, center)
	local dl = vector.length(diff)
	local t = vector.multiply(diff, 1/dl)
	for i,block in pairs(blocks) do
		local vec = vector.subtract(block, center)
		local vl = vector.length(vec)
		if (vl < dl) then
			local s = vector.scalar(t, vec)
			local h = vector.subtract(vec, vector.multiply(t, s))
			if vector.length(h) < 1/1.41 then
				return true
			end
		end
	end
	return false
end

minetest.register_abm({
	nodenames = {"nuclear:melted_uranium_source",
	             "nuclear:enriched_uranium_overheat",
	             "nuclear:enriched_uranium"},
	interval = 10,
	chance = 1,
	action = function(pos)
		local minp = vector.subtract(pos, nuclear.dist);
		local maxp = vector.add(pos, nuclear.dist);
		local neigbours = minetest.find_nodes_in_area(minp, maxp, "group:fissionable")
		local graphite = minetest.find_nodes_in_area(minp, maxp, "nuclear:graphite")
		local meta = minetest.get_meta(pos)
		local temp = meta:get_float("temperature")
		local waste = meta:get_float("waste")
		for i,npos in pairs(neigbours) do
			if ((not vector.equals(pos, npos)) and nuclear.has_intersection(pos, npos, graphite)) then
				local diff = vector.subtract(npos, pos)
				local dist2 = vector.scalar(diff, diff)
				local decayed = 1/dist2;
				temp = temp + nuclear.decay_energy * decayed
				waste = waste + nuclear.waste_k * decayed
			end
		end
		local diffT = temp - nuclear.air_temperature
		temp = temp - diffT * nuclear.thermal_conductivity;
		meta:set_float("temperature", temp)
		meta:set_float("waste", waste)
		if (waste >= 1) then
			minetest.add_node(pos, {name="nuclear:uranium_waste"})
		end
		print("T: "..meta:get_float("temperature").." Waste: "..waste)
		
	end,
})


minetest.register_abm({
	nodenames = {"nuclear:melted_uranium_source"},
	interval = 10,
	chance = 1,
	action = function(pos)
		local meta = minetest.get_meta(pos)
		local temperature = meta:get_float("temperature")
		if (temperature < nuclear.uranium_melting) then
			local waste = meta:get_float("waste")
			minetest.add_node(pos, {name="nuclear:enriched_uranium_overheat"})
			local freezemeta = minetest.get_meta(pos)
			freezemeta:set_float("temperature", temperature)
			freezemeta:set_float("waste", waste)
			print("Melted uranium is freezed! T = "..temperature)
			nodeupdate(pos)
		end
	end,
})

minetest.register_abm({
	nodenames = {"nuclear:enriched_uranium_overheat"},
	interval = 10,
	chance = 1,
	action = function(pos)
		local meta = minetest.get_meta(pos)
		local temperature = meta:get_float("temperature")
		if (temperature >= nuclear.uranium_melting) then
			local waste = meta:get_float("waste")
			minetest.add_node(pos, {name="nuclear:melted_uranium_source"})
			local meltedmeta = minetest.get_meta(pos)
			meltedmeta:set_float("temperature", temperature)
			meltedmeta:set_float("waste", waste)
			print("Uranium melts! T = "..temperature)
			nodeupdate(pos)
		elseif (temperature < nuclear.uranium_hot) then
			local waste = meta:get_float("waste")
			minetest.add_node(pos, {name="nuclear:enriched_uranium"})
			local coolmeta = minetest.get_meta(pos)
			coolmeta:set_float("temperature", temperature)
			coolmeta:set_float("waste", waste)
			print("Uranium is cooled! T = "..temperature)
			nodeupdate(pos)
		end
	end,
})

minetest.register_abm({
	nodenames = {"nuclear:enriched_uranium"},
	interval = 10,
	chance = 1,
	action = function(pos)
		local meta = minetest.get_meta(pos)
		local temperature = meta:get_float("temperature")
		if (temperature >= nuclear.uranium_hot) then
			local waste = meta:get_float("waste")
			minetest.add_node(pos, {name="nuclear:enriched_uranium_overheat"})
			local hotmeta = minetest.get_meta(pos)
			hotmeta:set_float("temperature", temperature)
			hotmeta:set_float("waste", waste)
			print("Uranium became hot! T = "..temperature)
			nodeupdate(pos)
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
	output = "nuclear:enriched_uranium",
	recipe = {{"nuclear:uraniumblock", "nuclear:uraniumblock"},
		  {"nuclear:uraniumblock", "nuclear:uraniumblock"}}
})

minetest.register_craft({
	output = "nuclear:uraniumblock",
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

