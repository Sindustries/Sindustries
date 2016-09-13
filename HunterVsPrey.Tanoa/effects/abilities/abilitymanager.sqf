/*
	HVP2 Player Ability Manager
	By Sinbane
*/
//-----------------------------------
//-VARIABLES

if (isnil ("HVP_isFatiguefree")) then {HVP_isFatiguefree = "false"};

#include "cfgAbilities.sqf";

if (HVPGameType isEqualTo 1) then {
//-----------------------------------
//-BLUE TEAM
//-----------------------------------
//-TEAM LEADER

if (player isKindof "B_Soldier_TL_F") then {
	["HVParty"] spawn SIN_fnc_addAbil;
};

//-----------------------------------
//-GRENADIER

if (player isKindof "B_Soldier_GL_F") then {
	["HVPbio"] spawn SIN_fnc_addAbil;
};

//-----------------------------------
//-TECH EXPERT

if (player isKindof "B_soldier_exp_F") then {
	["HVPnvthief"] spawn SIN_fnc_addAbil;
};

//-----------------------------------
//-MEDIC

if (player isKindof "B_medic_F") then {
	["HVPhealingaura"] spawn SIN_fnc_addAbil;
};

//-----------------------------------
//-RED TEAM
//-----------------------------------
//-TEAM LEADER

if (player isKindof "O_Soldier_TL_F") then {
	["HVPblackout"] spawn SIN_fnc_addAbil;
};

//-----------------------------------
//-STALKER

if (player isKindof "O_spotter_F") then {
	["HVPfatigueaura"] spawn SIN_fnc_addAbil;
};

//-----------------------------------
//-BOOMER

if (player isKindof "O_soldier_exp_F") then {
	["HVPboomerhp"] spawn SIN_fnc_addAbil;
};

//-----------------------------------
//-WRAITH

if (player isKindof "O_soldier_UAV_F") then {
	["HVPcloak"] spawn SIN_fnc_addAbil;
};

//-----------------------------------
//-MERCENARY

if (player isKindof "I_medic_F") then {
	["HVPmercFatigue"] spawn SIN_fnc_addAbil;
	["HVPmercNV"] spawn SIN_fnc_addAbil;
	["HVPreveal"] spawn SIN_fnc_addAbil;
};

};
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
//-----------------------------------
//-RANDOM ABILITY

[] spawn SIN_fnc_addAbil;

};
if (HVPGameType isEqualTo 3 && playerSide isEqualTo RESISTANCE) then {
//-----------------------------------
//-PREDATOR EXTRA ONE-USE ABILITIES
	private "_abil";

	_abil = [player,"HVPboomerhp"] call BIS_fnc_addCommMenuItem;
	_abil = [player,"HVPcloak"] call BIS_fnc_addCommMenuItem;
	_abil = [player,"HVPreveal"] call BIS_fnc_addCommMenuItem;

};
//-----------------------------------