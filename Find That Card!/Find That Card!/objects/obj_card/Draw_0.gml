if (faceDown)
{
	draw_sprite_ext(spr_card_back, 0, x + global.shake_x, y + global.shake_y, drawScaleX, drawScale, 0, c_white, 1);
}
else
{
	draw_sprite_ext(displaySprite, 0, x + global.shake_x, y + global.shake_y, drawScaleX, drawScale, 0, c_white, 1);
}