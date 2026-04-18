// WASD camera panning
if keyboard_check(ord("W")) view_y -= 5;
if keyboard_check(ord("A")) view_x -= 5;
if keyboard_check(ord("S")) view_y += 5;
if keyboard_check(ord("D")) view_x += 5;
 
// Apply position
camera_set_view_pos(view_get_camera(0), view_x, view_y);
 
// Mouse wheel zoom
var _inv_hover = (variable_global_exists("_mouse_over_inv") && global._mouse_over_inv);
 
if (!_inv_hover) {
    if (mouse_wheel_up()) {
        cam_height -= 18;
        cam_width  -= 32;
    }
    if (mouse_wheel_down()) {
        cam_height += 18;
        cam_width  += 32;
    }
}
 
// Apply zoom
camera_set_view_size(view_get_camera(0), cam_width, cam_height);
 