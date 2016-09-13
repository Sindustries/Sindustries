/*
	HVP Weather Controller
	Author: Sinbane
	Sets weather depending on game mode and time of day
*/
//-----------------------------------
//-TEAM MODE

if (HVPGameType isEqualTo 1) exitWith {
	0 setOvercast 0.7;
	0 setFog 0.8;
	0 setRain (random 0.25);
	forceWeatherChange;
};

//-----------------------------------
//-CRUCIBLE MODE

if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
	private "_time";
	_time = (30 * timeMultiplier);
	
	setWind [0, 0, true];
	[] spawn {
		private ["_onGround","_allUnits"];
		_onGround = {isPlayer _x && isTouchingGround _x} count allUnits;
		_allUnits = {isPlayer _x && side _x != sideLogic} count allUnits;
		while {_onGround != _allUnits} do {
			_onGround = {isPlayer _x && isTouchingGround _x} count allUnits;
			_allUnits = {isPlayer _x && side _x != sideLogic} count allUnits;
			sleep 5;
		};
		sleep 10;
		setWind [0, 0, false];
	};

	if (daytime < 6 && daytime >= 0 || daytime < 24 && daytime > 18) then {
		0 setOvercast (random 0.6);
		0 setFog (random 0.7);
	};
	if (daytime > 6 && daytime <= 18) then {
		0 setOvercast (0.5+(random 0.5));
		0 setFog (random 0.9);
	};
	waitUntil {sleep 1; daytime > 5 && daytime < 6 || daytime > 17 && daytime < 18};
	while {true} do {
		if (daytime > 5 && daytime < 6) then {
			_time setOvercast (0.5+(random 0.5));
			waitUntil {sleep 1; daytime > 6};
			_time setFog (random 0.9);
		};
		if (daytime > 17 && daytime < 18) then {
			_time setOvercast (random 0.6);
			waitUntil {sleep 1; daytime > 18};
			_time setFog (random 0.9);
		};
		sleep 1;
		waitUntil {sleep 1; daytime > 5 && daytime < 6 || daytime > 17 && daytime < 18};
	};
};

//-----------------------------------