/*
	HVP Tear/Toxic Gas Script
	Origonal by Taw_jarhead, edited by Sinbane for HVP
*/
//-----------------------------------
//-VARIABLES

if (HVPGameType isEqualTo 1) then {
	if (playerSide isEqualTo WEST) then {
		tearGas = "SmokeShellRed";
		tearGasGL = "1Rnd_SmokeRed_Grenade_shell";
	};
	if (playerSide isEqualTo EAST) then {
		tearGas = "SmokeShellBlue";
		tearGasGL = "1Rnd_SmokeBlue_Grenade_shell";
	};
};
if (HVPGameType isEqualTo 2) then {
	tearGas = "SmokeShellRed";
	tearGasGL = "1Rnd_SmokeRed_Grenade_shell";
};
if (HVPGameType isEqualTo 3) then {
	if (playerSide != RESISTANCE) then {
		tearGas = "SmokeShellRed";
		tearGasGL = "1Rnd_SmokeRed_Grenade_shell";
	};
};


HVP_gasMasks = [
"H_PilotHelmetFighter_B",
"H_PilotHelmetFighter_O",
"H_PilotHelmetFighter_I",
"H_CrewHelmetHeli_B",
"H_CrewHelmetHeli_O",
"H_CrewHelmetHeli_I",
"H_Shemag_khk",
"H_Shemag_tan",
"H_Shemag_olive",
"H_Shemag_olive_hs",
"H_ShemagOpen_khk",
"H_ShemagOpen_tan",
"H_RacingHelmet_1_F",
"H_RacingHelmet_2_F",
"H_RacingHelmet_3_F",
"H_RacingHelmet_4_F",
"H_RacingHelmet_1_black_F",
"H_RacingHelmet_1_blue_F",
"H_RacingHelmet_1_green_F",
"H_RacingHelmet_1_red_F",
"H_RacingHelmet_1_white_F",
"H_RacingHelmet_1_yellow_F",
"H_RacingHelmet_1_orange_F",
"G_Bandanna_aviator",
"G_Bandanna_beast",
"G_Bandanna_blk",
"G_Bandanna_khk",
"G_Bandanna_oli",
"G_Bandanna_shades",
"G_Bandanna_sport",
"G_Bandanna_tan",
"H_HelmetO_ViperSP_hex_F",
"H_HelmetO_ViperSP_ghex_F",
"G_Balaclava_TI_blk_F",
"G_Balaclava_TI_G_blk_F",
"G_Balaclava_TI_G_tna_F",
"G_Balaclava_TI_tna_F",
"Mask_M50",
"Mask_M40",
"Mask_M40_OD"
];

if (side player isEqualTo RESISTANCE && HVPGameType isEqualTo 1) exitWith {};
if (side player isEqualTo RESISTANCE && HVPGameType isEqualTo 3) exitWith {};
//-----------------------------------
//-OPEN LOOP
while {true} do {
//-----------------------------------

	// normal conditions
	if (playerSide isEqualTo WEST || HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
		player forceWalk false;
	};
	"dynamicBlur" ppEffectEnable true; // enables ppeffect
	"dynamicBlur" ppEffectAdjust [0]; // enables normal vision
	"dynamicBlur" ppEffectCommit 10; // time it takes to normal
	resetCamShake; // resets the shake
	20 fadeSound 1;	 //fades the sound back to normal

	waitUntil {sleep 1; (nearestObject [getpos player, tearGas]) distance player < 10 || (nearestObject [getpos player, tearGasGL]) distance player < 10};
	if (getpos (nearestObject [getpos player, tearGas]) select 2 < 5 || getpos (nearestObject [getpos player, tearGasGL]) select 2 < 5) then {

		if ((headgear player) in HVP_gasMasks || (goggles player) in HVP_gasMasks) then {sleep 1} else {

			"dynamicBlur" ppEffectEnable true; // enables ppeffect
			"dynamicBlur" ppEffectAdjust [10]; // intensity of blur
			"dynamicBlur" ppEffectCommit 3; // time till vision is fully blurred
			enableCamShake true;	 // enables camera shake
			addCamShake [10, 45, 10];	// sets shakevalues
			player setStamina 3; // sets stamina to pretty much empty
			5 fadeSound 0.1;	 // fades the sound to 10% in 5 seconds
			sleep 5;
			if (playerSide isEqualTo WEST && HVPGameType isEqualTo 1 || HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
				player forceWalk true;
				player setDamage ((damage player)+0.05);
				[player,3] spawn SMS_fn_setBleeding;
			};
			"dynamicBlur" ppEffectAdjust [20]; // intensity of blur
			"dynamicBlur" ppEffectCommit 3; // time till vision is fully blurred
			sleep 5;
		};
	};
	
//-----------------------------------
//-CLOSE LOOP
};