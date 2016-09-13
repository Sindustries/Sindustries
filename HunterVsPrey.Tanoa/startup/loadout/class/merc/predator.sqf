/*
	HVP2 Loadout Manager
	TEAM: Green | Class: Predator
	By Sinbane
*/
private ["_weaponFound","_weapon","_magazines","_magazine"];
//-----------------------------------
//-UNIFORM, VEST, ITEMS

player linkitem "itemGPS";
player addUniform (selectRandom cfg_ghillies);
player addVest "V_PlateCarrierSpec_blk";
player addHeadgear "H_HelmetO_ViperSP_ghex_F";
player addBackpack "B_Kitbag_cbr";		
player addWeapon "Laserdesignator";		
player addMagazines ["SmokeShellRed", 3];
player addMagazines ["ACE_M84", 3];
player addMagazines ["APERSBoundingMine_Range_Mag", 3];
for "_bandage" from 1 to 8 do {
	player additem "FirstAidKit";
};
player addItem "MineDetector";

//-----------------------------------
//-PRIMARY WEAPON

_weaponFound = false;
while {!_weaponFound} do {
	_weapon = selectRandom (Sinspawn_lootList select 0);
	if (_weapon isKindOf ["Rifle", configFile >> "CfgWeapons"]) then {
		_weaponFound = true;
	};
};
_magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
_magazine = selectRandom _magazines;
player addMagazines [_magazine, 2];
player addWeapon _weapon;

//-----------------------------------
//-HANDGUN

_weaponFound = false;
while {!_weaponFound} do {
	_weapon = selectRandom (Sinspawn_lootList select 0);
	if (_weapon isKindOf ["Pistol", configFile >> "CfgWeapons"]) then {
		_weaponFound = true;
	};
};
_magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
_magazine = selectRandom _magazines;
player addMagazines [_magazine, 2];
player addWeapon _weapon;
	
//-----------------------------------