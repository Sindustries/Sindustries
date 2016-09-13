/*
	HVP2 Loadout Manager
	TEAM: Blue | Class: Grenadier
	By Sinbane
*/
//-----------------------------------
//-GET VARIABLES

_ammoChance = _this select 0;
_medChance = _this select 1;
_mapChance = _this select 2;
_gunRoll = _this select 3;

//-----------------------------------
//-GET RANDOMISED GEAR

if (_ammoChance <= HVPLootChance) then {
	player addVest "V_BandollierB_cbr";
	player addMagazines ["30Rnd_65x39_caseless_mag_Tracer", 1];
	player addMagazines ["1Rnd_SmokeGreen_Grenade_shell", 3];
	player addMagazines ["1Rnd_SmokeBlue_Grenade_shell", 3];
	player addMagazines ["UGL_FlareGreen_F", 3];
} else {
	player addMagazines ["9Rnd_45ACP_Mag", 1];
	player addMagazines ["1Rnd_SmokeGreen_Grenade_shell", 1];
	player addMagazines ["1Rnd_SmokeBlue_Grenade_shell", 1];
	player addMagazines ["UGL_FlareGreen_F", 1];
};

if (_medChance <= HVPLootChance) then {
	player additem "FirstAidKit";
};

if (_mapChance <= HVPLootChance) then {
	player addItem "itemMap";
	player assignItem "itemMap";
};

_ownedDLCs = getDLCs 1;
if (395180 in _ownedDLCs && _gunroll <= 50) then {
	player addWeapon "arifle_MX_GL_khk_F";
} else {
	player addWeapon "arifle_MX_GL_F";
};

player addPrimaryWeaponItem "acc_flashlight";
player addWeapon "hgun_ACPC2_F";

//-----------------------------------