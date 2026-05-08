if (moveSfxCooldown > 0) moveSfxCooldown--;

if (shakeTimer > 0)
{
	shakeTimer--;
}
else
{
	shakePower = 0;
}

switch (global.currentState)
{
	case states.setup_round:
		SetupRound();
	break;

	case states.show_target:
		if (AllCardsStopped())
		{
			waitTimer++;

			if (waitTimer >= 60)
			{
				waitTimer = 0;
				global.currentState = states.hide_cards;
			}
		}
	break;

	case states.hide_cards:

		if (waitTimer == 0)
		{
			for (var i = 0; i < ds_list_size(cards); i++)
			{
				var c = cards[| i];
				c.displaySprite = c.normalSprite;
				c.StartFlip(true);
			}

			waitTimer = 1;
		}
		else if (AllCardsReady())
		{
			waitTimer = 0;
			global.currentState = states.shuffle_cards;
		}

	break;

	case states.shuffle_cards:
		if (AllCardsStopped())
		{
			if (shuffle_done < shuffle_count)
			{
				StartShuffleStep();
				shuffle_done++;
			}
			else
			{
				for (var i = 0; i < ds_list_size(cards); i++)
				{
					var c = cards[| i];
					c.isGuessable = true;
				}

				global.currentState = states.wait_for_guess;
			}
		}
	break;

	case states.wait_for_guess:

	break;

	case states.reveal_result:
		if (AllCardsReady())
		{
			waitTimer++;

			if (waitTimer >= 60)
			{
				waitTimer = 0;

				if (!global.lastGuessCorrect)
				{
					ResetGame();
					
				}
				else
				{
					global.roundNumber += 1;
					global.currentState = states.setup_round;
				}
			}
		}
	break;
}