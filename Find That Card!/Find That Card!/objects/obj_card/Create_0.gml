target_x = x;
target_y = y;

faceDown = true;
isDiscarded = false;

cardType = "";
faceSprite = -1;
owner = "";

isGuessable = false;
slotIndex = 0;

isMoving = false;
move_t = 0;
move_speed = 0.04;
start_x = x;
start_y = y;

moveCurve = animcurve_get_channel(Movement, 0);

drawScale = 2.5;
drawScaleX = drawScale;

isFlipping = false;
flip_t = 0;
flip_speed = 0.12;
flipTargetFaceDown = faceDown;


function StartMove(tx, ty, spd = 0.04)
{
	start_x = x;
	start_y = y;
	target_x = tx;
	target_y = ty;
	move_t = 0;
	move_speed = spd;
	isMoving = true;

	var d = instance_find(obj_dealer, 0);
		if (d != noone)
		{
			d.PlayDealSfx();
		}
}

function PointOnCard(px, py)
{
	var spr = faceDown ? spr_card_back : faceSprite;
	var sw = sprite_get_width(spr) * drawScale;
	var sh = sprite_get_height(spr) * drawScale;

	return (
		px >= x - sw * 0.5 &&
		px <= x + sw * 0.5 &&
		py >= y - sh * 0.5 &&
		py <= y + sh * 0.5
	);
}

function StartFlip(_faceDownAfter)
{
	isFlipping = true;
	flip_t = 0;
	flipTargetFaceDown = _faceDownAfter;
}

