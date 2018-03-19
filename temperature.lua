local k_default = math.exp(-nuclear.thermal_conductivity_default)
local k_water = math.exp(-nuclear.thermal_conductivity_water)
local k_uranium = math.exp(-nuclear.thermal_conductivity_uranium)

nuclear.calculate_cooling = function(pos, temperature)
	local num_nb = 8 + 9 + 9

	local cooling = 0
	local k = 1
	local sT = 0
	local s = 0
	
	for x = pos.x - 1, pos.x + 1 do
		for y = pos.y - 1, pos.y + 1 do
			for z = pos.z - 1, pos.z + 1 do
				local P = {x=x, y=y, z=z}
				local node = minetest.get_node(P)
				local ki = k_default
				local a = nuclear.thermal_conductivity_default
				local T = nuclear.air_temperature
				if node.name == "default:water_source" then
					ki = k_water
					a = nuclear.thermal_conductivity_water
					T = nuclear.air_temperature
				elseif node.name == "nuclear:uranium" or
				       node.name == "nuclear:uranium_overheat" or
				       node.name == "nuclear:melted_uranium_source" then
					local meta = nuclear.get_meta(P)
					ki = k_uranium
					a = nuclear.thermal_conductivity_uranium
					T = meta.temperature
				end
				k = k * ki
				sT = sT + a * T
				s = s + a
			end
		end
	end
	return (temperature - sT/s) * k + sT/s
end

