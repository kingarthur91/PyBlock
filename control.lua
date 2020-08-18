--require("functions/autobuilder")

require "util"

--rare earth and moly need to show up around sci 2

local startchunk = false

local surface

local X = -1
local Y = -1

local Tiles = {}

script.on_init(function(event)

--do first delete everything in the chunk + set it to water only

local oldtiles = {}

local waters =
	{
	"water",
	"deepwater",
	--"deepwater-green",
	--"water-green",
	--"water-shallow",
	--"water-mud",
	}

local tx = -32
local ty = -32

local bx = 32
local by = 32

local fx = tx
local fy = ty

--setup spawn area

global.firstrock = true
global.secondrock = true

local t

end)

local crashedshipparts =
		{
		"big-ship-wreck-1",
		"big-ship-wreck-2",
		"big-ship-wreck-3",
		"medium-ship-wreck",
		"small-ship-wreck"
		}

script.on_event(defines.events.on_player_created, function(event)

  local player = game.players[event.player_index]

  --game.show_message_dialog{text = {"intro"}}

  player.insert({name="landfill", count=1000})
  player.insert({name="stone", count=400})
  player.insert({name="wood", count=100})
  --player.insert({name="iron-axe", count=1})
  --[[
  player.insert({name="quenching-tower", count=1})
  player.insert({name="botanical-nursery", count=1})
  player.insert({name="distilator", count=1})
  player.insert({name="offshore-pump", count=1})
  player.insert({name="iron-plate", count=92})
  player.insert({name="copper-plate", count=50})
  player.insert({name="copper-plate", count=50})
  player.insert({name="washer", count=1})
  player.insert({name="wpu", count=1})
  player.insert({name="stone-furnace", count=2})
  player.insert({name="py-sinkhole", count=2})
  player.insert({name="py-gas-vent", count=2})
  ]]--

  player.remove_item("iron-plate")
  player.remove_item("stone-furnace")
  player.remove_item("burner-mining-drill")

  local shippieces = math.random(8,14)

  local cs

  local firstcon=true

  for a=1,shippieces do

  local pickedpiece = crashedshipparts[math.random(1,5)]

  local x = math.random(-25,25)
  local y = math.random(-25,25)

  local cs = game.surfaces["nauvis"].create_entity{name=pickedpiece,position={x,y},force=game.players[1].force}

  --cs.insert({name = "scrap-iron", count = 400})
  --cs.insert({name = "scrap-copper", count = 50})

	  if cs.type == "container" and firstcon == true then

		cs.insert({name = "stone-furnace", count = 1})
		cs.insert({name="py-sinkhole", count=2})
		cs.insert({name="py-gas-vent", count=2})
		cs.insert({name = "scrap-iron", count = 400})

	  firstcon = false

	  end

  end

end)

--[[
script.on_event(defines.events.on_player_respawned, function(event)

  local player = game.players[event.player_index]

  --player.insert({name="quenching-tower", count=1})
  --player.insert({name="botanical-nursery", count=1})
  --player.insert({name="distilator", count=1})
  --player.insert({name="offshore-pump", count=1})
  --player.insert({name="iron-plate", count=92})
  --player.insert({name="copper-plate", count=50})
  --player.insert({name="landfill", count=1000})
  --player.insert({name="washer", count=1})
  --player.insert({name="wood", count=100})
  --player.insert({name="wpu", count=1})
  --player.insert({name="stone-furnace", count=1})
  --player.insert({name="py-sinkhole", count=1})

end)
]]--

local Rocks =
	{
	"iron-rock",
	"copper-rock",
	"uranium-rock",
	"zinc-rock",
	"aluminium-rock",
	"chromium-rock",
	"coal-rock",
	"lead-rock",
	"nexelit-rock",
	"nickel-rock",
	"phosphate-rock-02",
	"quartz-rock",
	"salt-rock",
	"tin-rock",
	"titanium-rock",
	"volcanic-pipe",
	"regolites",
	"rare-earth-bolide",
	"phosphate-rock",
	"sulfur-patch",
	"oil-mk01",
	"oil-mk02",
	"oil-mk03",
	"oil-mk04",
	"tar-patch"
	}

-- Create a set of the rock types, for quick determination so they don't accidentally get deleted when the next chunk generates
local function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

local RocksSet = Set(Rocks)

--local firstrock = true

local loot_table_fuelrod =
	{
		'fuelrod-mk01',
		'fuelrod-mk02',
		'fuelrod-mk03',
		'fuelrod-mk04',
		'fuelrod-mk05'
	}

local loot_table_plates =
	{
		'iron-plate',
		'copper-plate',
		'duralumin',
		'steel-plate',
		'pb-wrought-iron-plate',
		'chromium',
		'super-steel',
		'landfill'
	}

local loot_table_basic_mats =
	{
		'stone',
		'wood',
		'stone-brick',
		'iron-ore',
		'ore-aluminium',
		'ore-nickel',
		'ore-quartz',
		'ore-zinc',
		'ore-titanium',
		'ore-chromium',
		'raw-coal'
	}

script.on_event(defines.events.on_chunk_generated, function(event)

--getting chunk bounds

local tx = event.area.left_top.x
local ty = event.area.left_top.y
local bx = event.area.right_bottom.x
local by = event.area.right_bottom.y

--log(serpent.block(event.area))
--do first delete everything in the chunk + set it to water only
if tx == -32 and ty == -32 then
	--log("was start chunk")
	--log(serpent.block(event.area))
elseif tx == -32 and ty == 0 then
	--log("was start chunk")
	--log(serpent.block(event.area))
elseif tx == 0 and ty == -32 then
	--log("was start chunk")
	--log(serpent.block(event.area))
elseif tx == 0 and ty == 0 then
	--log("was start chunk")
	--log(serpent.block(event.area))
else

		local crap = game.surfaces["nauvis"].find_entities({{tx,ty},{bx,by}})

		for _,c in pairs(crap) do

			--log(serpent.block(c))
			--log(serpent.block(c.name))
			--log(serpent.block(c.position))

			if RocksSet[c.name] == nil and c.name ~= 'seaweed' and c.name ~= 'fish' then
			--log('destroying')
			c.destroy()

			end

		end

		local oldtiles = {}

		local waters =
			{
			"water",
			"deepwater",
			--"deepwater-green",
			--"water-green",
			--"water-shallow",
			--"water-mud",
			}

		local fx = tx
		local fy = ty

end

-- -----------------------------------------------------------------------------------------------------------------------------
-- Helper Functions
-- -----------------------------------------------------------------------------------------------------------------------------

	-- Multiply the amount certain resources have
	-- Separate this into a second function for easy extention
	local function amplifyAmountBasedOnRock(rock, amount)

		if rock == 'oil-mk01' or rock == 'oil-mk02' or rock == 'oil-mk03' or rock == 'oil-mk04' or rock == 'tar-patch' then
			return amount * 4
		end
		
		return amount

	end

	-- Caluclate the distance the possible placement position is from the starting area, calculate amount based on this distance
	local function getDistanceBasedAmount(position, rock)

		function calculateFactor(distance, exponent)
			if distance< 1 and exponent < 1 then
				return distance
			end
			
			return distance^exponent
		end
		
		amount = 1000 * calculateFactor(util.distance({x=0, y=0},
					{x = math.abs(position.x), y = math.abs(position.y)}), 1.05)

		amount = math.floor(amount)
		
		amount = amplifyAmountBasedOnRock(rock, amount)
		
		if amount > 1e9 then
			amount = 1e9
		elseif amount < 250000 then
			amount = math.random(250000, 400000)
		end
		
		return amount

	end

-- -----------------------------------------------------------------------------------------------------------------------------
-- Place resources on generated islands
-- -----------------------------------------------------------------------------------------------------------------------------

local placementChance = math.random(1,5)
local rockSelection = 0
local forcePlace = false

	-- Determine Resource
	if global.firstrock == true then
		rockSelection = 1
		forcePlace = true
	elseif global.secondrock == true and global.firstrock == false then
		rockSelection = 2
		forcePlace = true
	else
		rockSelection = math.random(1,25)
	end

	-- Determine if the Resource can be placed, 
	local possiblePosition = event.surface.find_non_colliding_position_in_box(Rocks[rockSelection], event.area, 1)

	if possiblePosition ~= nil then
		
		local canPlaceEntity = event.surface.can_place_entity{name=Rocks[rockSelection], position=possiblePosition}
		
		-- If there are no other resources nearby, roll the chance to place the resource
		local nearbyEntities = event.surface.find_entities_filtered{position=possiblePosition, radius=25, name=Rocks, limit=1}

		if canPlaceEntity == true and nearbyEntities ~= nil and #nearbyEntities == 0 then
			if forcePlace == true or placementChance == 1 then
			
				local amount
			
				-- Now that we have confirmed that we can generate a resource, determine the amount
				if settings.startup["pyblock-ore-distance-richness"].value then
					amount = getDistanceBasedAmount(possiblePosition, Rocks[rockSelection])
				else
					-- Base generation setting
					amount = amplifyAmountBasedOnRock(Rocks[rockSelection], math.random(250000,1000000))
				end
		
				local entity = game.surfaces["nauvis"].create_entity{name=Rocks[rockSelection], position=possiblePosition, amount=amount}
				
				if entity ~= nil and global.firstrock == true then
					global.firstrock = false
				elseif entity ~= nil and global.secondrock == true and global.firstrock == false then
					global.secondrock = false
				end
			end
		end
	end
	
-- -----------------------------------------------------------------------------------------------------------------------------
-- Place ship parts in chunk
-- -----------------------------------------------------------------------------------------------------------------------------

local RandChance = math.random(0,240)

	if RandChance == 6 then
		local ship = game.surfaces['nauvis'].create_entity{name = crashedshipparts[math.random(1,3)], position={math.random(tx+3,bx-3),math.random(ty+3,by-3)}, force=game.players[1].force}
		local loot_rand_pick = math.random(1,25) 
		if loot_rand_pick > 20 and loot_rand_pick <= 25 then
			local rand = math.random(1,5)
			ship.insert({name = loot_table_fuelrod[rand], count = math.random(1,6)})
		elseif loot_rand_pick > 10 and loot_rand_pick < 20 then
			local rand = math.random(1,8)
			ship.insert({name = loot_table_plates[rand], count = math.random(25,100)})
		elseif loot_rand_pick > 0 and loot_rand_pick < 10 then
			local rand = math.random(1,11)
			ship.insert({name = loot_table_basic_mats[rand], count = math.random(100,500)})
		end
	end
end)
