// 1. Exit if Paused (Prevents building while in menus)
if (instance_exists(obj_pause)) {
    if (obj_pause.is_paused) exit;
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
    // Wrap around logic
    if (selected_index < 0) selected_index = array_length(options) - 1;
    if (selected_index >= array_length(options)) selected_index = 0;
}