map_width  = room_width  / 32;
map_height = room_height / 32;

//Cell size = size of blobs, thresh = frequency of blobs


//Determines where each biome fits on the noise map, default is grass
var biome_ranges = [
    { name: "DarkGrass", min: 0.45, max: 0.60, tile: 7  },
    { name: "Sand",      min: 0.60, max: 0.75, tile: 36 },
    { name: "DarkSand",  min: 0.75, max: 1.00, tile: 37 },
];
var default_tile  = 18;
var biome_cell    = 18;  // Controls the scale of biome regions

//Determines size and frequency of detailed tiles
var detail_tiles = [
    { name: "GrassRock",   on_tile: 18, cell: 4, thresh: 0.92, tile: 48  },
    { name: "DesertPlant", on_tile: 36, cell: 5, thresh: 0.90, tile: 64 },
	{ name: "GrassTrees", on_tile: 18, cell: 2, thresh: 0.80, tile: 32 }
];

var resource_tiles = [
    { name: "Copper",   cell: 8, thresh: 0.94, tile: 1 },
    { name: "Iron", cell: 4, thresh: 0.92, tile: 2 },
	{ name: "Tin", cell: 2, thresh: 0.96, tile: 3 },
	{ name: "Silver", cell: 2, thresh: 0.98, tile: 5 },
	{ name: "SmallTrees", cell: 2, thresh: 0.90, tile: 11 },
	{ name: "BigTrees", cell: 2, thresh: 0.90, tile: 12 },
];

randomise();

// Shared seed grid for all biomes
var bsw = ceil(map_width  / biome_cell) + 1;
var bsh = ceil(map_height / biome_cell) + 1;
var biome_grid;
for (var sx = 0; sx < bsw; sx++) {
    for (var sy = 0; sy < bsh; sy++) {
        biome_grid[sx, sy] = random(1);
    }
}

// Separate seed grid per detail tile
var detail_seed_grids = [];
for (var i = 0; i < array_length(detail_tiles); i++) {
    var d  = detail_tiles[i];
    var sw = ceil(map_width  / d.cell) + 1;
    var sh = ceil(map_height / d.cell) + 1;
    var grid;
    for (var sx = 0; sx < sw; sx++) {
        for (var sy = 0; sy < sh; sy++) {
            grid[sx, sy] = random(1);
        }
    }
    detail_seed_grids[i] = grid;
}

// Separate seed grid per resource
var res_seed_grids = [];
for (var i = 0; i < array_length(resource_tiles); i++) {
    var t  = resource_tiles[i];
    var sw = ceil(map_width  / t.cell) + 1;
    var sh = ceil(map_height / t.cell) + 1;
    var grid;
    for (var sx = 0; sx < sw; sx++) {
        for (var sy = 0; sy < sh; sy++) {
            grid[sx, sy] = random(1);
        }
    }
    res_seed_grids[i] = grid;
}

var tm_base     = layer_tilemap_get_id("Tiles_Base");
var tm_resource = layer_tilemap_get_id("Tiles_Resource");
var tm_buyable = layer_tilemap_get_id("Tiles_Buyable");


//base and deatil loop
for (var tx = 0; tx < map_width; tx++) {
    for (var ty = 0; ty < map_height; ty++) {

        // Sample the shared biome noise grid
        var sample_x = tx / biome_cell;
        var sample_y = ty / biome_cell;
        var cx = floor(sample_x);
        var cy = floor(sample_y);
        var lx = sample_x - cx;
        var ly = sample_y - cy;
        var sxw = lx * lx * (3 - 2 * lx);
        var syw = ly * ly * (3 - 2 * ly);
        var biome_val = lerp(
            lerp(biome_grid[cx,     cy    ], biome_grid[cx + 1, cy    ], sxw),
            lerp(biome_grid[cx,     cy + 1], biome_grid[cx + 1, cy + 1], sxw),
            syw
        );

        // Find which biome this value belongs to
        var final_tile = default_tile;
        for (var i = 0; i < array_length(biome_ranges); i++) {
            var b = biome_ranges[i];
            if (biome_val >= b.min && biome_val < b.max) {
                final_tile = b.tile;
                break;
            }
        }

        // Places detail tiles if the base tile matches
        for (var i = 0; i < array_length(detail_tiles); i++) {
            var d    = detail_tiles[i];
            var grid = detail_seed_grids[i];
            
            // Skip if this detail doesnt belong on the current biome tile
            if (d.on_tile != final_tile) continue;
            
            var dsample_x = tx / d.cell;
            var dsample_y = ty / d.cell;
            var dcx = floor(dsample_x);
            var dcy = floor(dsample_y);
            var dlx = dsample_x - dcx;
            var dly = dsample_y - dcy;
            var dsxw = dlx * dlx * (3 - 2 * dlx);
            var dsyw = dly * dly * (3 - 2 * dly);
            var detail_val = lerp(
                lerp(grid[dcx,     dcy    ], grid[dcx + 1, dcy    ], dsxw),
                lerp(grid[dcx,     dcy + 1], grid[dcx + 1, dcy + 1], dsxw),
                dsyw
            );
            if (detail_val > d.thresh) {
                final_tile = d.tile;
                break;
            }
        }

        tilemap_set(tm_base, final_tile, tx, ty); //places base and detail tiles
		tilemap_set(tm_buyable, 17, tx, ty);
    }
}

//resource loop
for (var tx = 0; tx < map_width; tx++) {
    for (var ty = 0; ty < map_height; ty++) {
        var final_tile = 0;
        for (var i = 0; i < array_length(resource_tiles); i++) {
            var t    = resource_tiles[i];
            var grid = res_seed_grids[i];
            var sample_x = tx / t.cell;
            var sample_y = ty / t.cell;
            var cx = floor(sample_x);
            var cy = floor(sample_y);
            var lx = sample_x - cx;
            var ly = sample_y - cy;
            var sxw = lx * lx * (3 - 2 * lx);
            var syw = ly * ly * (3 - 2 * ly);
            var noise_val = lerp(
                lerp(grid[cx,     cy    ], grid[cx + 1, cy    ], sxw),
                lerp(grid[cx,     cy + 1], grid[cx + 1, cy + 1], sxw),
                syw
            );
            if (noise_val > t.thresh) {
                final_tile = t.tile;
            }
        }
        tilemap_set(tm_resource, final_tile, tx, ty);
    }
}

//Hardcodes the start area to always have one copper ore spawn
var start_size = 4;
var ssx = floor(map_width  / 2);
var ssy = floor(map_height / 2);
for (var tx = ssx - start_size; tx < ssx + start_size; tx++) {
    for (var ty = ssy - start_size; ty < ssy + start_size; ty++) {
        tilemap_set(tm_base,     114, tx, ty);
        tilemap_set(tm_resource, 0,   tx, ty);
		tilemap_set(tm_buyable, 0, tx, ty);
    }
}
var sCopperX = ssx + irandom_range(-start_size + 1, start_size - 1);
var sCopperY = ssy + irandom_range(-start_size + 1, start_size - 1);
tilemap_set(tm_resource, 2, sCopperX, sCopperY);