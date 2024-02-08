local compression_ratio = settings.startup['bft:factor'].value or 10.0
local prototype_categories = {
	'assembling-machine',
	'beacon',
	'boiler',
	'fluid-turret',
	'fluid',
	'furnace',
	'generator',
	'inserter',
	'lab',
	'loader-1x1',
	'loader',
	'mining-drill',
	'offshore-pump',
	'pump',
	'radar',
	'reactor',
	'recipe',
	'resource',
}

if settings.startup['bft:tanks'].value then
	table.insert(prototype_categories, 'storage-tank')
	table.insert(prototype_categories, 'fluid-wagon')
end

--=================================================================================================

require 'compatibility.pressurized-fluids'

--=================================================================================================

local function skip(type, name)
	return BFT_blacklist[type] and BFT_blacklist[type][name]
end

local function multiplyStringValue(power, multiplier)
  if not power then return nil end
  local n, _ = string.gsub(power, "%a", "")
  local s = string.match(power, "%a+")
  return tostring(tonumber(n) * multiplier) .. s
end

local function divideFluid(item)
	if item.type == 'fluid' and not skip(item.type, item.name) then
		if item.amount then
			item.amount = item.amount / compression_ratio
		end
		if item.amount_min then
			item.amount_min = item.amount_min / compression_ratio
		end
		if item.amount_max then
			item.amount_max = item.amount_max / compression_ratio
		end
		if item.catalyst_amount then
			item.catalyst_amount = item.catalyst_amount / compression_ratio
		end
	end
end

--=================================================================================================

for _, source in pairs(prototype_categories) do
	for ___, val in pairs(data.raw[source]) do
		if skip(source, val.name) then goto skip end

		-- Recipe
		if val.type == 'recipe' then
			for _, version in pairs({val, val.normal, val.expensive}) do
				if version then
					if version.ingredients then
						for _, item in pairs(version.ingredients) do
							divideFluid(item)
						end
					end
					if version.results and not skip() then
						for _, item in pairs(version.results) do
							divideFluid(item)
						end
					end
				end
			end
		end

		-- Fluid
		if val.type == 'fluid' and val.heat_capacity then
			val.heat_capacity = multiplyStringValue(val.heat_capacity, compression_ratio)
		end
		if val.type == 'fluid' and val.fuel_value then
			val.fuel_value = multiplyStringValue(val.fuel_value, compression_ratio)
		end

		-- Generator
		if val.type == 'generator' and val.fluid_usage_per_tick then
			val.fluid_usage_per_tick = val.fluid_usage_per_tick / compression_ratio
		end

		-- Offshore pump
		if val.type == 'offshore-pump' and val.pumping_speed then
			val.pumping_speed = val.pumping_speed / compression_ratio
		end

		-- Resource
		if val.type == 'resource' and val.minable then
			if val.minable.results then
				for _, item in pairs(val.minable.results) do
					divideFluid(item)
				end
			end
			if val.minable.fluid_amount then
				val.minable.fluid_amount = val.minable.fluid_amount / compression_ratio
			end
		end

		-- Fluid turret
		if val.attack_parameters and val.attack_parameters.fluid_consumption then
			val.attack_parameters.fluid_consumption = val.attack_parameters.fluid_consumption / compression_ratio
		end

		-- Energy source
		if val.energy_source and val.energy_source.fluid_usage_per_tick then
			val.energy_source.fluid_usage_per_tick = val.energy_source.fluid_usage_per_tick / compression_ratio
		end

		-- Storage tank
		if val.type == 'storage-tank' and val.fluid_box then
			if not val.fluid_box.base_area then
				val.fluid_box.base_area = 1.0
			end
			val.fluid_box.base_area = val.fluid_box.base_area / compression_ratio
		end

		-- Fluid wagon
		if val.type == 'fluid-wagon' and val.capacity then
			val.capacity = val.capacity / compression_ratio
		end

		::skip::
	end
end

--=================================================================================================
