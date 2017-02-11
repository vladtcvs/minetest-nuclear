nuclear={}

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
	liquid_viscosity = 7,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {fissionable = 1, liquid = 2, hot = 3, igniter = 1, falling_node = 1},
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

minetest.register_node("nuclear:enriched_uranium", {
	description = "Enriched uranium",
	tiles = {"nuclear_enriched_uranium.png"},
	groups = {cracky = 3, fissionable = 1},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nuclear:enriched_uranium_overheat", {
	description = "Overheated enriched uranium",
	tiles = {"nuclear_enriched_uranium_overheat.png"},
	groups = {cracky = 3, hot = 3},
	light_source = default.LIGHT_MAX,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
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

