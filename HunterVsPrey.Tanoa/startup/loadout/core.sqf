/*
	HVP2 Loadout Manager
	By Sinbane
	Assigns specific loadouts to classes
*/
//-----------------------------------
//-DEFINE VARIABLES

waitUntil {!isNull player};   

#include "cfgLoadout.sqf";

_uniform = selectRandom _uniSel;
_hat = selectRandom _hatSel;

//-----------------------------------
//-CLEAR EXISTING ITEMS

removeUniform player;
removeVest player;
removeHeadgear player;
removeBackpack player;
removeAllWeapons player;
removeAllAssignedItems player;

if ((goggles player) in HVP_gasMasks) then {removeGoggles player};

//-----------------------------------
//-DEBUG OPTIONS
if (HVPDebugMode == 1) then {
	player linkItem "itemMap";
	player linkitem "itemGPS";	
};

sleep 1;
if (HVPGameType == 1) then {
//-----------------------------------
//-BLUE TEAM
if (side player == WEST) then {

player addUniform _uniform;
player addHeadgear _hat;

};
//-----------------------------------
//-TEAM LEADER

if (player isKindOf "B_Soldier_TL_F") then {
	_class = [_ammoChance,_medChance,_mapChance,_gunRoll] execVM "startup\loadout\class\blu\teamlead.sqf";
	waitUntil {scriptDone _class};
};

//-----------------------------------
//-GRENADIER

if (player isKindOf "B_Soldier_GL_F") then {
	_class = [_ammoChance,_medChance,_mapChance,_gunRoll] execVM "startup\loadout\class\blu\grenadier.sqf";
	waitUntil {scriptDone _class};
};

//-----------------------------------
//-MEDIC

if (player isKindOf "B_medic_F") then {
	_class = [_ammoChance,_medChance,_mapChance,_gunRoll] execVM "startup\loadout\class\blu\medic.sqf";
	waitUntil {scriptDone _class};
};

//-----------------------------------
//-TECH EXPERT

if (player isKindOf "B_soldier_exp_F") then {
	_class = [_ammoChance,_medChance,_mapChance,_gunRoll] execVM "startup\loadout\class\blu\tech.sqf";
	waitUntil {scriptDone _class};
};

//-----------------------------------
//-RED TEAM
if (side player == EAST) then {
	player addUniform (selectRandom cfg_ghillies);
	player addItem "NVGoggles_OPFOR";
	player assignItem "NVGoggles_OPFOR";
	player addVest "V_RebreatherIA";
	player addMagazine ["16Rnd_9x21_red_Mag", 1];
	player addWeapon "hgun_P07_F";
	player addHandgunItem  "muzzle_snds_L";
};
//-----------------------------------
//-TEAM LEADER

if (player isKindOf "O_Soldier_TL_F") then {
	_class = [_ammoChance,_medChance,_mapChance] execVM "startup\loadout\class\red\leader.sqf";
	waitUntil {scriptDone _class};
};	

//-----------------------------------
//-STALKER

if (player isKindOf "O_spotter_F") then {
	_class = [_ammoChance,_medChance,_mapChance] execVM "startup\loadout\class\red\stalker.sqf";
	waitUntil {scriptDone _class};
	
	if (395180 in (getDLCs 1)) then {
		player removeitem "NVGoggles_OPFOR";
		player addHeadgear "H_HelmetO_ViperSP_ghex_F";
	};	
};	

//-----------------------------------
//-BOOMER

if (player isKindOf "O_soldier_exp_F") then {
	_class = [_ammoChance,_medChance,_mapChance] execVM "startup\loadout\class\red\boomer.sqf";
	waitUntil {scriptDone _class};
};

//-----------------------------------
//-WRAITH

if (player isKindOf "O_soldier_UAV_F") then {
	_class = [_ammoChance,_medChance,_mapChance] execVM "startup\loadout\class\red\wraith.sqf";
	waitUntil {scriptDone _class};
};

//-----------------------------------
//-MERCENARY
if (side player == RESISTANCE) then {

if (player isKindOf "I_medic_F") then {
	_class = [_ammoChance,_medChance,_mapChance] execVM "startup\loadout\class\merc\merc.sqf";
	waitUntil {scriptDone _class};
};

};
};
if (HVPGameType == 2) then {
//-----------------------------------
//-SOLO MODE
//-UNIFORM

	player linkItem "itemMap";
	//player linkitem "itemGPS";

	player addUniform _uniform;
	player addHeadgear _hat;
	player addweapon "bv_flashlight";
	player addItem "acc_flashlight";

};
if (HVPGameType isEqualTo 3) then {
//-----------------------------------
//-PREDATOR MODE

	if (playerSide isEqualTo WEST || playerSide isEqualTo EAST) then {
		
		player linkItem "itemMap";

		player addUniform _uniform;
		player addHeadgear _hat;
		player addweapon "bv_flashlight";
		player addItem "acc_flashlight";		
	};
	
	if (playerSide isEqualTo RESISTANCE) then {
		_class = execVM "startup\loadout\class\merc\predator.sqf";
		waitUntil {scriptDone _class};
	};
};
//-----------------------------------
//-GLOBAL ITEMS

player linkItem "itemRadio";
player linkItem "itemCompass";
player linkItem "itemWatch";

//-----------------------------------
//-PERSONALIZED ITEMS

if (HVPGameType == 1 && side player == WEST || HVPGameType == 2) then {
	for [{_t=1}, {_t<=count _userGear}, {_t=_t+1}] do {
		_indexNum = _t-1;
		_sel = _userGear select _indexNum;
		if (getPlayerUID player == (_sel select 0)) then {
			_item = _sel select 1;
			player addHeadgear _item;
		};
	};
};
//-----------------------------------