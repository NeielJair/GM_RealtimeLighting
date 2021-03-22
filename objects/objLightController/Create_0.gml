/// @description Init
RawLightSurf = -1;
LightQueue = ds_queue_create();
TilemapLayer = [layer_tilemap_get_id("Tiles_1"), layer_tilemap_get_id("Tiles_2")];
TilemapOpacityGrid = -1;
Tilesize = 8;
BacksurfRenderer = instance_create_depth(0, 0, 99, objBacksurfRenderer);

global.AmbientColor = c_blue;
global.AmbientAlpha = .75;