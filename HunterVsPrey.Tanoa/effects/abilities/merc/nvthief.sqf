/*
	HVP2 Temporary Night Vision Ability Effect
	By Sinbane
	Gives mercenary temporary night vision
*/
//-----------------------------------
//-EFFECT

player action ["GunLightOff", player];
player action ["nvGoggles", player];
titleText ["TEMPORARY NIGHT VISION", "PLAIN DOWN", 0.5];

[HVP_cfgNVThiefTime] call HVP_fn_abilProgressBar;

player action ["nvGogglesOff", player];
	
//-----------------------------------
//-ADD AT NEXT PHASE

["HVPmercNV"] spawn SIN_fnc_addAbil;	