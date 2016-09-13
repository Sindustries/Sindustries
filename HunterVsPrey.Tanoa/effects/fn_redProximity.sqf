/* 
	Stamina Proximity
	By Sinbane
	Enables Stamina on Blue and Green teams when within a certain distance of a Red team member
*/
private ["_warnDist","_stamEnableDist","_stamDrainDist","_proxPlayer","_curStam"];
waitUntil {time > 0};
player enableStamina false;
//-----------------------------------
//-VARIABLES

_warnDist = 300;
_stamEnableDist = 200;
_stamDrainDist = 100;

if (isnil ("HVP_isFatiguefree")) then {HVP_isFatiguefree = "false"};
HVP_proximityPlayer = [];
HVP_proximityActive = false;

HVP_proximityChecker = {
//-----------------------------------
while {alive player} do {
//-----------------------------------
	
	private ["_proxPlayer","_warnDist","_stamEnableDist","_stamDrainDist"];
	_proxPlayer = _this select 0;
	_warnDist = _this select 1;
	_stamEnableDist = _this select 2;
	_stamDrainDist = _this select 3;
	
	player enableStamina false;
	
	while {alive _proxPlayer} do {
		if (player distance _proxPlayer > _warnDist && !HVP_proximityActive) then {
			player enableStamina false;
		};
		
		if ((player distance _proxPlayer) < _warnDist && !HVP_proximityActive || !alive _proxPlayer) then {
			if (!alive _proxPlayer) exitWith {};
			HVP_proximityActive = true;
			enableCamShake true;
			addCamShake [1, 6, 33];
			
			while {HVP_proximityActive && alive _proxPlayer} do {
				waitUntil {sleep 1; (player distance _proxPlayer) < _stamEnableDist || (player distance _proxPlayer) > _warnDist || !alive _proxPlayer};
				if (!alive _proxPlayer) exitWith {};
				if ((player distance _proxPlayer) > _warnDist) then {
					HVP_proximityActive = false;
				};
				if ((player distance _proxPlayer) < _stamEnableDist && HVP_isFatiguefree isEqualTo "false") then {
					player enableStamina true;
					waitUntil {sleep 1; (player distance _proxPlayer) > _stamEnableDist || (player distance _proxPlayer) < _stamDrainDist || !alive _proxPlayer};
					if (!alive _proxPlayer) exitWith {};
					if ((player distance _proxPlayer) < _stamDrainDist) then {
						while {(player distance _proxPlayer) < _stamDrainDist} do {
							if (!alive _proxPlayer) exitWith {};
							_curStam = getStamina player;
							if ((speed player) > 0) then {
								player setStamina (_curStam - 1);
							} else {
								player setStamina (_curStam - 2);
							};
							sleep 0.1;
						};
					};
				};
				HVP_proximityActive = false;
				player enableStamina false;
				sleep 1;
			};
		};
	};
	HVP_proximityActive = false;
	player enableStamina false;
	
	sleep 3;
	
//-----------------------------------
};
};
//-----------------------------------
//-TEAM MODE
if (HVPGameType isEqualTo 1) then {
	{
		if (isPlayer _x && side _x isEqualTo EAST && _x != player) then {
			HVP_proximityPlayer pushBack _x;
		};
	} forEach allunits;
};

if (HVPGameType isEqualTo 2) then {
	{
		if (isPlayer _x && _x != player) then {
			HVP_proximityPlayer pushBack _x;
		};
	} forEach allunits;
};

if (HVPGameType isEqualTo 3) then {
	{
		if (isPlayer _x && _x != player && side _x isEqualTo RESISTANCE) then {
			HVP_proximityPlayer pushBack _x;
		};
	} forEach allunits;
};



for [{_t=1}, {_t<=count HVP_proximityPlayer}, {_t=_t+1}] do {
	_indexNum = _t-1;
	_proxPlayer = HVP_proximityPlayer select _indexNum;
	[_proxPlayer,_warnDist,_stamEnableDist,_stamDrainDist] spawn HVP_proximityChecker;
};

//-----------------------------------