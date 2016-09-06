
	player addEventHandler ["HandleDamage", {
		[(_this select 0),(_this select 1),(_this select 2),(_this select 3),(_this select 4)] spawn {
			private ["_unit","_selectionName","_damage","_source","_projectile"];
			_unit = _this select 0;
			_selectionName = _this select 1;
			_damage = _this select 2;
			_source = _this select 3;
			_projectile = _this select 4;
			
			_unit setDamage ((damage _unit)+_damage);
			
			if (_damage >= 0.15) then {
				[_unit,(_damage * SMS_bloodLossCOEF)] spawn SMS_fn_setBleeding;
			};
			if (_damage >= 0.75 && (_unit getVariable "SMS_isUnconscious") isEqualTo false) then {
				[_unit,30] spawn SMS_fn_setUnconscious;
			};
		};
	}];