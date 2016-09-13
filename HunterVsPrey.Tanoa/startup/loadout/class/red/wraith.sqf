/*
	HVP2 Loadout Manager
	TEAM: Red | Class: Stalker
	By Sinbane
*/
//-----------------------------------
//-GET VARIABLES

_ammoChance = _this select 0;
_medChance = _this select 1;
_mapChance = _this select 2;

//-----------------------------------
//-UNIFORM

player addBackpack "O_UAV_01_backpack_F";
player additem "O_UavTerminal";
player assignitem "O_UavTerminal";

player addMagazines ["SmokeShellRed", 2];
player addMagazines ["ACE_M84", 1];

//-----------------------------------
//-GET RANDOMISED GEAR

if (_ammoChance <= HVPLootChance) then {
	player addMagazines ["ACE_M84", 1];
	player addMagazines ["SmokeShellRed", 1];
};

if (_medChance <= HVPLootChance) then {
	player additem "FirstAidKit";
};

if (_mapChance <= HVPLootChance) then {
	player linkItem "itemMap";
};

//-----------------------------------