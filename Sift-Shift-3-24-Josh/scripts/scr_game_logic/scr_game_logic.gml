function scr_game_logic(){
	
	function scr_save_game() {
    ini_open("SaveData.ini");
    ini_write_real("Player", "Money", global.money);
    
    ini_section_delete("Buildings"); // Clear old save
    var _count = 0;
    with (par_building) { 
        ini_write_string("Buildings", "Type" + string(_count), object_get_name(object_index));
        ini_write_real("Buildings", "X" + string(_count), x);
        ini_write_real("Buildings", "Y" + string(_count), y);
        _count++;
    }
    ini_write_real("Buildings", "Total", _count);
    ini_close();
    show_debug_message("Game Saved!");
}

function scr_load_game() {
    if (file_exists("SaveData.ini")) {
        ini_open("SaveData.ini");
        global.money = ini_read_real("Player", "Money", 100);
        instance_destroy(par_building); // Clear current room
        
        var _total = ini_read_real("Buildings", "Total", 0);
        for (var i = 0; i < _total; i++) {
            var _type = ini_read_string("Buildings", "Type" + string(i), "");
            var _lx = ini_read_real("Buildings", "X" + string(i), 0);
            var _ly = ini_read_real("Buildings", "Y" + string(i), 0);
            var _obj_id = asset_get_index(_type);
            if (object_exists(_obj_id)) {
                instance_create_layer(_lx, _ly, "Instances", _obj_id);
            }
        }
        ini_close();
        show_debug_message("Game Loaded!");
    }
}

}