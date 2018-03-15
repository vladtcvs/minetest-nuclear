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
		nuclear.set_meta(pos, meta)
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
		user:hud_change(data.huds.radioactive.t,     "text", data.radiation.temperature)
		user:hud_change(data.huds.radioactive.u235,  "text", data.radiation.u235_state)
		user:hud_change(data.huds.radioactive.u238,  "text", data.radiation.u238_state)
		user:hud_change(data.huds.radioactive.pu239, "text", data.radiation.pu239_state)
		user:hud_change(data.huds.radioactive.waste, "text", data.radiation.waste_state)
	end
end


nuclear.measurer.update_radiation_info = function(user, meta)
	local player_name = user:get_player_name()
	local format = function(num)
		return string.format("%.2e", num)
	end
	local t_str = string.format("%4.2f", meta.temperature)
	local u235_str = format(meta.u235*100).."% :"..format(meta.u235_radiation/meta.u235)
	local u238_str = format(meta.u238*100).."% :"..format(meta.u238_radiation/meta.u238)
	local pu239_str = format(meta.pu239*100).."% :"..format(meta.pu239_radiation/meta.pu239)
	local waste_str = format(meta.waste*100).."%"

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

nuclear.measurer.hide_info = function(user)
	local player_name = user:get_player_name()
	local data = nuclear.measurer.datas[player_name]
	if data == nil then
		return
	end

	user:hud_remove(data.huds.bg.bg_hud)
	user:hud_remove(data.huds.radioactive.t)
	user:hud_remove(data.huds.radioactive.u235)
	user:hud_remove(data.huds.radioactive.u238)
	user:hud_remove(data.huds.radioactive.pu239)
	user:hud_remove(data.huds.radioactive.waste)

	user:hud_remove(data.huds.radioactive.t_l)
	user:hud_remove(data.huds.radioactive.u235_l)
	user:hud_remove(data.huds.radioactive.u238_l)
	user:hud_remove(data.huds.radioactive.pu239_l)
	user:hud_remove(data.huds.radioactive.waste_l)

	nuclear.measurer.datas[player_name] = nil
end

minetest.register_tool("nuclear:measurer", {
	description = "nuclear substancies composition measurement tool",
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
				nuclear.measurer.hide_info(user)
			elseif node.name == "nuclear:neutron_detector" then
				local meta = minetest.get_meta(pos)
				nuclear.measurer.update_neutron_detector_info(user, meta)
			else
				nuclear.measurer.hide_info(user)
			end
		end
		return itemstack
	end,
})

