#macro SAVE_SLOT_COUNT  3
#macro SAVE_PREFIX      "siftshift_slot_"
#macro SAVE_EXT         ".sav"
 
/// Returns the filename for a given slot (1–3)
function save_filename(_slot) {
    return SAVE_PREFIX + string(_slot) + SAVE_EXT;
}
 
/// Returns true if a save file exists for this slot
function save_exists(_slot) {
    return file_exists(save_filename(_slot));
}
 
/// Returns a struct with slot metadata, or undefined if no save
function save_get_info(_slot) {
    var _fname = save_filename(_slot);
    if (!file_exists(_fname)) return undefined;
 
    var _buff = buffer_load(_fname);
    if (_buff < 0) return undefined;
    var _str  = buffer_read(_buff, buffer_string);
    buffer_delete(_buff);
 
    var _data = json_parse(_str);
    if (_data == undefined) return undefined;
    if (variable_struct_exists(_data, "meta")) return _data.meta;
    return { slot: _slot, timestamp: "Unknown" };
}
 
/// Deletes the save file for a slot
function save_delete(_slot) {
    var _fname = save_filename(_slot);
    if (file_exists(_fname)) file_delete(_fname);
}
 
 
// ─────────────────────────────────────────────────────────────
// Building types used by save/load/reset
// ─────────────────────────────────────────────────────────────
function _get_building_types() {
    return [Obj_Belt, Obj_Mine, Obj_Smelter, Obj_Blacksmith,
            Obj_Sawmill, Obj_Timbermill, Obj_Warehouse];
}
 
 
/// ─── SAVE GAME ──────────────────────────────────────────────
function save_game(_slot) {
    show_debug_message("save_game() → slot " + string(_slot));
 
    // ── Resources ──────────────────────────────────────────
    var _resources = {
        copper: variable_global_exists("copper") ? global.copper : 0,
        iron:   variable_global_exists("iron")   ? global.iron   : 0,
        tin:    variable_global_exists("tin")     ? global.tin    : 0,
        bronze: variable_global_exists("bronze")  ? global.bronze : 0,
        silver: variable_global_exists("silver")  ? global.silver : 0,
        gold:   variable_global_exists("gold")    ? global.gold   : 0,
        money:  variable_global_exists("money")   ? global.money  : 100
    };
 
    // ── Buildings ──────────────────────────────────────────
    var _building_types = _get_building_types();
    var _buildings = [];
 
    // Activate all building types so we can read them
    for (var t = 0; t < array_length(_building_types); t++) {
        instance_activate_object(_building_types[t]);
    }
 
    // Iterate and collect data
    for (var t = 0; t < array_length(_building_types); t++) {
        var _obj = _building_types[t];
        with (_obj) {
            var _entry = {
                obj_name: object_get_name(object_index),
                px: x,
                py: y
            };
            if (object_index == Obj_Belt) {
                _entry[$ "dir"] = variable_instance_exists(id, "dir") ? dir : 0;
            }
            array_push(_buildings, _entry);
        }
    }
 
    show_debug_message("  buildings: " + string(array_length(_buildings)));
 
    // Re-deactivate (we're saving from the pause menu)
    for (var t = 0; t < array_length(_building_types); t++) {
        instance_deactivate_object(_building_types[t]);
    }
 
    // ── Full Tilemap ──────────────────────────────────────
    // Save EVERY cell of Tiles_Buyable so we can fully restore it on load
    var _tilemap = [];
    var _layer_id = layer_get_id("Tiles_Buyable");
    if (_layer_id != -1) {
        var _map_id = layer_tilemap_get_id(_layer_id);
        if (_map_id != -1) {
            var _tw = tilemap_get_width(_map_id);
            var _th = tilemap_get_height(_map_id);
            // Store dimensions + flat array of all tile values
            _tilemap = [_tw, _th];
            for (var ty = 0; ty < _th; ty++) {
                for (var tx = 0; tx < _tw; tx++) {
                    array_push(_tilemap, tilemap_get(_map_id, tx, ty));
                }
            }
            show_debug_message("  tilemap: " + string(_tw) + "x" + string(_th));
        }
    }
 
    // ── Write ──────────────────────────────────────────────
    var _save_data = {
        meta: {
            slot:      _slot,
            timestamp: string(current_year) + "-"
                     + (current_month < 10 ? "0" : "") + string(current_month) + "-"
                     + (current_day < 10 ? "0" : "") + string(current_day)
                     + "  " + string(current_hour) + ":"
                     + (current_minute < 10 ? "0" : "") + string(current_minute),
            version:   3
        },
        resources: _resources,
        buildings: _buildings,
        tilemap:   _tilemap
    };
 
    var _json  = json_stringify(_save_data);
    var _fname = save_filename(_slot);
    var _buff  = buffer_create(string_byte_length(_json) + 1, buffer_fixed, 1);
    buffer_write(_buff, buffer_string, _json);
    buffer_save(_buff, _fname);
    buffer_delete(_buff);
 
    show_debug_message("save_game() COMPLETE → " + _fname);
    return true;
}
 
 
/// ─── LOAD GAME (direct apply — no room restart) ────────────
/// Reads a save file, destroys current buildings, restores
/// everything in place. Call this while instances are ACTIVE.
function load_game(_slot) {
    var _fname = save_filename(_slot);
    show_debug_message("load_game() → " + _fname);
 
    if (!file_exists(_fname)) {
        show_debug_message("  file not found");
        return false;
    }
 
    var _buff = buffer_load(_fname);
    if (_buff < 0) return false;
    var _str  = buffer_read(_buff, buffer_string);
    buffer_delete(_buff);
 
    var _data = json_parse(_str);
    if (_data == undefined) {
        show_debug_message("  corrupt JSON");
        return false;
    }
 
    // ── 1. Destroy existing buildings + ores ───────────────
    var _building_types = _get_building_types();
    for (var t = 0; t < array_length(_building_types); t++) {
        with (_building_types[t]) { instance_destroy(); }
    }
    with (Obj_Resource_Controller) { instance_destroy(); }
 
    show_debug_message("  existing buildings destroyed");
 
    // ── 2. Apply resources ─────────────────────────────────
    if (variable_struct_exists(_data, "resources")) {
        var _r = _data.resources;
        global.copper = variable_struct_exists(_r, "copper") ? _r.copper : 0;
        global.iron   = variable_struct_exists(_r, "iron")   ? _r.iron   : 0;
        global.tin    = variable_struct_exists(_r, "tin")     ? _r.tin    : 0;
        global.bronze = variable_struct_exists(_r, "bronze")  ? _r.bronze : 0;
        global.silver = variable_struct_exists(_r, "silver")  ? _r.silver : 0;
        global.gold   = variable_struct_exists(_r, "gold")    ? _r.gold   : 0;
        global.money  = variable_struct_exists(_r, "money")   ? _r.money  : 100;
        show_debug_message("  resources: copper=" + string(global.copper)
            + " iron=" + string(global.iron) + " money=" + string(global.money));
    }
 
    // ── 3. Recreate buildings ──────────────────────────────
    if (variable_struct_exists(_data, "buildings")) {
        var _b     = _data.buildings;
        var _layer = layer_get_id("In_Factory");
        show_debug_message("  recreating " + string(array_length(_b)) + " buildings");
 
        for (var i = 0; i < array_length(_b); i++) {
            var _entry   = _b[i];
            var _obj_idx = asset_get_index(_entry.obj_name);
            if (object_exists(_obj_idx)) {
                var _inst = instance_create_layer(_entry.px, _entry.py, _layer, _obj_idx);
                if (_obj_idx == Obj_Belt && variable_struct_exists(_entry, "dir")) {
                    _inst.dir = _entry.dir;
                }
            }
        }
    }
 
    // ── 4. Restore full tilemap ────────────────────────────
    if (variable_struct_exists(_data, "tilemap")) {
        var _tm = _data.tilemap;
        if (is_array(_tm) && array_length(_tm) >= 2) {
            var _tw = _tm[0];
            var _th = _tm[1];
            var _layer_id = layer_get_id("Tiles_Buyable");
            if (_layer_id != -1) {
                var _map_id = layer_tilemap_get_id(_layer_id);
                if (_map_id != -1) {
                    var _idx = 2;  // tile data starts at index 2
                    for (var ty = 0; ty < _th; ty++) {
                        for (var tx = 0; tx < _tw; tx++) {
                            if (_idx < array_length(_tm)) {
                                tilemap_set(_map_id, _tm[_idx], tx, ty);
                                _idx++;
                            }
                        }
                    }
                    show_debug_message("  tilemap restored: " + string(_tw) + "x" + string(_th));
                }
            }
        }
    }
    // Also handle older saves that used "cleared_tiles" format
    else if (variable_struct_exists(_data, "cleared_tiles")) {
        var _tiles    = _data.cleared_tiles;
        var _layer_id = layer_get_id("Tiles_Buyable");
        if (_layer_id != -1) {
            var _map_id = layer_tilemap_get_id(_layer_id);
            if (_map_id != -1) {
                for (var i = 0; i < array_length(_tiles); i++) {
                    var _t = _tiles[i];
                    tilemap_set(_map_id, 0, _t[0], _t[1]);
                }
            }
        }
    }
 
    show_debug_message("load_game() COMPLETE");
    return true;
}
 
 
/// ─── RESET GAME STATE ──────────────────────────────────────
/// Resets resource globals to starting values.
/// Tiles and buildings are reset by room_goto(Room1).
function reset_game_state() {
    global.copper = 20;
    global.iron   = 0;
    global.tin    = 0;
    global.bronze = 0;
    global.silver = 0;
    global.gold   = 0;
    global.money  = 100;
}