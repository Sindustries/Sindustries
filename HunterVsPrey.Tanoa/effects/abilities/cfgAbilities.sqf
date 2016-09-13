/*
	HVP Ability Config
	Author: Sinbane
*/
//-----------------------------------
//-CONFIG

[] spawn {
	while {alive player} do {
		HVP_cfgBoomerHPTime = 10 + floor (random 20);
		HVP_cfgCloakTime = 30 + floor (random 30);
		HVP_cfgFatigueFreeTime = 30 + floor (random 30);
		HVP_cfgNVThiefTime = 20 + floor (random 20);
		
		sleep (HVPPhaseTime * 0.75);
	};
};

//-----------------------------------
//-VARIABLES

HVP_abilityTime = HVPPhaseTime;

//-----------------------------------
//-ABILITY LISTS

HVP_AbilityList = [
["HVParty","ARTILLERY STRIKE","Call down an Artillery Bombardment.","effects\abilities\blu\artillery.sqf","false"],
["HVPbio","BIOHAZARD","Surround yourself in flares and toxic gas that effects nearby enemies","effects\abilities\blu\biohazard.sqf","false"],
["HVPnvthief","NIGHT VISION THIEF","Removes night vision from nearby enemies and gives night vision to nearby friendlies","effects\abilities\blu\nvthief.sqf","false"],
["HVPhealingaura","HEALING AURA","Sends an aura that slowly heals you and nearby friendlies & grants temporary immunity to fatigue","effects\abilities\blu\healingaura.sqf","false"],
["HVPblackout","BLACKOUT","Turn off all lights within 300m, including enemy flashlights.","effects\abilities\red\blackout.sqf","false"],
["HVPfatigueaura","FATIGUE AURA","Drains the Stamina of all nearby enemies.","effects\abilities\red\fatigueaura.sqf","false"],
["HVPboomerhp","INVINCIBILITY","Become invincible temporarily.","effects\abilities\red\boomerhp.sqf","false"],
["HVPcloak","CLOAK","Become temporarily invisible as long as you're standing still, or prone","effects\abilities\red\cloak.sqf","false"],
["HVPmercNV","NIGHT VISION","Temporary Night Vision","effects\abilities\merc\nvthief.sqf","true"],
["HVPmercFatigue","FATIGUE FREE","Temporary immunity to fatigue","effects\abilities\merc\fatiguefree.sqf","false"],
["HVPreveal","REVEAL ENEMIES","Roughly reveals where enemies are on the map","effects\abilities\merc\reveal.sqf","true"]
];

HVP_CRUabilList = [
["HVParty", "ARTILLERY STRIKE", "Call down an Artillery Bombardment.","effects\abilities\blu\artillery.sqf","false"],
["HVPbio","BIOHAZARD","Surround yourself in flares and smoke grenades.","effects\abilities\blu\biohazard.sqf","false"],
["HVPfatigueaura","FATIGUE AURA","Hit all nearby players with max fatigue","effects\abilities\red\fatigueaura.sqf","false"],
["HVPboomerhp","INVINCIBILITY","Become temporarily invulnerable","effects\abilities\red\boomerhp.sqf","false"],
["HVPcloak","CLOAK","Become temporarily invisible as long as you're standing still, or prone","effects\abilities\red\cloak.sqf","false"],
["HVPmercFatigue","FATIGUE FREE","Become temporarily immune to fatigue","effects\abilities\merc\fatiguefree.sqf","false"],
["HVPairdrop","SUPPLY DROP","Call down an airdrop to your position","effects\abilities\cru\airdrop.sqf","false"],
["HVPreveal","REVEAL ENEMIES","Roughly reveals where enemies are on the map","effects\abilities\merc\reveal.sqf","false"],
["HVPhealingaura","HEALING AURA","Activates an aura that slowly heals you & grants temporary immunity to fatigue","effects\abilities\blu\healingaura.sqf","false"],
["HVPescape","ESCAPE","Immediatly teleport to a new, random nearby location.","effects\abilities\cru\escape.sqf","false"],
["HVPbanish","BANISH","Banish nearby players to a new location.","effects\abilities\cru\banish.sqf","false"],
["HVPdisarm","DISARM","Immediatly disarm nearby players of their current weapon","effects\abilities\cru\disarm.sqf","false"]
];



//-----------------------------------
//-THE FNCS

SIN_fnc_useAbility = {

	(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];
	uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetTextColor [1, 0, 0, 1];
	execVM HVP_abilExec;
	if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
		uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetText "WAITING";
		uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetTextColor [0, 0, 1, 1];
	};
};

SIN_fnc_addAbil = {
	private ["_currentPhase","_abilRoll","_abil"];
	
	if (HVPPhaseType isEqualTo 1) then {
		_currentPhase = HVP_phase_num;
		waitUntil {sleep 1; HVP_phase_num isEqualTo (_currentPhase + 1)};
	};
	if (HVPPhaseType isEqualTo 2) then {
		if (HVP_phase_active isEqualTo "false") then {
			sleep (HVP_abilityTime * 0.5);
		} else {
			[HVP_abilityTime] spawn HVP_phaseClock;
			waitUntil {HVP_phaseClock isEqualTo 0};
		};
	};
	
	if (HVPGameType isEqualTo 1) then {
		
		{	
			if ((_this select 0) isEqualTo (_x select 0)) then {
				if ((_x select 4) isEqualTo "true") then {
					HVP_Ability = [player,(_x select 0)] call BIS_fnc_addCommMenuItem;
				};
				HVP_abilName = (_x select 1);
				systemChat format["%1",HVP_abilName];
				systemChat format["%1",(_x select 2)];
				if (side player isEqualTo WEST || side player isEqualTo EAST || side player isEqualTo RESISTANCE && (_x select 0) isEqualTo "HVPmercFatigue") then {
					uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetText format["%1",HVP_abilName];
					uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetTextColor [0, 1, 0, 1];
					HVP_abilExec = (_x select 3);
					[] spawn SIN_fnc_useAbility_Key;
				};
			};
		} forEach HVP_AbilityList;
	};

	if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
		_abilRoll = selectRandom HVP_CRUabilList;			
		_abil = (_abilRoll select 0);	
		if ((_abilRoll select 4) isEqualTo "true") then {
			HVP_Ability = [player,(_abilRoll select 0)] call BIS_fnc_addCommMenuItem;
		};
		systemChat format["%1",(_abilRoll select 1)];
		systemChat format["%1",(_abilRoll select 2)];
		uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetText format["%1",(_abilRoll select 1)];
		uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetTextColor [0, 1, 0, 1];
		HVP_abilExec = (_abilRoll select 3);
		[] spawn SIN_fnc_useAbility_Key;
	};
};

//-----------------------------------
//-THE KEY

SIN_fnc_useAbility_Key = {
	
	waitUntil {!(isNull (findDisplay 46))};
	SIN_abilityDEH = (findDisplay 46) displayAddEventHandler ["KeyDown", "
	_source  = _this select 0;
    _keyCode = _this select 1;
    _isShift = _this select 2;
    _isCtrl  = _this select 3;
    _isAlt   = _this select 4;
	if (_keyCode isEqualTo 28 && _isShift) then {
		[] spawn SIN_fnc_useAbility;
		true;
	}"];
};

//-----------------------------------