/*
	Sinbane Medical System
	Author: Sinbane
	Launchers all controllers for the SMS
*/
//-----------------------------------
private ["_unit"];

_unit = _this select 0;
if (_unit != player) exitWith {};

#include "cfgSMS.sqf";
SMS_fn_bloodLevel = compile preProcessFileLineNumbers "SMS\fn\fn_bloodLevel.sqf";
SMS_fn_setBleeding = compile preProcessFileLineNumbers "SMS\fn\fn_setBleeding.sqf";
SMS_fn_setUnconscious = compile preProcessFileLineNumbers "SMS\fn\fn_setUnconscious.sqf";
SMS_fn_setBleedout = compile preProcessFileLineNumbers "SMS\fn\fn_setBleedout.sqf";
SMS_fn_handleDamage = compile preProcessFileLineNumbers "SMS\fn\fn_handleDamage.sqf";
SMS_fn_handleHeal = compile preProcessFileLineNumbers "SMS\fn\fn_handleHeal.sqf";
SMS_fn_healAction = compile preProcessFileLineNumbers "SMS\fn\fn_healAction.sqf";

if (getText (configFile >> "cfgVehicles" >> typeOf player >> "role") isEqualTo "CombatLifeSaver") then {
	_unit setVariable ["SMS_isMedic", true];
} else {
	_unit setVariable ["SMS_isMedic", false];
};

//-----------------------------------

_unit setVariable ["SMS_bloodLevel", SMS_maxBlood];
_unit setVariable ["SMS_bleedingRate", 0];
_unit setVariable ["SMS_isUnconscious", false];
_unit setVariable ["SMS_inBleedout", false];

[_unit] call SMS_fn_handleDamage;
[_unit] call SMS_fn_handleHeal;
[_unit] spawn SMS_fn_bloodLevel;
[_unit] spawn SMS_fn_healAction;

//-----------------------------------