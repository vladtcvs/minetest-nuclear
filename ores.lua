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


