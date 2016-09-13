/*
	HVP2 Fatigue Aura Ability
	By Sinbane
	Hits user of enemy teams with max fatigue
*/
//-----------------------------------
//-SET VARIABLES

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

titleText ["FATIGUE AURA ACTIVATED", "PLAIN DOWN", 0.5];

[(getPos player),player] remoteExec ["HVP_fn_abilFatigueAura", 0];

//-----------------------------------
//-ADD AT NEXT PHASE

["HVPfatigueaura"] spawn SIN_fnc_addAbil;	