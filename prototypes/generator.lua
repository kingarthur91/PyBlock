
for _,v in pairs(data.raw.tile) do
  v.autoplace = nil
end

-- Want player to collide with cliffs
-- Want player to collide with water
-- Don't want cliffs to collide with water
-- Water tile's default collision mask includes player-layer and item-layer
-- So use train-layer as a substitute player-layer
data.raw.cliff['cliff'].collision_mask =
  {"object-layer", "train-layer", "not-colliding-with-itself"}

local octaves = -3
local persistence = 0.2
local waterline = 11.4
local elevation_scale = 5

local function scale_elevation(x)
  return (x - waterline) * elevation_scale + waterline
end
-- low lying sand
data.raw.tile['sand-1'].autoplace = {
  peaks = {
  { -- Around cliff islands
    influence = 5,
    elevation_optimal = 0.3 * elevation_scale + waterline,
    elevation_range = 0.4 * elevation_scale,
    elevation_max_range = 4.4 * elevation_scale
  },
  { -- Not in starting area
    influence = -5,
    starting_area_weight_optimal = 1,
    starting_area_weight_range = 0,
    starting_area_weight_max_range = 0
  },
  {
    influence = 100, -- ... except for starting tile
    min_influence = 0,
    distance_optimal = 0,
    distance_range = 0.1,
    distance_max_range = 0.1
  },
  {
    influence = -5
  }
}}

-- highground sand
data.raw.tile['sand-2'].autoplace = {
  peaks = {
  {
    influence = 5,
    min_influence = 0,
    elevation_optimal = scale_elevation(15),
    elevation_range = 5 * elevation_scale,
    elevation_max_range = 5 * elevation_scale,
    tier_from_start_optimal = 0.1,
    tier_from_start_range = 0,
    tier_from_start_max_range = 0,
    tier_from_start_top_property_limit = 0.1
  },
  {
    influence = 1,
    max_influence = 0,
    starting_area_weight_optimal = 1,
    starting_area_weight_range = 0,
    starting_area_weight_max_range = 0
  },
  {
    influence = -100, -- not on starting tile
    max_influence = 0,
    distance_optimal = 0,
    distance_range = 3,
    distance_max_range = 3
  },
}}

data.raw.tile['water'].autoplace = {
  peaks = {
  {
    influence = 0.1, -- shallow water around cliff islands
    min_influence = 0,
    elevation_optimal = -4 * elevation_scale + waterline,
    elevation_range = 3.5 * elevation_scale,
    elevation_max_range = 3.5 * elevation_scale
  },
  {
    influence = 5, -- around starting tile
    min_influence = 0,
    distance_optimal = 0,
    distance_range = 5,
    distance_max_range = 5
  }
}}

data.raw.tile['deepwater'].autoplace = {
  peaks = {
  {
    influence = 0.01
  }
}}

local noise = require "noise"
local tne = noise.to_noise_expression


local function make_basis_noise_function(seed0,seed1,outscale0,inscale0)
  outscale0 = outscale0 or 1
  inscale0 = inscale0 or 1/outscale0
  return function(x,y,inscale,outscale)
    return tne{
      type = "function-application",
      function_name = "factorio-basis-noise",
      arguments = {
        x = tne(x),
        y = tne(y),
        seed0 = tne(seed0),
        seed1 = tne(seed1),
        input_scale = tne((inscale or 1) * inscale0),
        output_scale = tne((outscale or 1) * outscale0)
      }
    }
  end
end

data.raw['noise-expression']['cliffiness'].expression =
  noise.define_noise_function(function(x, y, tile, map)
    local t = noise.clamp(tile.tier - 0.2, 0, 1) -- No cliffs in starting area
    return 100 * t
  end)
data.raw['noise-expression']['elevation'].expression =
  noise.define_noise_function(function(x, y, tile, map)
      x = x + 40000
      y = y
      local v = make_basis_noise_function(map.seed, 5, 6, 1/112)(x, y)
      v = noise.max(v, 0)
      v = (v * elevation_scale) - (waterline * (elevation_scale - 1)) -- Increase gradient for cliffs while leaving waterline unchanged
      return v
  end)
