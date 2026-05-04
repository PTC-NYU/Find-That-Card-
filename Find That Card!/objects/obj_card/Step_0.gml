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

if (global.currentState == global.STATE_WAIT_FOR_GUESS)
{
	var canClick =
		isGuessable &&
		!isMoving &&
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
		}

		isGuessable = false;
		global.currentState = global.STATE_REVEAL_RESULT;
	}
}