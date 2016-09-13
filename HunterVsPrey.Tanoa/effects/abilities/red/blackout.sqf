/*
	HVP2 Blackout Ability
	By Sinbane
	Turns off all lights in a radius around player and removes flashlights from enemy guns temporarily
*/
//-----------------------------------
//-SET VARIABLES

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

[(getPos player)] remoteExec ["HVP_fn_abilBlackout", 0];

titleText ["BLACKOUT ACTIVATED", "PLAIN DOWN", 0.5];

//-----------------------------------
//-ADD AT NEXT PHASE

["HVPblackout"] spawn SIN_fnc_addAbil;	