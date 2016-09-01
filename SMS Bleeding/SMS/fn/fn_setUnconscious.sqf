/*
	fn_setUnconscious
	Author: Sinbane
	Set's a unit unconcious for a max duration
*/
//-----------------------------------

	private ["_unit","_duration"];

	_unit = _this select 0;
	_duration = _this select 1;
	if (_unit != player) exitWith {};
	if ((_unit getVariable "SMS_isUnconscious") isEqualTo true) exitWith {};	
	_unit setVariable ["SMS_isUnconscious", true];
	
	_unit setUnconscious true;
	sleep (10 + (random _duration));
	_unit setUnconscious false;

	if (primaryWeapon _unit isEqualTo "" && secondaryWeapon _unit isEqualTo "" && handgunWeapon _unit isEqualTo "") then {
		_unit addWeapon "hgun_P07_F";
		sleep 0.1;
		_unit removeWeapon "hgun_P07_F";
	};
	
	_unit setVariable ["SMS_isUnconscious", false];