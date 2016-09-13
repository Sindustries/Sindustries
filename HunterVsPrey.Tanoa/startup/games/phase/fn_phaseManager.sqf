
	private ["_sizeDrop","_shiftPos","_markerName","_markerStr","_newRadius","_newPos"];

	_sizeDrop = _this select 0;
	_shiftPos = _this select 1;
	
	while {true} do {
		//-----------------------------------
		//-CREATE ZONE

		HVP_phase_num = HVP_phase_num + 1;
		publicVariable "HVP_phase_num";
			
		_markername = format["PhaseMark%1",HVP_phase_num];
		_markerstr = createMarker [str(_markername), HVP_phase_pos];
		str(_markername) setMarkerShape "ELLIPSE";
		str(_markername) setMarkerType "EMPTY";
		str(_markername) setMarkerBrush "Border";
		str(_markername) setMarkerColor "Colorblue";
		str(_markername) setMarkerSize [HVP_phase_radius, HVP_phase_radius];
		str(_markername) setMarkerAlpha 1;

		//-----------------------------------
		//-COUNTDOWN
		
		if (HVP_phase_num isEqualTo 1 && HVPPhaseSpacing isEqualTo 2 || HVPPhaseSpacing isEqualTo 1) then {
			[(HVPPhaseTime / 2)] remoteExec ["HVP_phaseClock", 0];
			HVP_phaseClockActive = 1;

			waitUntil {HVP_phaseClockActive isEqualTo 0};
		};
		//-----------------------------------
		//-ACTIVATE PHASE

		str(_markername) setMarkerColor "ColorRed";

		HVP_phase_active = "true";
		publicVariable "HVP_phase_active";

		if (HVPPhaseType isEqualTo 2) then {
			while {HVP_phase_radius >= 2} do {
				HVP_phase_radius = HVP_phase_radius - _sizeDrop;
				publicVariable "HVP_phase_radius";
				str(_markername) setMarkerSize [HVP_phase_radius, HVP_phase_radius];
				HVP_phase_pos = [HVP_phase_pos,0,_shiftPos,0,0,0,0,HVPBlacklist] call BIS_fnc_findSafePos;
				publicVariable "HVP_phase_pos";
				str(_markername) setMarkerPos HVP_phase_pos;
				sleep 1;
			};
			if (HVP_phase_radius isEqualTo 2) exitWith {};
		};
		if (HVP_phase_radius isEqualTo 2) exitWith {};
		
		//-----------------------------------
		//-CREATE GHOST OF WHERE ZONE WILL MOVE TO
		
		_newRadius = (HVP_phase_radius * 0.75);
		_newPos = [HVP_phase_pos,0,_newRadius,0,0,0,0,HVPBlacklist] call BIS_fnc_findSafePos;
		
		_newmarkername = format["NextPhaseMark%1",HVP_phase_num];
		_newmarkerstr = createMarker [str(_newmarkername), _newPos];
		str(_newmarkername) setMarkerShape "ELLIPSE";
		str(_newmarkername) setMarkerType "EMPTY";
		str(_newmarkername) setMarkerBrush "Border";
		str(_newmarkername) setMarkerColor "Colorblue";
		str(_newmarkername) setMarkerSize [_newRadius, _newRadius];
		str(_newmarkername) setMarkerAlpha 0.25;

		//-----------------------------------
		//-COUNTDOWN

		[HVPPhaseTime] remoteExec ["HVP_phaseClock", 0];
		HVP_phaseClockActive = 1;

		waitUntil {HVP_phaseClockActive isEqualTo 0};
		//-----------------------------------
		//-DEACTIVATE PHASE
		
		deleteMarker str(_markername);
		deleteMarker str(_newmarkername);

		HVP_phase_active = "false";
		publicVariable "HVP_phase_active";
		call HVP_announcer;

		//-----------------------------------
		//-GET NEXT PHASE LOCATION

		HVP_phase_radius = _newRadius;
		publicVariable "HVP_phase_radius";
		HVP_phase_pos = _newPos;
		publicVariable "HVP_phase_pos";
		
		HVPPhaseTime = (HVPPhaseTime * 0.75);
		publicVariable "HVPPhaseTime";
		
		if (HVPZombieMode isEqualTo 1) then {
			[] spawn HVP_fn_moveHorde;
		};
		
		//-----------------------------------
		//-CLOSE LOOP
	};