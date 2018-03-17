nuclear={}

nuclear.uranium_melting = 1405.5
nuclear.uranium_boiling = 4018
nuclear.uranium_hot = 900
nuclear.air_temperature = 300

nuclear.dist = {x = 5, y = 5, z = 5}


nuclear.thermal_conductivity_default = 0.15
nuclear.thermal_conductivity_water = 3
nuclear.thermal_conductivity_uranium = 1.5

nuclear.waste_k = 0.00001
nuclear.bottommelt = 0.4
nuclear.sidemelt = 0.2
nuclear.obsidian_mk = 10

nuclear.u235_react_energy = 6e6
nuclear.u235_natural_neutrons = 1e-7
nuclear.u235_absorbtion = 1
nuclear.u235_reproduce_k = 15

nuclear.pu239_react_energy = 9e6
nuclear.pu239_natural_neutrons = 2e-6
nuclear.pu239_absorbtion = 1
nuclear.pu239_reproduce_k = 15

nuclear.u238_react_energy = 1e4
nuclear.u238_natural_neutrons = 1e-12
nuclear.u238_absorbtion = 1e-2

nuclear.waste_natural_neutrons = 1e-3

nuclear.parse_meta = function(meta)
	if meta == nil then
		return nil
	end
	local data = {
		temperature          = meta:get_float("temperature"),
		waste                = meta:get_float("waste"),
		u235                 = meta:get_float("u235"),
		u238                 = meta:get_float("u238"),
		pu239                = meta:get_float("pu239"),
		u235_radiation       = meta:get_float("u235_radiation"),
		pu239_radiation      = meta:get_float("pu239_radiation"),
		u238_radiation       = meta:get_float("u238_radiation"),
	}
	return data
end

nuclear.get_meta = function(pos)
	local meta = minetest.get_meta(pos)
	return nuclear.parse_meta(meta)
end

nuclear.has_meta = function(pos)
	local meta = minetest.get_meta(pos)
	if meta == nil then
		return false
	end
	if meta:get_float("temperature") == 0 then
		return false
	end
	return true
end

nuclear.set_meta = function(pos, data)
	local meta = minetest.get_meta(pos)
	meta:set_float("temperature", data.temperature)
	meta:set_float("waste", data.waste)
	meta:set_float("u235_radiation", data.u235_radiation)
	meta:set_float("pu239_radiation", data.pu239_radiation)
	meta:set_float("u238_radiation", data.u235_radiation)
	meta:set_float("u235", data.u235)
	meta:set_float("u238", data.u238)
	meta:set_float("pu239", data.pu239)
end

vector.scalar = function(vec1, vec2)
	return vec1.x * vec2.x + vec1.y * vec2.y + vec1.z * vec2.z
end

local modpath = minetest.get_modpath("nuclear")

dofile(modpath.."/radioactivity.lua")
dofile(modpath.."/nodes.lua")
dofile(modpath.."/actions.lua")
dofile(modpath.."/ores.lua")
dofile(modpath.."/craft.lua")
dofile(modpath.."/detectors.lua")
