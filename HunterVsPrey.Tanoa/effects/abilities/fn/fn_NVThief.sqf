/*
	HVP2 Night Vision Thief Ability Effect
	By Sinbane
	Removes NVG's from nearby enemies temporarily and gives nearby friendlies temporary night vision
*/
private ["_pos","_time","_counter","_timer"];
//-----------------------------------
//-EFFECT

_pos = _this select 0;

if ((player distance _pos) < 80) then {
	if (side player == EAST) then {
		if (player isKindOf "O_spotter_F") then {
			if (headgear player isEqualTo "H_HelmetO_ViperSP_ghex_F") then {
				removeHeadgear player;
			};
		} else {
			player removeitem "NVGoggles_blk_F";
		};
		titleText ["YOU'VE BEEN HIT BY NIGHT VISION THIEF!", "PLAIN DOWN", 0.6];
		sleep HVP_cfgNVThiefTime;
		if (player isKindOf "O_spotter_F") then {
			player addHeadgear "H_HelmetO_ViperSP_ghex_F";
		} else {
			player addItem "NVGoggles_OPFOR";
			player assignItem "NVGoggles_OPFOR";
		};
	};

	if (side player == WEST) then {	
		player action ["GunLightOff", player];
		player action ["nvGoggles", player];
		titleText ["TEMPORARY NIGHT VISION", "PLAIN DOWN", 0.6];
				
		[HVP_cfgNVThiefTime] call HVP_fn_abilProgressBar;

		player action ["nvGogglesOff", player];
	};
};