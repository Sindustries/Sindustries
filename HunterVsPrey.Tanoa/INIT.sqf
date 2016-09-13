/*
	Mission: Hunter vs Prey 2
	Author: Sinbane
	Description: Horror based Battle Royale style Team Deathmatch with custom classes, events & abilities
*/
waitUntil {isPlayer player};
enableSaving [false, false];
enableSentences false;
enableEnvironment false;
//-----------------------------------
//-DEFINE VARIABLES
	
_version = "6.5.20";

//-TIME
HVPTime = (paramsArray select 1);
HVPTimeMult = (paramsArray select 2);
//-GAME
HVPGameType = (paramsArray select 4);
HVPSpawnType = (paramsArray select 5);
HVPManual = (paramsArray select 6);
HVPAbilitiesEnabled = (paramsArray select 7);
HVPPhaseType = (paramsArray select 8);
HVPPhaseSpacing = (paramsArray select 9);
HVPPhaseTime = (paramsArray select 10);
HVPZoneSizeMax = (paramsArray select 11);
//-LOOT, CARS AND EVENTS
HVPLootMode = (paramsArray select 13);
HVPLootChance = (paramsArray select 14);
HVPCarsNumber = (paramsArray select 15);
HVPEventsEnabled = (paramsArray select 16);
HVPExtEvents = (paramsArray select 17);
HVPParanormalEvent = (paramsArray select 18);
HVPEventTime = (paramsArray select 19);
//-EXTRAS
HVPZombieMode = (paramsArray select 21);
HVPAntiCamp = (paramsArray select 22);
HVPStatMode = (paramsArray select 23);
HVPTestMode = (paramsArray select 24);
HVPDebugMode = (paramsArray select 25);

//-----------------------------------

player setVariable ["HVP_ready", false];

if (HVPStatMode isEqualTo 1 && HVPDebugMode isEqualTo 1) then {
	HVPStatMode = 0;
	systemChat "Stat saving disabled -- Debug Mode is enabled";
};

HVPErrorPos = (getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition"));

MISSION_ROOT = call {
    private "_arr";
    _arr = toArray str missionConfigFile;
    _arr resize (count _arr - 15);
    toString _arr
};

//-----------------------------------
//-MOD CHECKS

if (isClass (configfile >> "CfgWeapons" >> "bv_FlashLight")) then {
	HVP_flashlight = true;
} else {
	HVP_flashlight = false;
};

//-----------------------------------

if (worldName isEqualTo "Tanoa") then {
	HVPBlacklist = [[[5089,8439],[10151,13591],[532,1248],[2354,4093],[6023,6875],[1149,9447]]];
} else {
	HVPBlacklist = [];
};

//-----------------------------------
//-LEGACY MODE CHECK

if (isServer) then {
	if (worldName != "Altis" && worldName != "Stratis" && worldName != "Tanoa") then {
		HVPLegacyMode = 1;
		if (HVPDebugMode isEqualTo 1) then {
			systemChat format["Legacy Mode: Enabled for %2",HVPLegacyMode,worldName];
		};
	} else {
		HVPLegacyMode = 0;
		if (HVPDebugMode isEqualTo 1) then {
			systemChat format["Legacy Mode: Disabled for %2",HVPLegacyMode,worldName];
		};
	};
};

//-----------------------------------
//-MOOSIK

HVPMusic = [
"AmbientTrack01_F_EXP",		//Through The Jungle
"AmbientTrack01a_F_EXP",	//" part 1
"AmbientTrack01b_F_EXP",	//" part 2
"Fallout",
"Wasteland",
"MAD",
"BackgroundTrack01_F_EPC",	//Background Track -- Alone
"AmbientTrack01_F_EPB"
];

//-----------------------------------
//-SET TIME OF DAY
if (isServer) then {
	if (HVPTime isEqualTo 50) then {
		HVPTime = floor(random 25);
	};
	if (HVPGameType isEqualTo 1) then {
		setDate [2015, 1, 12, HVPTime, 0];
	};
	if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
		setDate [2015, 8, 11, HVPTime, 0];	
	};
};

//-----------------------------------
//REMOVE FUEL FROM PUMPS
if (HVPGameType isEqualTo 1) then {	
	{ 
		_x setFuelCargo 0;
	} forEach nearestObjects [HVPErrorPos, [
		//Altis, Stratis
		"Land_FuelStation_Feed_F", "Land_fs_feed_F",
		//Tanoa
		"Land_FuelStation_01_pump_F", "Land_FuelStation_02_pump_F"
	], 50000];
};

//-----------------------------------
//-PRE INIT

#include "compile.sqf";

//-----------------------------------
//-ADMIN MENU
//whitelist

SIN_adminUIDs = [
"76561197983563875"		//Jay
];

if ((getPlayerUID player) in SIN_adminUIDs) then {
	execVM "SINadmin\SIN_init.sqf";
};

//-----------------------------------
//-STATS
private "_stats";
if (HVPStatMode isEqualTo 1 && HVPDebugMode isEqualTo 0 && HVPTestMode isEqualTo 0) then {
	_stats = execVM "SIN_stats_init.sqf";
	waitUntil {scriptDone _stats};
};
if (HVPStatMode isEqualTo 2) then {
	_stats = execVM "SIN_stats_init.sqf";
	waitUntil {scriptDone _stats};
	remoteExecCall ["STAT_statReset", 0];
};
//-----------------------------------
//-REDGUN
execVM "effects\redGun.sqf";
//-----------------------------------
//-TOXIC GAS
[] spawn HVP_fn_toxicGas;
//-----------------------------------
//-BLEEDING MODULE
_SMSLoad = [player] execVM "SMS\SMS_init.sqf";
waitUntil {scriptDone _SMSLoad};

//-----------------------------------
//-MAIN STARTUP SCRIPT

waitUntil {time > 0};
_startup = [_version] execVM "start.sqf";
waitUntil {scriptDone _startup};

//-----------------------------------
//-POST INIT
//-----------------------------------
//-WIN CONDITIONS

if (isServer && HVPTestMode isEqualTo 0 && HVPDebugMode isEqualTo 0) then {
	execVM "startup\games\endConditions.sqf";
};
//-----------------------------------
//-TIME SYNC
if (isServer) then {	
	[] spawn {
		while {true} do {
			setDate [(date select 0),(date select 1),(date select 2),(date select 3),(date select 4)];
			sleep 300;
		};
	};
};
//-----------------------------------
//-VEHICLE PENALTY

[] spawn HVP_fn_carPenalty;

//-----------------------------------
//-EXTENDED RED HP
if (side player isEqualTo EAST && HVPGameType isEqualTo 1) then {
	[] spawn HVP_fn_redhp;
};
//-----------------------------------
//-PROXIMITY
if (side player isEqualTo WEST || side player isEqualTo RESISTANCE || HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
	[] spawn HVP_fn_proximity;
};
//-----------------------------------
//-MINE DETECTOR
[] spawn HVP_fn_mineDetector;
//-----------------------------------
//-PLAYER OPTIONS
if (side player isEqualTo EAST && HVPGameType isEqualTo 1) then {
	player enableStamina false;
};
//-----------------------------------
//-VOICES
if (side player isEqualTo EAST || HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3 && playerSide isEqualTo RESISTANCE) then {
	execVM "effects\redSpeech.sqf";
};
//-----------------------------------
//-ANTI CAMP
if (HVPAntiCamp > 0) then {
	[] spawn HVP_fn_antiCamp;
};
//-----------------------------------
//-OVERBURDEN MESSAGE
[] spawn {
	while {alive player} do {
		if (loadAbs player >= 1000 && !isStaminaEnabled player) then {
			systemChat "WARNING: You are carrying too much and will be unable to run when stamina is enabled!";
			showChat true;
		};
		sleep 10;
	};
};
//-----------------------------------
//-PREVENT LOOTING ENEMIES

if (HVPGameType isEqualTo 1) then {
	HVP_antiLoot = {
		waitUntil {dialog};
		closeDialog 106;
		titleText ["YOU CAN'T LOOT THE ENEMY TEAM!", "PLAIN", 3];
	};	
		
	player addEventHandler ["InventoryOpened", {
		private ["_unit","_container"];
		_unit = _this select 0;
		_container = _this select 1;
		
		if (_container isKindOf "man" && !alive _container && side (group _container) != side _unit) exitWith {
			[] spawn HVP_antiLoot;
		};
	}];
};

//-----------------------------------
//-TIPS
execVM "extra\tips.sqf";

//-----------------------------------
//-MUSIC LOOP
/*
[] spawn {
	while {true} do {
		waitUntil {daytime < 6 || daytime > 18};
		sleep 300+(random 300);
		if (daytime < 6 || daytime > 18) then {
			playMusic (selectRandom HVPMusic);
		};
	};
};
*/
//-----------------------------------
//-UNCOMPILE

HVP_fn_findSpawns = nil;
HVP_fn_heliSpawn = nil;
HVP_fn_haloSpawn = nil;
HVP_fn_podSpawn = nil;

//-----------------------------------