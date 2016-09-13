/*
	Spectator Mode seperate init
*/

player allowDamage false;
player enableSimulation false;
[player,true] remoteExec ["hideObject", 0];

systemChat "SPECTATOR MODE";
	
uisleep 10;

[player, true] call ace_spectator_fnc_stageSpectator;
[true] call ace_spectator_fnc_setSpectator;

enableEnvironment true;
execVM "startup\intro.sqf";

cutText ["", "BLACK IN", 5];