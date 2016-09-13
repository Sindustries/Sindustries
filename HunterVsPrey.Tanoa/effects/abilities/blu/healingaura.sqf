/*
	HVP2 Fatigue Free Ability
	By Sinbane
	Grants immunity to fatuge to nearby friendlies
*/
//-----------------------------------
//-ABILITY

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

titleText ["HEALING AURA ACTIVATED", "PLAIN DOWN", 0.5];

if (HVPGameType isEqualTo 1 || HVPGameType isEqualTo 3) then {
	[(getPos player)] remoteExec ["HVP_fn_abilHealingAura", 0];
};
if (HVPGameType isEqualTo 2) then {
	[] call HVP_fn_abilHealingAura;
};

//-----------------------------------
//-ADD AT NEXT PHASE

["HVPhealingaura"] spawn SIN_fnc_addAbil;	