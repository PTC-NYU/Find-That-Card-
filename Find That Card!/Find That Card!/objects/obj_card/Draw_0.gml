if (faceDown)
{
	draw_sprite_ext(spr_card_back, 0, x, y, drawScale, drawScale, 0, c_white, 1);
}
else
{
	draw_sprite_ext(faceSprite, 0, x, y, drawScale, drawScale, 0, c_white, 1);
}