
local ores = {
	'stone',
	'iron-ore',
	'copper-ore',
	'uranium-ore',
	--'enemy-base',
	'ore-aluminium',
	'ore-chromium',
	'ore-lead',
	'ore-nickel',
	'ore-quartz',
	'ore-tin',
	'ore-titanium',
	'ore-zinc',
	'raw-coal',
	'ore-bioreserve',
	'niobium',
	'borax',
	'oil-sand',
	'molybdenum-ore',
	-- Also turn off all the resources we programatically generate
	'iron-rock',
	'copper-rock',
	'uranium-rock',
	'zinc-rock',
	'aluminium-rock',
	'chromium-rock',
	'coal-rock',
	'lead-rock',
	'nexelit-rock',
	'nickel-rock',
	'phosphate-rock-02',
	'quartz-rock',
	'salt-rock',
	'tin-rock',
	'titanium-rock',
	'volcanic-pipe',
	'regolites',
	'rare-earth-bolide',
	'phosphate-rock',
	'sulfur-patch',
	'oil-mk01',
	'oil-mk02',
	'oil-mk03',
	'oil-mk04',
	'tar-patch'
}

for _, ore in ipairs(ores) do
	data.raw.resource[ore].autoplace = nil
	data.raw['autoplace-control'][ore] = nil

	for _, preset in pairs(data.raw['map-gen-presets']['default']) do
		if preset and preset.basic_settings and preset.basic_settings.autoplace_controls and preset.basic_settings.autoplace_controls[ore] then
		  preset.basic_settings.autoplace_controls[ore] = nil
		end
	end
end