/*
	HVP Zombie Spawner
	Author: Sinbane
	Grabs zombies from Ryans Zombie & Demon's mod and spawns them at game start around the first phase
*/
private ["_chanceZombie","_maxNum"];
//-----------------------------------

_chanceZombie = 25;
_maxNum = 6;

HVP_maxZombies = 100;
HVP_zombieArray = [];

//-----------------------------------
//-GET ZOMBIES

HVP_zombies = ["RyanZombieC_man_1","RyanZombieC_man_polo_1_F","RyanZombieC_man_polo_2_F","RyanZombieC_man_polo_4_F","RyanZombieC_man_polo_5_F","RyanZombieC_man_polo_6_F","RyanZombieC_man_p_fugitive_F","RyanZombieC_man_w_worker_F","RyanZombieC_scientist_F","RyanZombieC_man_hunter_1_F","RyanZombieC_man_pilot_F","RyanZombieC_journalist_F","RyanZombieC_Orestes","RyanZombieC_Nikos","RyanZombie15","RyanZombie16","RyanZombie17","RyanZombie18","RyanZombie19","RyanZombie20","RyanZombie21","RyanZombie22","RyanZombie23","RyanZombie24","RyanZombie25","RyanZombie26","RyanZombie27","RyanZombie28","RyanZombie29","RyanZombie30","RyanZombie31","RyanZombie32","RyanZombieB_Soldier_02_f","RyanZombieB_Soldier_02_f_1","RyanZombieB_Soldier_02_f_1_1","RyanZombieB_Soldier_03_f","RyanZombieB_Soldier_03_f_1","RyanZombieB_Soldier_03_f_1_1","RyanZombieB_Soldier_04_f","RyanZombieB_Soldier_04_f_1","RyanZombieB_Soldier_04_f_1_1","RyanZombieB_Soldier_05_f","RyanZombieB_Soldier_lite_F","RyanZombieB_Soldier_lite_F_1","RyanZombieB_RangeMaster_F","RyanZombiePlayer1","RyanZombiePlayer2","RyanZombiePlayer3","RyanZombiePlayer4","RyanZombiePlayer5","RyanZombiePlayer6","RyanZombiePlayer7","RyanZombiePlayer8","RyanZombiePlayer9","RyanZombiePlayer10","RyanZombiePlayer11","RyanZombiePlayer12","RyanZombiePlayer13","RyanZombiePlayer14","RyanZombiePlayer15","RyanZombiePlayer16","RyanZombiePlayer17","RyanZombiePlayer18","RyanZombiePlayer19","RyanZombiePlayer20","RyanZombiePlayer21","RyanZombiePlayer22","RyanZombiePlayer23","RyanZombiePlayer24","RyanZombiePlayer25","RyanZombiePlayer26","RyanZombiePlayer27","RyanZombiePlayer28","RyanZombiePlayer29","RyanZombiePlayer30","RyanZombiePlayer31","RyanZombiePlayer32","RyanZombieC_man_1slow","RyanZombieC_man_polo_1_Fslow","RyanZombieC_man_polo_2_Fslow","RyanZombieC_man_polo_4_Fslow","RyanZombieC_man_polo_5_Fslow","RyanZombieC_man_polo_6_Fslow","RyanZombieC_man_p_fugitive_Fslow","RyanZombieC_man_w_worker_Fslow","RyanZombieC_scientist_Fslow","RyanZombieC_man_hunter_1_Fslow","RyanZombieC_man_pilot_Fslow","RyanZombieC_journalist_Fslow","RyanZombieC_Orestesslow","RyanZombieC_Nikosslow","RyanZombie15slow","RyanZombie16slow","RyanZombie17slow","RyanZombie18slow","RyanZombie19slow","RyanZombie20slow","RyanZombie21slow","RyanZombie22slow","RyanZombie23slow","RyanZombie24slow","RyanZombie25slow","RyanZombie26slow","RyanZombie27slow","RyanZombie28slow","RyanZombie29slow","RyanZombie30slow","RyanZombie31slow","RyanZombie32slow","RyanZombieB_Soldier_02_fslow","RyanZombieB_Soldier_02_f_1slow","RyanZombieB_Soldier_02_f_1_1slow","RyanZombieB_Soldier_03_fslow","RyanZombieB_Soldier_03_f_1slow","RyanZombieB_Soldier_03_f_1_1slow","RyanZombieB_Soldier_04_fslow","RyanZombieB_Soldier_04_f_1slow","RyanZombieB_Soldier_04_f_1_1slow","RyanZombieB_Soldier_05_fslow","RyanZombieB_Soldier_lite_Fslow","RyanZombieB_Soldier_lite_F_1slow","RyanZombieB_RangeMaster_Fslow","RyanZombieC_man_1medium","RyanZombieC_man_polo_1_Fmedium","RyanZombieC_man_polo_2_Fmedium","RyanZombieC_man_polo_4_Fmedium","RyanZombieC_man_polo_5_Fmedium","RyanZombieC_man_polo_6_Fmedium","RyanZombieC_man_p_fugitive_Fmedium","RyanZombieC_man_w_worker_Fmedium","RyanZombieC_scientist_Fmedium","RyanZombieC_man_hunter_1_Fmedium","RyanZombieC_man_pilot_Fmedium","RyanZombieC_journalist_Fmedium","RyanZombieC_Orestesmedium","RyanZombieC_Nikosmedium","RyanZombie15medium","RyanZombie16medium","RyanZombie17medium","RyanZombie18medium","RyanZombie19medium","RyanZombie20medium","RyanZombie21medium","RyanZombie22medium","RyanZombie23medium","RyanZombie24medium","RyanZombie25medium","RyanZombie26medium","RyanZombie27medium","RyanZombie28medium","RyanZombie29medium","RyanZombie30medium","RyanZombie31medium","RyanZombie32medium","RyanZombieB_Soldier_02_fmedium","RyanZombieB_Soldier_02_f_1medium","RyanZombieB_Soldier_02_f_1_1medium","RyanZombieB_Soldier_03_fmedium","RyanZombieB_Soldier_03_f_1medium","RyanZombieB_Soldier_03_f_1_1medium","RyanZombieB_Soldier_04_fmedium","RyanZombieB_Soldier_04_f_1medium","RyanZombieB_Soldier_04_f_1_1medium","RyanZombieB_Soldier_05_fmedium","RyanZombieB_Soldier_lite_Fmedium","RyanZombieB_Soldier_lite_F_1medium","RyanZombieB_RangeMaster_Fmedium","RyanZombieC_man_1walker","RyanZombieC_man_polo_1_Fwalker","RyanZombieC_man_polo_2_Fwalker","RyanZombieC_man_polo_4_Fwalker","RyanZombieC_man_polo_5_Fwalker","RyanZombieC_man_polo_6_Fwalker","RyanZombieC_man_p_fugitive_Fwalker","RyanZombieC_man_w_worker_Fwalker","RyanZombieC_scientist_Fwalker","RyanZombieC_man_hunter_1_Fwalker","RyanZombieC_man_pilot_Fwalker","RyanZombieC_journalist_Fwalker","RyanZombieC_Oresteswalker","RyanZombieC_Nikoswalker","RyanZombie15walker","RyanZombie16walker","RyanZombie17walker","RyanZombie18walker","RyanZombie19walker","RyanZombie20walker","RyanZombie21walker","RyanZombie22walker","RyanZombie23walker","RyanZombie24walker","RyanZombie25walker","RyanZombie26walker","RyanZombie27walker","RyanZombie28walker","RyanZombie29walker","RyanZombie30walker","RyanZombie31walker","RyanZombie32walker","RyanZombieB_Soldier_02_fwalker","RyanZombieB_Soldier_02_f_1walker","RyanZombieB_Soldier_02_f_1_1walker","RyanZombieB_Soldier_03_fwalker","RyanZombieB_Soldier_03_f_1walker","RyanZombieB_Soldier_03_f_1_1walker","RyanZombieB_Soldier_04_fwalker","RyanZombieB_Soldier_04_f_1walker","RyanZombieB_Soldier_04_f_1_1walker","RyanZombieB_Soldier_05_fwalker","RyanZombieB_Soldier_lite_Fwalker","RyanZombieB_Soldier_lite_F_1walker","RyanZombieB_RangeMaster_Fwalker","RyanZombieSpider1","RyanZombieSpider2","RyanZombieSpider3","RyanZombieSpider4","RyanZombieSpider5","RyanZombieSpider6","RyanZombieSpider7","RyanZombieSpider8","RyanZombieSpider9","RyanZombieSpider10","RyanZombieSpider11","RyanZombieSpider12","RyanZombieSpider13","RyanZombieSpider14","RyanZombieSpider15","RyanZombieSpider16","RyanZombieSpider17","RyanZombieSpider18","RyanZombieSpider19","RyanZombieSpider20","RyanZombieSpider21","RyanZombieSpider22","RyanZombieSpider23","RyanZombieSpider24","RyanZombieSpider25","RyanZombieSpider26","RyanZombieSpider27","RyanZombieSpider28","RyanZombieSpider29","RyanZombieSpider30","RyanZombieSpider31","RyanZombieSpider32","RyanZombieCrawler1","RyanZombieCrawler2","RyanZombieCrawler3","RyanZombieCrawler4","RyanZombieCrawler5","RyanZombieCrawler6","RyanZombieCrawler7","RyanZombieCrawler8","RyanZombieCrawler9","RyanZombieCrawler10","RyanZombieCrawler11","RyanZombieCrawler12","RyanZombieCrawler13","RyanZombieCrawler14","RyanZombieCrawler15","RyanZombieCrawler16","RyanZombieCrawler17","RyanZombieCrawler18","RyanZombieCrawler19","RyanZombieCrawler20","RyanZombieCrawler21","RyanZombieCrawler22","RyanZombieCrawler23","RyanZombieCrawler24","RyanZombieCrawler25","RyanZombieCrawler26","RyanZombieCrawler27","RyanZombieCrawler28","RyanZombieCrawler29","RyanZombieCrawler30","RyanZombieCrawler31","RyanZombieCrawler32"];

private "_temp";
{_temp = createVehicle [_x,[0,0,0], [], 0, "NONE"]; deleteVehicle _temp;} forEach HVP_zombies;

/*
HVP_zombies = [];
_cfg = (configFile >> "CfgVehicles");
for "_i" from 0 to ((count _cfg)-1) do {
	if (isClass (_cfg select _i)) then {
		_cfgName = configName (_cfg select _i);			
		if (_cfgName isKindOf "Man" && (getNumber ((_cfg select _i) >> "scope") == 2) && (getText ((_cfg select _i) >> "faction") isEqualTo "Ryanzombiesfaction")) then {
			HVP_zombies pushBackUnique _cfgName;
			copyToClipboard str HVP_zombies;
		};
	};
};
*/

//-----------------------------------
//-THE FNCS

HVP_fn_spawnZombies = {
	if ((count HVP_zombieArray) >= HVP_maxZombies) exitWith {};
	private ["_pos","_zombieCount","_zombie","_group"];
	_pos = _this select 0;
	_maxNum = ((_this select 1)+1);
	_group = createGroup resistance;
	
	for "_zombieCount" from 0 to floor(random _maxNum) do {
		if ((count HVP_zombieArray) <= HVP_maxZombies) then {
			_zombie = _group createUnit [(selectRandom HVP_Zombies), _pos, [], 0, "NONE"];
			HVP_zombieArray pushBack _zombie;
		};
	};
	systemChat format["%1 zombies active",(count HVP_zombieArray)];
};

HVP_fn_moveHorde = {
	{
		if (alive _x && (random 100) < 75) then {
			_x doMove HVP_phase_pos;
		};
	} forEach HVP_zombieArray;
};

//-----------------------------------
//-LOOP TO CREATE AND DELETE AS REQUIRED
/*
[_chanceZombie,_maxNum] spawn {
	waitUntil {HVP_phase_num > 0};
	private ["_chanceZombie","_maxNum","_removalZoms","_i","_zombie","_playerPosArray","_count","_roll","_spawnFound","_posCheck","_distCheck"];
	_chanceZombie = _this select 0;
	_maxNum = _this select 1;
	
	while {true} do {
		_removalZoms = [];
		for "_i" from 0 to ((count HVP_zombieArray) - 1) do {
			_zombie = (HVP_zombieArray select _i);
			if (_zombie distance2D HVP_phase_pos > HVP_phase_radius) then {
				deleteVehicle _zombie;
				_removalZoms pushBack _i;
			};
		};
		if ((count _removalZoms) > 0) then {
			systemChat format["Removing %1 zombies",(count _removalZoms)];
			{HVP_ZombieArray deleteAt _x} forEach _removalZoms;
		};
		//SPAWN MORE
		if ((count HVP_zombieArray) < HVP_maxZombies) then {
			_players = [];
			_playerPosArray = [];
			{
				if (isPlayer _x && alive _x) then {
					_players pushBack _x;
					_playerPosArray pushBack (getPos _x);
				};
			} forEach playableUnits;
			for "_count" from 0 to (HVP_phase_radius / 10) do {
				_roll = (random 100);
				if (_roll < _chanceZombie) then {
					_spawnFound = false;
					while {!_spawnFound} do {
						_spawnPos = [(selectRandom _playerPosArray),150,400,0,0,0,0] call BIS_fnc_findSafePos;
						_posCheck = [_spawnPos] call SIN_fnc_checkPos;
						_distCheck = [_spawnPos,_playerPosArray,75] call SIN_fnc_checkDist;
						if (_posCheck && _distCheck) then {
							_spawnFound = true;
							[_spawnPos,_maxNum] spawn HVP_fn_spawnZombies;
						};
					};
				};
			};
		};
		sleep 60;
	};
};
*/

for "_count" from 0 to (HVP_phase_radius / 10) do {
	_roll = (random 100);
	if (_roll < _chanceZombie) then {
		_spawnFound = false;
		while {!_spawnFound} do {
			_spawnPos = [HVP_phase_pos,0,HVP_phase_radius,0,0,0,0] call BIS_fnc_findSafePos;
			_posCheck = [_spawnPos] call SIN_fnc_checkPos;
			if (_posCheck) then {
				_spawnFound = true;
				[_spawnPos,_maxNum] spawn HVP_fn_spawnZombies;
			};
		};
	};
};
	
//-----------------------------------