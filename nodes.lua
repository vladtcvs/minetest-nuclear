
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
		local meta = minetest.get_meta(pos)
		meta:set_float("fast", received_neutrons.fast)
		meta:set_float("slow", received_neutrons.slow)
	end
})

nuclear.measurer = {
	datas = {},
}

nuclear.measurer.show_info = function(user)
	local player_name = user:get_player_name()
	local data = nuclear.measurer.datas[player_name]

	if data == nil or data.huds == nil or data.huds.bg == nil or data.huds.bg.present == false then
		local background_hud_id = user:hud_add({
			hud_elem_type = "image",
			position = {x=0.01,y=0.1},
			scale = {x = -20, y = -20},
			text =  "nuclear_detector_hud.png",
			alignment = {x=1,y=1},
			offset = {x=0, y=0},
		})

		if (nuclear.measurer.datas[player_name].huds == nil) then
			nuclear.measurer.datas[player_name].huds = {}
		end

		nuclear.measurer.datas[player_name].huds.bg = {
			bg_present = true,
			bg_hud = background_hud_id,
		}
	end

	if data == nil then
		return
	end

	if data.huds.radioactive == nil or data.huds.radioactive.present == false then
		print("creating")
		local T_label = user:hud_add({
			hud_elem_type = "text",
			position = {x=0.01,y=0.1},
			text =  "Temperature",
			alignment = {x=1,y=0},
			offset = {x=20, y=30},
		})
		local T_hud_id = user:hud_add({
			hud_elem_type = "text",
			position = {x=0.01,y=0.1},
			text =  data.radiation.temperature,
			alignment = {x=1,y=0},
			offset = {x=120, y=30},
		})
		local u235_label = user:hud_add({
			hud_elem_type = "text",
			position = {x=0.01,y=0.1},
			text =  "U235",
			alignment = {x=1,y=0},
			offset = {x=20, y=45},
		})
		local u235_hud_id = user:hud_add({
			hud_elem_type = "text",
			position = {x=0.01,y=0.1},
			text = data.radiation.u235_state,
			alignment = {x=1,y=0},
			offset = {x=120, y=45},
		})
		local u238_label = user:hud_add({
			hud_elem_type = "text",
			position = {x=0.01,y=0.1},
			text =  "U238",
			alignment = {x=1,y=0},
			offset = {x=20, y=60},
		})
		local u238_hud_id = user:hud_add({
			hud_elem_type = "text",
			position = {x=0.01,y=0.1},
			text = data.radiation.u238_state,
			alignment = {x=1,y=0},
			offset = {x=120, y=60},
		})
		local pu239_label = user:hud_add({
			hud_elem_type = "text",
			position = {x=0.01,y=0.1},
			text =  "Pu239",
			alignment = {x=1,y=0},
			offset = {x=20, y=75},
		})
		local pu239_hud_id = user:hud_add({
			hud_elem_type = "text",
			position = {x=0.01,y=0.1},
			text = data.radiation.pu239_state,
			alignment = {x=1,y=0},
			offset = {x=120, y=75},
		})
		local waste_label = user:hud_add({
			hud_elem_type = "text",
			position = {x=0.01,y=0.1},
			text =  "Waste",
			alignment = {x=1,y=0},
			offset = {x=20, y=90},
		})
		local waste_hud_id = user:hud_add({
			hud_elem_type = "text",
			position = {x=0.01,y=0.1},
			text = data.radiation.waste_state,
			alignment = {x=1,y=0},
			offset = {x=120, y=90},
		})

		if (nuclear.measurer.datas[player_name].huds == nil) then
			nuclear.measurer.datas[player_name].huds = {}
		end

		nuclear.measurer.datas[player_name].huds.radioactive = {
			present = true,
			t = T_hud_id,
			t_l = T_label,
			u235 = u235_hud_id,
			u235_l = u235_label,
			u238 = u238_hud_id,
			u238_l = u238_label,
			pu239 = pu239_hud_id,
			pu239_l = pu239_label,
			waste = waste_hud_id,
			waste_l = waste_label,
		}
	else
		print("changing")
		user:hud_change(data.huds.radioactive.t,     "text", data.radiation.temperature)
		user:hud_change(data.huds.radioactive.u235,  "text", data.radiation.u235_state)
		user:hud_change(data.huds.radioactive.u238,  "text", data.radiation.u238_state)
		user:hud_change(data.huds.radioactive.pu239, "text", data.radiation.pu239_state)
		user:hud_change(data.huds.radioactive.waste, "text", data.radiation.waste_state)
	end
	print(data.data.temperature.." "..data.data.u235_state.." "..data.data.u238_state)
end


nuclear.measurer.update_radiation_info = function(user, meta)
	local player_name = user:get_player_name()
	local format = function(num)
		return string.format("%.2e", num)
	end
	local t_str = string.format("%4.2f", meta.temperature)
	local u235_str = format(meta.u235)..":"..format(meta.u235_radiation/meta.u235)
	local u238_str = format(meta.u238)..":"..format(meta.u238_radiation/meta.u238)
	local pu239_str = format(meta.pu239)..":"..format(meta.pu239_radiation/meta.pu239)
	local waste_str = format(meta.waste)

	local new_data = {
		temperature = t_str,
		u235_state = u235_str,
		u238_state = u238_str,
		pu239_state = pu239_str,
		waste_state = waste_str,
	}
	if nuclear.measurer.datas[player_name] == nil then
		nuclear.measurer.datas[player_name] = {}
	end
	
	nuclear.measurer.datas[player_name].radiation = new_data
	nuclear.measurer.show_info(user)
end

nuclear.measurer.update_neutron_detector_info = function(user, meta)
	local player_name = user:get_player_name()
	local format = function(num)
		return string.format("%.2e", num)
	end

	local new_data = {
		fast = meta:get_float("fast"),
		slow = meta:get_float("slow"),
	}
	if nuclear.measurer.datas[player_name] == nil then
		nuclear.measurer.datas[player_name] = {}
	end
	nuclear.measurer.datas[player_name].neutron_detector = new_data
	--nuclear.measurer.show_info(user)
end

minetest.register_tool("nuclear:measurer", {
	description = "Nuclear substancies composition measurement tool",
	inventory_image = "nuclear_detector.png",
	on_use = function(itemstack, user, pointed_thing)
		local pt = pointed_thing

		if (pt.type == "node") then
			local node = minetest.get_node(pt.under)
			local pos  = pt.under
			if minetest.get_item_group(node.name, "radioactive") > 0 then
				local meta = nuclear.get_meta(pos)
				nuclear.measurer.update_radiation_info(user, meta)
			elseif minetest.get_item_group(node.name, "neutron_moderator") > 0 then
				print("Moderator")
			elseif node.name == "nuclear:neutron_detector" then
				local meta = minetest.get_meta(pos)
				nuclear.measurer.update_neutron_detector_info(user, meta)
			end
		end
		return itemstack
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
