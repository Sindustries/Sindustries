/*
	fn_monitor
	Author: Sinbane
	Monitors unit vitals & gives option to heal up and stop bleeding when above 75% health
*/
//-----------------------------------

	private ["_unit","_action","_healAction"];

	_unit = _this select 0;
	
	while {alive _unit} do {
	
		waitUntil {(damage _unit) > 0 && (damage _unit) < 0.25 && (_unit getVariable "SMS_bloodLevel") < SMS_maxBlood && "FirstAidKit" in (items player)};
		_action = true;
		
		_healAction = _unit addAction ["Treat Wounds", {
			private ["unit"];
			_unit = _this select 0;
			_unit action ["HealSoldierSelf", _unit];
			_unit removeItem "FirstAidKit";
			waitUntil {animationState player isEqualTo "ainvpknlmstpslaywnondnon_medic" || animationState player isEqualTo "ainvppnemstpslaywnondnon_medic"};
			waitUntil {animationState player != "ainvpknlmstpslaywnondnon_medic" || animationState player != "ainvpknlmstpslaywnondnon_medic"};
			_unit setDamage 0;
			_unit setVariable ["SMS_bleedingRate", 0];
			_unit removeAction (_this select 2);
		}];
		
		while {_action} do {
			if ((damage _unit) isEqualTo 0 || (damage _unit) > 0.25) then {
				_action = false;
				_unit removeAction _healAction;
			};
			if ((_unit getVariable "SMS_bloodLevel") isEqualTo SMS_maxBlood) then {
				_action = false;
				_unit removeAction _healAction;
			};
			if (!("FirstAidKit" in items player)) then {
				_action = false;
				_unit removeAction _healAction;
			};
			sleep 0.5;
		};
		_action = false;
		sleep 0.5;
	};