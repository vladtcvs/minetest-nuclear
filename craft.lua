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

