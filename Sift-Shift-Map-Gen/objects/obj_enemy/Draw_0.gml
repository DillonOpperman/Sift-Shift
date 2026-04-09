// Draw the character's shadow
draw_sprite_ext(Character_Shadow, 0, x, y + 191.2, 1, 1, 0, c_white, image_alpha);

// Draw the aura particle system
part_system_drawit(particle);

// Draw the enemy - if it's on fire, give it a red hue
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, onfire ? c_red : c_white, image_alpha);

// Make the eyes have the same transparency as the actual insect
part_system_colour(left_eye_ps, c_white, image_alpha);
part_system_colour(right_eye_ps, c_white, image_alpha);

// Draw the eyes
part_system_drawit(left_eye_ps);
part_system_drawit(right_eye_ps);