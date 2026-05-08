cards = ds_list_create();

global.score = 0;
global.roundNumber = 1;

waitTimer = 0;
moveSfxCooldown = 0;

global.targetType = "";
shuffle_count = 0;
shuffle_done = 0;
shuffle_pair_a = -1;
shuffle_pair_b = -1;

shakeTimer = 0;
shakePower = 0;

currentBG = BG;

global.lastGuessCorrect = true;

global.shake_x = 0;
global.shake_y = 0;

enum states
{
	setup_round,
	show_target,
	hide_cards,
	shuffle_cards,
	wait_for_guess,
	reveal_result
}

global.STATE_SETUP_ROUND = states.setup_round;
global.STATE_SHOW_TARGET = states.show_target;
global.STATE_HIDE_CARDS = states.hide_cards;
global.STATE_SHUFFLE_CARDS = states.shuffle_cards;
global.STATE_WAIT_FOR_GUESS = states.wait_for_guess;
global.STATE_REVEAL_RESULT = states.reveal_result;

global.currentState = states.setup_round;


center_y = 380;
slot_1_x = 220;
slot_2_x = 360;
slot_3_x = 500;


base_shuffle_speed = 0.025;


var card;


card = instance_create_depth(slot_1_x, center_y, 0, obj_card);
card.cardType = "Rock";
card.faceSprite = RockSpr;
card.normalSprite = RockSpr;
card.altSprite = RockSprAlt;
card.displaySprite = RockSpr;
card.faceDown = false;
card.owner = "board";
card.slotIndex = 0;
card.drawScale = 2.5;
ds_list_add(cards, card);

card = instance_create_depth(slot_2_x, center_y, 0, obj_card);
card.cardType = "Paper";
card.faceSprite = PaperSpr;
card.normalSprite = PaperSpr;
card.altSprite = PaperSprAlt;
card.displaySprite = PaperSpr;
card.faceDown = false;
card.owner = "board";
card.slotIndex = 1;
card.drawScale = 2.5;
ds_list_add(cards, card);


card = instance_create_depth(slot_3_x, center_y, 0, obj_card);
card.cardType = "Scissors";
card.faceSprite = ScissorsSpr;
card.normalSprite = ScissorsSpr;
card.altSprite = ScissorsSprAlt;
card.displaySprite = ScissorsSpr;
card.faceDown = false;
card.owner = "board";
card.slotIndex = 2;
card.drawScale = 2.5;
ds_list_add(cards, card);

function PlayDealSfx()
{
	if (moveSfxCooldown <= 0)
	{
		audio_play_sound(dealSfx, 1, false);
		moveSfxCooldown = 3;
	}
}

function GetSlotX(_slot)
{
	if (_slot == 0) return slot_1_x;
	if (_slot == 1) return slot_2_x;
	return slot_3_x;
}

function CurrentShuffleSpeed()
{
	var spd = base_shuffle_speed + (global.roundNumber - 1) * 0.004;
	return min(spd, 0.07);
}

function SetupRound()
{

	var r = irandom(2);
	if (r == 0) global.targetType = "Rock";
	if (r == 1) global.targetType = "Paper";
	if (r == 2) global.targetType = "Scissors";
	
	if (global.targetType == "Rock") {
			currentBG = BG_Rock;
		}
		else if (global.targetType == "Paper") {
			currentBG = BG_Paper;
		}
		else if (global.targetType == "Scissors") {
			currentBG = BG_Scissors;
		}
		else {
			currentBG = BG;
		}


	for (var i = 0; i < ds_list_size(cards); i++)
	{
		var c = cards[| i];
		c.faceDown = false;
		c.drawScaleX = c.drawScale;
		c.isFlipping = false;
		c.isGuessable = false;
		c.slotIndex = i;
		c.StartMove(GetSlotX(i), center_y, 0.03);
		
		if (c.cardType == global.targetType)
			{
				c.displaySprite = c.altSprite;
			}
			else
			{
				c.displaySprite = c.normalSprite;
			}
	}

	shuffle_done = 0;
	shuffle_count = 3 + global.roundNumber * 2;
	waitTimer = 0;

	global.currentState = states.show_target;
}

function AllCardsStopped()
{
	for (var i = 0; i < ds_list_size(cards); i++)
	{
		var c = cards[| i];
		if (c.isMoving) return false;
	}
	return true;
}

function StartShuffleStep()
{

	shuffle_pair_a = irandom(2);
	shuffle_pair_b = irandom(2);
	while (shuffle_pair_b == shuffle_pair_a)
	{
		shuffle_pair_b = irandom(2);
	}

	var cardA = noone;
	var cardB = noone;

	for (var i = 0; i < ds_list_size(cards); i++)
	{
		var c = cards[| i];
		if (c.slotIndex == shuffle_pair_a) cardA = c;
		if (c.slotIndex == shuffle_pair_b) cardB = c;
	}

	if (cardA != noone && cardB != noone)
	{
		var oldA = cardA.slotIndex;
		var oldB = cardB.slotIndex;

		cardA.slotIndex = oldB;
		cardB.slotIndex = oldA;

		var spd = CurrentShuffleSpeed();
		cardA.StartMove(GetSlotX(cardA.slotIndex), center_y, spd);
		cardB.StartMove(GetSlotX(cardB.slotIndex), center_y, spd);
	}
}

function RevealAllCards()
{
	for (var i = 0; i < ds_list_size(cards); i++)
	{
		var c = cards[| i];
		c.StartFlip(false);
		c.isGuessable = false;
	}
}

function ResetGame()
{
	global.score = 0;
	global.roundNumber = 1;
	global.lastGuessCorrect = true;
	SetupRound();
}

function StartShake(_power, _time)
{
	shakePower = _power;
	shakeTimer = _time;
}


function AllCardsReady()
{
	for (var i = 0; i < ds_list_size(cards); i++)
	{
		var c = cards[| i];
		if (c.isMoving) return false;
		if (c.isFlipping) return false;
	}
	return true;
}