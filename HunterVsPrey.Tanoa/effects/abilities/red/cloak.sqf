/* 
	Cloaking Script
	By XxRTEKxX, HallyG & DreadedEntity
	Adapted for HVP2 by Sin
*/
//-----------------------------------
//-SET VARIABLES

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

[] spawn HVP_fn_abilCloak;
[HVP_cfgCloakTime] call HVP_fn_abilProgressBar;

titleText ["CLOAK DEACTIVATED", "PLAIN DOWN", 0.5];

//-----------------------------------
//-ADD AT NEXT PHASE

["HVPcloak"] spawn SIN_fnc_addAbil;	