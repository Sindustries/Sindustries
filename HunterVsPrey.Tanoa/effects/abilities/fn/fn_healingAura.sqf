/*
	HVP2 Fatigue Free Ability
	By Sinbane
	Grants immunity to fatigue and health regen to nearby friendlies
*/
private ["_regenHP","_regenRate","_abilTime","_pos","_counter","_timer","_time"];
//-----------------------------------
//--VARIABLES

_regenHP = 0.05;
_regenRate = 15;
_abilTime = 120;

_pos = _this select 0;

//-----------------------------------
//-TEAM MODE

if (side player isEqualTo WEST && HVPGameType isEqualTo 1 || HVPGameType isEqualTo 3) then {
	if ((player distance _pos) < 80) then {
		titleText ["TEMPORARY IMMUNITY TO FATIGUE AND HEALTH REGENERATION", "PLAIN DOWN", 0.6];
		
		[_regenHP,_regenRate,_abilTime] spawn HVP_fn_abilHealthRegen;
		
		HVP_isFatiguefree = "true";
		player enableStamina false;
		
		[HVP_cfgFatigueFreeTime] call HVP_fn_abilProgressBar;
		
		player enableStamina true;
		HVP_isFatiguefree = "false";
		
		titleText ["IMMUNITY TO FATIGUE EXPIRED", "PLAIN DOWN", 0.6];
	};
};

//-----------------------------------
//-SOLO MODE

if (HVPGameType isEqualTo 2) then {
	titleText ["TEMPORARY IMMUNITY TO FATIGUE AND HEALTH REGENERATION", "PLAIN DOWN", 0.6];
		
	[_regenHP,_regenRate,_abilTime] spawn HVP_fn_abilHealthRegen;
		
	HVP_isFatiguefree = "true";
	player enableStamina false;
		
	[HVP_cfgFatigueFreeTime] call HVP_fn_abilProgressBar;
		
	player enableStamina true;
	HVP_isFatiguefree = "false";
	
	titleText ["IMMUNITY TO FATIGUE EXPIRED", "PLAIN DOWN", 0.6];
};

//-----------------------------------