draw_set_font(ScoreFont);
draw_set_halign(fa_center);
draw_set_valign(fa_top);


draw_text(360, 100, "Find: " + global.targetType);


draw_set_halign(fa_left);
draw_text(24, 600, "Score: " + string(global.score));


draw_set_halign(fa_right);
draw_text(696, 600, "Round: " + string(global.roundNumber));

draw_set_halign(fa_left);
draw_set_valign(fa_top);