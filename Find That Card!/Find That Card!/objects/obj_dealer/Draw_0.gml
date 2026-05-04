depth = 1;


if (shakeTimer > 0)
{
	global.shake_x = irandom_range(-shakePower, shakePower);
	global.shake_y = irandom_range(-shakePower, shakePower);
}

draw_sprite_tiled_ext(currentBG, 0, global.shake_x, global.shake_y, 1, 1, c_white, 1);

draw_set_font(FindFont);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

draw_text(360 + global.shake_x, 100 + global.shake_y, "Find: " + global.targetType);

draw_set_font(ScoreFont);
draw_set_halign(fa_left);
draw_text(24 + global.shake_x, 600 + global.shake_y, "Score: " + string(global.score));

draw_set_halign(fa_right);
draw_text(696 + global.shake_x, 600 + global.shake_y, "Round: " + string(global.roundNumber));

draw_set_halign(fa_left);
draw_set_valign(fa_top);