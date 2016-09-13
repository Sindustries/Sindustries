/*
	HVP2 Startup Script
	By Sinbane
	Launches all critical scripts, zone & events managers and player spawn
*/
enableSentences false;
enableEnvironment false;
player enableSimulation false;
player allowDamage false;
//-----------------------------------
//-GAME SETTINGS
private "_allUnits";

cutText ["", "BLACK FADED", 999];

if (player isKindof "B_Survivor_F" && HVPGameType isEqualTo 1 || player isKindof "O_Survivor_F" && HVPGameType isEqualTo 1) exitWith {
	["wrongslot",false] spawn BIS_fnc_endMission;
};

if (isServer) then {
	HVP_phase_num = 0;
	HVP_phase_active = "false";
	if (HVPZoneSizeMax isEqualTo 0) then {
		_allUnits = {isPlayer _x && side _x != sideLogic} count allUnits;
		HVPZoneSizeMax = (_allUnits * 250);
		if (HVPZoneSizeMax > 4000) then {
			HVPZoneSizeMax = 4000;
		};
	};		
	if (HVPPhaseTime isEqualTo 0) then {
		HVPPhaseTime = ((HVPZoneSizeMax * 2) / 5);
		if (HVPPhaseTime > 900) then {
			HVPPhaseTime = 900;
		};
	};
	HVP_phase_radius = HVPZoneSizeMax;
	publicVariable "HVP_phase_num";
	publicVariable "HVP_phase_active";
	publicVariable "HVP_phase_radius";
	publicVariable "HVPPhaseTime";
};

//-----------------------------------
//-MUSIC WHILE WE WAIT

playMusic (selectRandom HVPMusic);

//-----------------------------------
//-FIND GAME LOCATION
private ["_findLoc","_posFound","_posCheck"];

HVP_Pos_Found = "false";

if (!isServer) then {
	
	if (HVPManual isEqualTo 1) then {
		player additem "itemMap";
		openMap [true, true];
		cutText ["", "BLACK IN", 1];
		systemChat "Waiting for Host to choose game location...";
		waitUntil {HVP_Pos_Found isEqualTo "true"};
		cutText ["SETTING GAME LOCATION...", "BLACK FADED", 999];
		openMap [false, false]; 
		player removeitem "itemMap";
	};
	if (HVPManual isEqualTo 0) then {
		cutText ["FINDING GAME LOCATION", "BLACK FADED", 999];
		waitUntil {HVP_Pos_Found isEqualTo "true"};
	};
};

if (isServer) then {

	if (HVPManual isEqualTo 1) then {
		player additem "itemMap";
		_findloc = execVM "startup\manual.sqf";
		waitUntil {scriptDone _findloc};
		player removeitem "itemMap";
	};
	
	if (HVPManual isEqualTo 0) then {
		cutText ["FINDING GAME LOCATION", "BLACK FADED", 999];
		_posFound = false;
		while {!_posFound} do {
			HVP_Pos = [HVPErrorPos,0,99999,0,0,0,0,HVPBlacklist] call BIS_fnc_findSafePos;
			sleep 2;
			_posCheck = [HVP_Pos] call SIN_fnc_checkPos;
			if (_posCheck) then {
				publicVariable "HVP_Pos";
				sleep 0.1;
				HVP_Pos_Found = "true";
				_posFound = true;
				publicVariable "HVP_Pos_Found";
			};
		};
	};
};

//-----------------------------------
//-DISPLAY WELCOME MESSAGE
private "_version";

_version = _this select 0;
if (HVPGameType isEqualTo 1) then {
	systemChat format["Welcome to Hunter vs Prey, %1",profileName];
};
if (HVPGameType isEqualTo 2) then {
	systemChat format["Welcome to Hunter vs Prey: Crucible, %1",profileName];
};
if (HVPGameType isEqualTo 3) then {
	systemChat format["Welcome to Hunter vs Prey: Predator, %1",profileName];
};
systemChat format["Version: %1",_version];

if (isServer && HVPStatMode isEqualTo 1) then {
	[] spawn STAT_showStats;
};

sleep 1;

//-----------------------------------
//-INIT LOOT, CARS & BOATS
private ["_loot","_veh"];

("HUDProgressBar" call BIS_fnc_rscLayer) cutRsc ["HVPHUDProgressBar","PLAIN",-1,true];
uiNameSpace getVariable "PBarProgress" ctrlSetTextColor [0.2, 0.5, 0.9, 1];

if (isnil ("HVPLootLoaded")) then {
	HVPLootLoaded = "false";
};
if (isnil ("HVPCarsLoaded")) then {
	HVPCarsLoaded = "false";
};
if (isnil ("HVPBoatsLoaded")) then {
	HVPBoatsLoaded = "false";
};

cutText ["LOADING LOOT", "BLACK FADED", 999];

if (isServer) then {
	if (HVPLootMode > 0) then {
		_loot = execVM "loot\sinspawn_init.sqf";
		waitUntil {scriptDone _loot};
		HVPLootLoaded = "true";
		publicVariable "HVPLootLoaded";
	};
} else {
	waitUntil {HVPLootLoaded isEqualTo "true"};
};

cutText ["LOADING VEHICLES", "BLACK FADED", 999];

if (isServer) then {
	if (HVPCarsNumber > 0) then {
		_veh = [HVPCarsNumber] execVM "extra\HVP_vehicSpawn.sqf";
		waitUntil {scriptDone _veh};
		HVPCarsLoaded = "true";
		publicVariable "HVPCarsLoaded";
	};
} else {
	waitUntil {HVPCarsLoaded isEqualTo "true"};
};

if (isServer) then {
	if (HVPCarsNumber > 0) then {
		_veh = [HVPCarsNumber] execVM "extra\HVP_boatSpawn.sqf";
		waitUntil {scriptDone _veh};
		HVPBoatsLoaded = "true";
		publicVariable "HVPBoatsLoaded";
	};
} else {
	waitUntil {HVPBoatsLoaded isEqualTo "true"};
};

//-----------------------------------
//-CACHE
//[AiCacheDistance(players),TargetFPS(-1 for Auto),Debug,CarCacheDistance,AirCacheDistance,BoatCacheDistance]execvm "zbe_cache\main.sqf";
if (isServer) then {[300,60,false,500,2500,500]execvm "zbe_cache\main.sqf"};
//-----------------------------------

("HUDProgressBar" call BIS_fnc_rscLayer) cutText ["","PLAIN"];

//-----------------------------------
//-AMBIANCE INIT
private ["_tpw","_tpwAnim","_tpwAir","_zm"];

if (isServer) then {
	_tpw = [[]] execVM "extra\tpw_core.sqf";	
	// where 10 = start delay, 15 = maximum animals near player, 200 = animals will be removed beyond this distance (m), 75 = minimum distance from player to spawn an animal (m), 60 = maximum time between dog/cat noises (sec)
	_tpwAnim = [10,30,(HVPZoneSizeMax * 1.25),150,60] execVM "extra\tpw_animals.sqf";	
	// where 10 = delay until flybys start (s), 300 = max time between flybys (sec). 0 = disable, 2 = maximum aircraft at a given time,[50,250,500] flying heights to randomly select, 0 = all aircraft (1 = civilian aircraft excluded, 2 = military aircraft excluded)
	_tpwAir = [90,(HVPEventTime/2),1,[20,30,50,70,80],0] execVM "extra\tpw_air.sqf";
};

//-----------------------------------
//-ZONE & EVENT MANAGERS

if (isServer) then {
	execVM "startup\games\phase\manager.sqf";
};

if (isnil ("HVP_phase_num")) then {
	waitUntil {(!isNil ("HVP_phase_num"))};
};
execVM "startup\games\phase\warning.sqf";

//EVENT MANAGER
execVM "startup\games\events\manager.sqf";

//-CRUCIBLE SETTINGS
if (HVPGameType isEqualTo 2) then {
	[player] join grpNull;
	west setFriend [east, 0];
	west setFriend [resistance, 0];
	east setFriend [west, 0];
	east setFriend [resistance, 0];
	resistance setFriend [west, 0];
	resistance setFriend [east, 0];
};
//-PREDATOR SETTINGS
if (HVPGameType isEqualTo 3) then {
	private "_grp";
	west setFriend [east, 1];
	west setFriend [resistance, 0];
	east setFriend [west, 1];
	east setFriend [resistance, 0];
	resistance setFriend [west, 0];
	resistance setFriend [east, 0];
	
	_grp = createGroup WEST;
	sleep 1;
	{
		if (isPlayer _x) then {
			if (side _x isEqualTo WEST || side _x isEqualTo EAST) then {
				[_x] joinSilent grpNull;
				sleep 0.1;
				[_x] joinSilent _grp;
			};
		};
	} forEach allUnits;	
};
//-----------------------------------
//-PLAYER MARKERS
execVM "extra\playermarkers.sqf";
//-----------------------------------
//-INIT SPECTATORS
private "_currentPhase";

if (player isKindOf "VirtualSpectator_F" && !isServer) exitWith {
	[] spawn {
		_currentPhase = HVP_phase_num;
		waitUntil {HVP_phase_num isEqualTo (_currentPhase + 1)};
		("HUDGUILayer" call BIS_fnc_rscLayer) cutRsc ["HVP_HUD","PLAIN"];
		("HUDPhaseLayer" call BIS_fnc_rscLayer) cutRsc ["HVPHUD_phase","PLAIN"];
	};
};
if (player isKindOf "VirtualSpectator_F" && isServer) then {
	[] spawn {
		_currentPhase = HVP_phase_num;
		waitUntil {HVP_phase_num isEqualTo (_currentPhase + 1)};
		("HUDGUILayer" call BIS_fnc_rscLayer) cutRsc ["HVP_HUD","PLAIN"];
		("HUDPhaseLayer" call BIS_fnc_rscLayer) cutRsc ["HVPHUD_phase","PLAIN"];
	};
};

//-----------------------------------
//-ZOMBEES!

if (isnil ("HVPZombiesLoaded")) then {
	HVPZombiesLoaded = "false";
};

if (HVPZombieMode isEqualTo 1) then {
	cutText ["RAISING THE DEAD", "BLACK FADED", 999];
	if (isServer) then {
		[] call HVP_fn_zombies;
		HVP_zombiesLoaded = "true";
		publicVariable "HVPZombiesLoaded";
	} else {
		waitUntil {HVPZombiesLoaded isEqualTo "true"}
	};
};

//-----------------------------------
//-PLAYER LOADOUTS
private "_load";

_load = execVM "startup\loadout\core.sqf";
waitUntil {scriptDone _load};

sleep 1;

//-----------------------------------
//-PLAYER SPAWN

cutText ["PREPARING TO SPAWN", "BLACK FADED", 999];
player setVariable ["HVP_ready", true, true];
player setVariable ["HVP_spawned", false, true];

if (isServer) then {
	call HVP_fn_findSpawns;
};

//-----------------------------------
//-WEATHER CONTROL

if (isServer) then {
	setTimeMultiplier HVPTimeMult;
	execVM "effects\weather.sqf";
};

waitUntil {(player getVariable "HVP_spawned") isEqualTo true};
sleep 5;

//-----------------------------------

playMusic "";
waitUntil {(player getVariable "SMS_isUnconscious") isEqualTo false};
player setCustomAimCoef 0.75;
player enableSimulation true;
enableEnvironment true;
cutText ["", "BLACK IN", 5];

//-----------------------------------
//-HUD Elements

[] spawn {
	private "_currentPhase";
	_currentPhase = HVP_phase_num;
	waitUntil {HVP_phase_num isEqualTo (_currentPhase + 1)};
	("HUDGUILayer" call BIS_fnc_rscLayer) cutRsc ["HVP_HUD","PLAIN",-1,false];
	("HUDAbilLayer" call BIS_fnc_rscLayer) cutRsc ["HVPHUD_ability","PLAIN",-1,false];
	("HUDPhaseLayer" call BIS_fnc_rscLayer) cutRsc ["HVPHUD_phase","PLAIN",-1,false];
	
	if (HVPPhaseType isEqualTo 2) then {
		uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetText "WAITING";
		uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetTextColor [0, 0, 1, 1];
	};
};

//-----------------------------------
//-ABILITY MANAGER

if (HVPAbilitiesEnabled isEqualTo 1) then {
	execVM "effects\abilities\abilitymanager.sqf";
};

if (HVPDebugMode isEqualTo 0) then {
	playSound "intro";
	sleep 1;
	if (HVPGameType isEqualTo 1) then {
		[
			[
				["Welcome to Hunter vs Prey","<t align = 'center' color='#F79727' shadow = '1' size = '1.0' font='PuristaBold'>%1</t><br/>", 20],
				["by Sinbane","<t align = 'center' shadow = '1' size = '0.8'>%1</t>", 15]
			]
		] spawn BIS_fnc_typeText;
	};
	if (HVPGameType isEqualTo 2) then {
		[
			[
				["Welcome to Hunter vs Prey: Crucible","<t align = 'center' color='#F79727' shadow = '1' size = '1.0' font='PuristaBold'>%1</t><br/>", 20],
				["by Sinbane","<t align = 'center' shadow = '1' size = '0.8'>%1</t>", 15]
			]
		] spawn BIS_fnc_typeText;
	};
	if (HVPGameType isEqualTo 3) then {
		[
			[
				["Welcome to Hunter vs Prey: Predator","<t align = 'center' color='#F79727' shadow = '1' size = '1.0' font='PuristaBold'>%1</t><br/>", 20],
				["by Sinbane","<t align = 'center' shadow = '1' size = '0.8'>%1</t>", 15]
			]
		] spawn BIS_fnc_typeText;
	};
};

[] spawn {
//-----------------------------------
//-PLAYER START

	waitUntil {sleep 1; (getPos player select 2) < 1};
	player allowDamage true;
	sleep 1.5;
	
	if (playerSide isEqualTo resistance) then {
		player addRating -10000;
	};

	execVM "startup\sideTasks.sqf";
	if (HVPGameType isEqualTo 1) then {
		maintask = player createSimpleTask ["maintask"];
		maintask setSimpleTaskDescription ["Kill all enemies to crown your team champions of the games","Win The Games",""];
		maintask setTaskState "Assigned";
		["TaskAssigned",["","Win The Games"]] call bis_fnc_showNotification;
	};
	if (HVPGameType isEqualTo 2) then {
		maintask = player createSimpleTask ["maintask"];
		maintask setSimpleTaskDescription ["Kill everyone else to crown yourself Champion of the Crucible","Win The Games",""];
		maintask setTaskState "Assigned";
		["TaskAssigned",["","Win The Games"]] call bis_fnc_showNotification;
	};
	if (HVPGameType isEqualTo 3) then {
		if (playerSide != RESISTANCE) then {
			maintask = player createSimpleTask ["maintask"];
			maintask setSimpleTaskDescription ["Kill The Predator","Win The Games",""];
			maintask setTaskState "Assigned";
			["TaskAssigned",["","Win The Games"]] call bis_fnc_showNotification;
		};
		if (playerSide isEqualTo RESISTANCE) then {
			maintask = player createSimpleTask ["maintask"];
			maintask setSimpleTaskDescription ["Kill The Prey","Win The Games",""];
			maintask setTaskState "Assigned";
			["TaskAssigned",["","Win The Games"]] call bis_fnc_showNotification;
		};
	};

	player action ["nvGogglesOff", player];

	if (side player isEqualTo WEST || side player isEqualTo RESISTANCE) then {
		player action ["GunLightOn", player];
	};
	if (side player isEqualTo EAST && HVPGameType isEqualTo 1) then {
		player action ["nvGoggles", player];
	};

	sleep 8;
	execVM "startup\intro.sqf";
};

//-----------------------------------
//-TESTING CODE
if (HVPTestMode isEqualTo 1) then {
hintSilent "TESTING CODE START";

	
hintSilent "TESTING CODE END";	
};
//-----------------------------------