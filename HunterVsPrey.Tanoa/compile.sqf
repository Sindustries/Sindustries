/*
	HVP fn compile
	Author: Sinbane
	Pre-compiles all critical fnc's to save time later and unclutter init.sqf
*/
//-----------------------------------
//-MAIN
SIN_fnc_checkPos = compile preProcessFileLineNumbers "fnc\SIN_fnc_checkPos.sqf";
SIN_fnc_checkDist = compile preProcessFileLineNumbers "fnc\SIN_fnc_checkDist.sqf";
HVP_phaseManager = compile preProcessFileLineNumbers "startup\games\phase\fn_phaseManager.sqf";
HVP_phaseClock = compile preProcessFileLineNumbers "startup\games\phase\fn_phaseClock.sqf";
HVP_fn_updateProgressBar = compile preProcessFileLineNumbers "fnc\fn_updateProgressBar.sqf";

//-SPAWN
HVP_fn_findSpawns = compile preProcessFileLineNumbers "startup\spawn\fn_findSpawns.sqf";
HVP_fn_heliSpawn = compile preProcessFileLineNumbers "startup\spawn\fn_heli.sqf";
HVP_fn_haloSpawn = compile preProcessFileLineNumbers "startup\spawn\fn_paradrop.sqf";
HVP_fn_podSpawn = compile preProcessFileLineNumbers "startup\spawn\fn_dropPod.sqf";

//-GAME
HVP_fn_antiCamp = compile preProcessFileLineNumbers "extra\fn_antiCamp.sqf";
HVP_fn_carPenalty = compile preProcessFileLineNumbers "effects\fn_carPenalty.sqf";
HVP_fn_mineDetector = compile preProcessFileLineNumbers "effects\fn_mineDetector.sqf";
HVP_fn_proximity = compile preProcessFileLineNumbers "effects\fn_redProximity.sqf";
HVP_fn_redHp = compile preProcessFileLineNumbers "effects\fn_redhp.sqf";
HVP_fn_toxicGas = compile preProcessFileLineNumbers "effects\fn_toxicGas.sqf";
HVP_fn_zombies = compile preProcessFileLineNumbers "extra\fn_zombies.sqf";

//-PHASE
HVP_fn_deathLoop = compile preProcessFileLineNumbers "startup\games\phase\fn_deathLoop.sqf";

//-EVENTS
HVP_fn_showEventIcon = compile preProcessFileLineNumbers "startup\games\events\fn\fn_showEventIcon.sqf";
HVP_fn_hideEventIcon = compile preProcessFileLineNumbers "startup\games\events\fn\fn_hideEventIcon.sqf";
HVP_airdropEvent = compile preProcessFileLineNumbers "startup\games\events\fn\HVP_airdropEvent.sqf";
SIN_fnc_airdropLoot = compile preProcessFileLineNumbers "fnc\SIN_fnc_airdropLoot.sqf";
HVP_artilleryEvent = compile preProcessFileLineNumbers "startup\games\events\fn\HVP_artilleryEvent.sqf";
HVP_quakeEvent = compile preProcessFileLineNumbers "startup\games\events\fn\HVP_quakeEvent.sqf";
HVP_fn_quakeFX = compile preProcessFileLineNumbers "effects\fn_quakeFX.sqf";
HVP_uavEvent = compile preProcessFileLineNumbers "startup\games\events\fn\HVP_uavEvent.sqf";
HVP_chemAttackEvent = compile preProcessFileLineNumbers "startup\games\events\fn\HVP_chemAttackEvent.sqf";
HVP_heliCrashEvent = compile preProcessFileLineNumbers "startup\games\events\fn\HVP_helicrashEvent.sqf";
SIN_fnc_helicrashLoot = compile preProcessFileLineNumbers "fnc\SIN_fnc_helicrashLoot.sqf";
HVP_podEvent = compile preProcessFileLineNumbers "startup\games\events\fn\HVP_dropPodEvent.sqf";

//-ABILITIES
HVP_fn_abilProgressBar = compile preprocessFileLineNumbers "effects\abilities\fn\fn_progressBar.sqf";
HVP_fn_abilBiohazard = compile preprocessFileLineNumbers "effects\abilities\fn\fn_biohazard.sqf";
HVP_fn_abilBlackout = compile preprocessFileLineNumbers "effects\abilities\fn\fn_blackout.sqf";
HVP_fn_abilCloak = compile preprocessFileLineNumbers "effects\abilities\fn\fn_cloak.sqf";
HVP_fn_abilFatigueAura = compile preprocessFileLineNumbers "effects\abilities\fn\fn_fatigueAura.sqf";
HVP_fn_abilHealingAura = compile preprocessFileLineNumbers "effects\abilities\fn\fn_healingAura.sqf";
HVP_fn_abilHealthRegen = compile preprocessFileLineNumbers "effects\abilities\fn\fn_healthRegen.sqf";
HVP_fn_abilNVThief = compile preprocessFileLineNumbers "effects\abilities\fn\fn_NVThief.sqf";
HVP_fn_abilReveal = compile preprocessFileLineNumbers "effects\abilities\fn\fn_reveal.sqf";
HVP_fn_abilDisarm = compile preprocessFileLineNumbers "effects\abilities\fn\fn_disarm.sqf";
HVP_fn_abilBanish = compile preprocessFileLineNumbers "effects\abilities\fn\fn_banish.sqf";

//-----------------------------------