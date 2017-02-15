
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

------------ URANIUM ------------

minetest.register_node("nuclear:stone_with_uranium", {
	description = "Uranium Ore",
	tiles = {"default_stone.png^nuclear_mineral_uranium.png"},
	groups = {cracky = 3},
	drop = 'nuclear:uranium_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type = "scatter",
	ore      = "nuclear:stone_with_uranium",
	wherein  = "default:stone",
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 1,
	clust_size     = 1,
	y_min          = -255,
	y_max          = -64,
})

minetest.register_ore({
	ore_type = "scatter",
	ore      = "nuclear:stone_with_uranium",
	wherein  = "default:stone",
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min          = -1023,
	y_max          = -256,
})

minetest.register_ore({
	ore_type = "scatter",
	ore      = "nuclear:stone_with_uranium",
	wherein  = "default:stone",
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min          = -31000,
	y_max          = -1024,
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
	type = "cooking",
	output = 'nuclear:uranium_ignot',
	recipe = 'nuclear:uranium_lump',
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
	groups = {fissionable = 1, liquid = 2, hot = 3, igniter = 1, radioactive = 1},
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
	groups = {liquid = 2, hot = 3, igniter = 1, not_in_creative_inventory = 1},
	damage_per_second = 16*2,
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
		              u235_radiation = 0,
		              pu239_radiation = 0,
			      u238_radiation = 0,
		}
		nuclear.set_meta(pos, meta)
	end,
})

minetest.register_craft({
	output = "nuclear:uranium",
	recipe = {{"nuclear:uranium_ignot", "nuclear:uranium_ignot", "nuclear:uranium_ignot"},
		  {"nuclear:uranium_ignot", "nuclear:uranium_ignot", "nuclear:uranium_ignot"},
		  {"nuclear:uranium_ignot", "nuclear:uranium_ignot", "nuclear:uranium_ignot"}}
})

minetest.register_node("nuclear:uranium_overheat", {
	description = "Overheated uranium",
	tiles = {"nuclear_uranium_overheat.png"},
	groups = {cracky = 3, hot = 3, fissionable = 1, radioactive = 1},
	light_source = default.LIGHT_MAX,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
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
		              u235_radiation = 0,
		              pu239_radiation = 0,
			      u238_radiation = 0,
		}
		nuclear.set_meta(pos, meta)
	end,
})


--------------- DETECTORS -------------
minetest.register_node("nuclear:neutron_detector", {
	description = "Neutron detector",
	tiles = {"nuclear_neutron_detector.png"},
	groups = {cracky = 3},
})

minetest.register_abm({
	nodenames = {"nuclear:neutron_detector"},
	interval = 10,
	chance = 1,
	action = function(pos)
		local meta = nuclear.get_meta(pos)
		local received_neutrons = nuclear.calculate_received_neutrons(pos)
		print("Slow: "..received_neutrons.slow.." Fast: "..received_neutrons.fast)
	end
})

------------- MODERATORS ---------------

minetest.register_node("nuclear:graphite", {
	description = "Graphite block",
	tiles = {"nuclear_graphite.png"},
	coeffs = nuclear.calculate_moderate_coeffs(0, 0, 1.098), -- moderation = 3
	groups = {cracky = 3, neutron_moderator = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	type = "cooking",
	output = 'nuclear:graphite',
	recipe = 'default:coalblock',
})