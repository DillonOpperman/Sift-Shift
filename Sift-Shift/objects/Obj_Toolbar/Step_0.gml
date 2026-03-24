// 1. Exit if Paused (Prevents building/scrolling while in menus)
if (instance_exists(obj_pause)) {
    var _pause_inst = instance_find(obj_pause, 0);
    if (_pause_inst.is_paused) exit;
}

// 2. Number Key Selection
if (keyboard_check_pressed(ord("1"))) selected_index = 0;
if (keyboard_check_pressed(ord("2"))) selected_index = 1;
if (keyboard_check_pressed(ord("3"))) selected_index = 2;
if (keyboard_check_pressed(ord("4"))) selected_index = 3;

// 3. Mouse Wheel Selection
var _wheel = mouse_wheel_down() - mouse_wheel_up();
if (_wheel != 0) {
    selected_index += _wheel;
    
    // Wrap around logic using the CORRECT variable name: options_names
    var _count = array_length(options_names);
    if (selected_index < 0) selected_index = _count - 1;
    if (selected_index >= _count) selected_index = 0;
}