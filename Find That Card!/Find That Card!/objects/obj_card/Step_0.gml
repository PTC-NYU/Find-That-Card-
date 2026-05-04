if (isMoving)
{
	move_t += move_speed;

	var t = clamp(move_t, 0, 1);
	var eased = animcurve_channel_evaluate(moveCurve, t);

	x = lerp(start_x, target_x, eased);
	y = lerp(start_y, target_y, eased);

	if (t >= 1)
	{
		x = target_x;
		y = target_y;
		isMoving = false;
	}
}

if (isFlipping)
{
	flip_t += flip_speed;

	if (flip_t < 0.5)
	{
		drawScaleX = lerp(drawScale, 0, flip_t * 2);
	}
	else
	{
		faceDown = flipTargetFaceDown;
		drawScaleX = lerp(0, drawScale, (flip_t - 0.5) * 2);
	}

	if (flip_t >= 1)
	{
		faceDown = flipTargetFaceDown;
		drawScaleX = drawScale;
		isFlipping = false;
	}
}

if (global.currentState == global.STATE_WAIT_FOR_GUESS)
{
	var canClick =
		isGuessable &&
		!isMoving &&
		!isFlipping &&
		faceDown;

	if (canClick && mouse_check_button_pressed(mb_left) && PointOnCard(mouse_x, mouse_y))
	{
		with (obj_dealer)
		{
			RevealAllCards();
			waitTimer = 0;
		}

		if (cardType == global.targetType)
		{
			global.score += 1;
			audio_play_sound(winSfx, 1, false);
			global.lastGuessCorrect = true;
		}
		else
		{
			audio_play_sound(loseSfx, 1, false);
			global.lastGuessCorrect = false;
			
			with (obj_dealer)
				{
					StartShake(12, 25);
				}
		}

		isGuessable = false;
		global.currentState = global.STATE_REVEAL_RESULT;
	}
}