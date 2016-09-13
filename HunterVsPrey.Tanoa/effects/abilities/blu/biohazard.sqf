/*
	HVP2 Biohazard Ability Effect
	By Sinbane
	Surrounds user with toxic gas that effects enemy team
*/
//-----------------------------------
//-EFFECT

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

titleText ["BIOHAZARD ACTIVATED", "PLAIN DOWN", 0.5];

[] call HVP_fn_abilBiohazard;

//-----------------------------------
//-ADD AT NEXT PHASE

["HVPbio"] spawn SIN_fnc_addAbil;	