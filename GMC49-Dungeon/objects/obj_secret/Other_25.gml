/// @desc Secret: Draw
draw_sprite(spr_secret_shadow, 0, x, y);
draw_sprite_ext(sprite_index, 0, x, y + animate_sin(second(0.5)) - 2, image_xscale, image_yscale, image_angle, image_blend, image_alpha);