/*
	HVP2 Loadout Manager
	TEAM: Blue | Class: Medic
	By Sinbane
*/
//-----------------------------------
//-GET VARIABLES

_ammoChance = _this select 0;
_medChance = _this select 1;
_mapChance = _this select 2;
_gunRoll = _this select 3;

//-----------------------------------
//-MEDIC SUPPLIES

player addVest "V_BandollierB_cbr";

for "_bandage" from 1 to 8 do {
	player additem "FirstAidKit";
};
player additem "MediKit";
//-----------------------------------
//-GET RANDOMISED GEAR

if (_ammoChance <= HVPLootChance) then {
	player addMagazines ["30Rnd_65x39_caseless_mag_Tracer", 1];
} else {
	player addMagazines ["9Rnd_45ACP_Mag", 1];
};

if (_mapChance <= HVPLootChance) then {
	player linkItem "itemMap";
};

//-----------------------------------
//-WEAPONS

_ownedDLCs = getDLCs 1;
if (395180 in _ownedDLCs && _gunroll <= 50) then {
	player addWeapon "arifle_MXC_khk_F";
} else {
	player addWeapon "arifle_MXC_Black_F";
};

player addPrimaryWeaponItem "acc_flashlight";
player addWeapon "hgun_ACPC2_F";

//-----------------------------------