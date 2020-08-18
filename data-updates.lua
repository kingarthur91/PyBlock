local fun = require('functions/functions')
require('prototypes/updates/pyhightech-updates')
require('prototypes/updates/pyalienlife-updates')
require('prototypes/updates/ddc-coal-updates')
require('prototypes/updates/generator-updates')

RECIPE("bio-reactor"):replace_ingredient('advanced-circuit','electronic-circuit')

--fun.ingredient_replace('botanical-nursery', 'soil-extractormk01', 'burner-soil-extractor')
data.raw.recipe['botanical-nursery'].ingredients = {
	{"electric-mining-drill", 1},
	{"burner-soil-extractor", 1},
	{"electronic-circuit", 5},
	{"wood", 25},
	{"iron-plate", 15}
}

--TODO:make early copper plate for begining buildings. //idk if im make cheaper copper as copper is low use and proably be ok with the basic 10:1 to start after scrap supply is used up

--adjust landfill cost for landfill painter
if mods['LandfillPainting'] then
	local recipe_list = {
		'landfill-dry-dirt',
		'landfill-dirt-4',
		'landfill-grass-1',
		'landfill-red-desert-1',
		'landfill-sand-3',
		}
		for _, recipe in pairs(recipe_list) do
			RECIPE(recipe):remove_ingredient('stone'):add_ingredient({type = "item", name = 'stone', amount = 1}):add_ingredient({type = "item", name ='sand', amount = 2})
		end
end


--change nichrome to be availble earlier

for i,ing in pairs(data.raw.recipe["nichrome"].ingredients) do

	if ing.name == "nitrogen" then

		data.raw.recipe["nichrome"].ingredients[i] = nil

	end

end

data.raw.recipe["nichrome"].category = "smelting"

if mods["angelsrefining"] then

data.raw.recipe["angelsore5-crushed-smelting"].normal.results[1] = nil
data.raw.recipe["angelsore5-crushed-smelting"].normal.results[1]= {type = "item", name = "aluminium-plate", amount = 1}

end

--fix localization for crushed rubyte lead plate
