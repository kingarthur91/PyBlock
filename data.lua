
--buildings--
require('prototypes/buildings/atomizer-mk00')
require('prototypes/buildings/automated-screener-mk00')
require('prototypes/buildings/basic-ddc')
require('prototypes/buildings/bqt')
require('prototypes/buildings/burner-soil-extractor')
require('prototypes/buildings/burner-washer')
require('prototypes/buildings/burner-wpu')
require('prototypes/buildings/compost-plant-mk00')
require('prototypes/buildings/early-copper-mine')
require('prototypes/buildings/early-iron-mine')
require('prototypes/buildings/fish-farm-mk00')
require('prototypes/buildings/fwf-mk00')
require('prototypes/buildings/slaughterhouse-mk00')
require('prototypes/buildings/seaweed-crop-mk00')

--fix the goddamn ore numbers
require("functions/functions")
require("prototypes/itemgroups")
require("prototypes/recipe-categories")
require("prototypes/technology")
require("prototypes/item")
require("prototypes/fluids")
require("prototypes/entity")
require("prototypes/recipes")
--require("autoplace-controls")
--require("prototypes/overrides/angel-recipe-overrides")
--require("prototypes/overrides/angel-tech-overrides")

require("prototypes/generator")


--formula to calulate steam consumption
--flowrate (in units/s) * heat capacity (J/unit/C) * (T - 15 C) = wattage

--x * 200 * (165 - 15) = 500,000

-- x = 500kw / ( 200 * (165 - 15))
--x = 16.67/s steam
