if (moveSfxCooldown > 0) moveSfxCooldown--;

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
		for (var i = 0; i < ds_list_size(cards); i++)
		{
			var c = cards[| i];
			c.faceDown = true;
		}

		global.currentState = states.shuffle_cards;
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
		if (AllCardsStopped())
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