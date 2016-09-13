/*
	HVP2 Invincibility Ability Effect
	By Sinbane
	Become invincible temporarily
*/
private ["_count","_timer","_chemLight"];
//-----------------------------------
//-EFFECT

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

titleText ["INVINCIBILITY ACTIVATED", "PLAIN DOWN", 0.5];
_chemLight = createVehicle ["Chemlight_Red", [0,0,0], [], 0, "NONE"];
_chemLight attachTo [player, [-0.1, 0.1, 0.15], "Pelvis"];
player allowDamage false;

[HVP_cfgBoomerHPTime] call HVP_fn_abilProgressBar;

player allowDamage true;
deleteVehicle _chemLight;
titleText ["INVINCIBILITY DEACTIVATED", "PLAIN DOWN", 0.5];

//-----------------------------------
//-ADD AT NEXT PHASE

["HVPboomerhp"] spawn SIN_fnc_addAbil;	