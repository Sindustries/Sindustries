/*
	HVP2 Fatigue Free Ability
	By Sinbane
	Grants immunity to fatigue
*/
//-----------------------------------
//-ABILITY

titleText ["FATIGUE FREE ACTIVATED", "PLAIN DOWN", 0.5];
HVP_isFatiguefree = "true";
player enableStamina false;

[HVP_cfgFatigueFreeTime] call HVP_fn_abilProgressBar;

player enableStamina true;
HVP_isFatiguefree = "false";

//-----------------------------------
//-ADD AT NEXT PHASE

["HVPmercFatigue"] spawn SIN_fnc_addAbil;	