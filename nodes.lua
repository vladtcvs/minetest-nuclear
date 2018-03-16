
local default_meta = {temperature = nuclear.air_temperature,
	waste = 0,
	u235 = 0.0325,
	pu239 = 0,
	u238 = 1 - 0.0325,
	u235_radiation = 0,
	pu239_radiation = 0,
	u238_radiation = 0,
}


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
	groups = {fissionable = 1, liquid = 2, hot = 3, igniter = 1, radioactive = 1, falling_node = 1, not_in_creative_inventory = 1},
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

nuclear.drop_uranium = function(itemstack, user, pos)
	return minetest.item_drop(itemstack, user, pos)
end

nuclear.preserve_metadata = function(pos, oldnode, oldmeta, drops)
	local meta_ser = minetest.serialize(oldmeta)
	for k, drop in pairs(drops) do
		drops[k] = ItemStack({name = "nuclear:uranium", count = 1, wear = 0, metadata = meta_ser})
	end
end

nuclear.creation_meta = nil

minetest.register_node("nuclear:uranium", {
	description = "uranium",
	tiles = {"nuclear_uranium.png"},
	stack_max = 1,
	drop = "nuclear:uranium",
	groups = {cracky = 3, fissionable = 1, radioactive = 1},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		if nuclear.creation_meta == nil then
			nuclear.set_meta(pos, default_meta)
		else
			nuclear.set_meta(pos, nuclear.creation_meta)
			nuclear.creation_meta = nil
		end
	end,
	on_drop = nuclear.drop_uranium,
	preserve_metadata = nuclear.preserve_metadata,
	on_place = function(itemstack, placer, pointed_thing)
		local meta_ref = itemstack:get_metadata()
		local meta = minetest.deserialize(meta_ref)
		nuclear.creation_meta = meta
		return minetest.item_place(itemstack, placer, pointed_thing)
	end
})


minetest.register_node("nuclear:uranium_overheat", {
	description = "Overheated uranium",
	drop = "nuclear:uranium",
	tiles = {"nuclear_uranium_overheat.png"},
	groups = {cracky = 3, hot = 3, fissionable = 1, radioactive = 1, not_in_creative_inventory = 1},
	light_source = default.LIGHT_MAX,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_drop = nuclear.drop_uranium,
	preserve_metadata = nuclear.preserve_metadata,
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

-- NODES TRANSFORMATION --

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
			minetest.check_for_falling(pos)	
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



------------- MODERATORS ---------------

minetest.register_node("nuclear:graphite", {
	description = "Graphite block",
	tiles = {"nuclear_graphite.png"},
	coeffs = nuclear.calculate_moderate_coeffs(0, 0, 0.2),
	groups = {cracky = 3, neutron_moderator = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nuclear:cadmium", {
	description = "Cadmium block",
	tiles = {"nuclear_cadmium.png"},
	coeffs = nuclear.calculate_moderate_coeffs(1, 1, 0),
	groups = {cracky = 3, neutron_moderator = 1},
	sounds = default.node_sound_stone_defaults(),
})

