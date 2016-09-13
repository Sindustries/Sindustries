/*
	HVP2 Player Marker Script
	By Sinbane
	Tags units on the map depending on game type
*/
//-----------------------------------
//-TEAM MODE
if (HVPGameType == 1 && HVPDebugMode == 0) then {
	if (player isKindOf "O_Soldier_TL_F" || player isKindOf "B_Soldier_TL_F" || player isKindOf "I_medic_F") then {
		waitUntil {!isNull player && isPlayer player};
		
		[] spawn {
			 private["_unitName", "_aMarker", "_mySide","_aMarkername"];
			_mySide = (side player);
			
			{
				if ((side _x) == _mySide && isPlayer _x) then {
					_unitName = name _x;
					_aMarkername = format["TEAMMarker: %1",(vehicleVarName _x)];
					_aMarker = createMarkerLocal [_aMarkername,[0,0]];
					_aMarker setMarkerShapeLocal "ICON";
					_aMarker setMarkerTypeLocal "mil_dot";
					_aMarker setMarkerTextLocal _unitName;
					_aMarker setMarkerSizeLocal [0.75,0.75];
					_aMarker setMarkerTextLocal _unitName;
					_aMarker setMarkerAlphaLocal 0.75;
					
					if (side player == WEST) then {
						_aMarker setMarkerColorLocal "colorBlufor";
					};
					if (side player == EAST) then {
						_aMarker setMarkerColorLocal "colorOpfor";
					};
					if (side player == RESISTANCE) then {
						_aMarker setMarkerColorLocal "colorIndependent";
					};
					
					while {alive _x} do {				
						_aMarker setMarkerDirLocal (getDir _x);
						_aMarker setMarkerPosLocal (getPos _x);
						sleep 0.1;
					};
					if (!alive _x) exitWith {
						_aMarker setMarkerTypeLocal "KIA";
						_aMarker setMarkerDirLocal 0;
						_aMarker setMarkerColorLocal "colorRED";
					};
				};
			} forEach playableUnits;
		};
	};
};

//-----------------------------------
//-CRUCIBLE MODE

if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3 && HVPDebugMode == 0) then {
    waitUntil {!isNull player && isPlayer player};
	
    [] spawn {
		private["_unitName","_aMarker","_aMarkername"];
		if (isPlayer player) then {
			_unitName = name player;
			_aMarkername = format["CRUMarker: %1",(vehicleVarName player)];
			_aMarker = createMarkerLocal [_aMarkername,[0,0]];
			_aMarker setMarkerShapeLocal "ICON";
			_aMarker setMarkerTypeLocal "mil_dot";
			_aMarker setMarkerTextLocal _unitName;
			_aMarker setMarkerSizeLocal [0.75,0.75];
			_aMarker setMarkerAlphaLocal 0.75;
			_aMarker setMarkerColorLocal "colorBlufor";			

			while {alive player} do {				
				_aMarker setMarkerDirLocal (getDir player);
				_aMarker setMarkerPosLocal (getPos player);
				sleep 0.1;
			};
			if (!alive player) exitWith {
				_aMarker setMarkerTypeLocal "KIA";
				_aMarker setMarkerDirLocal 0;
				_aMarker setMarkerColorLocal "colorRED";
			};
		};
	};
};

//-----------------------------------
//-DEBUG MODE

if (HVPDebugMode == 1) then {
    waitUntil {!isNull player && isPlayer player};
	
	[] spawn {		
		{
			private["_unitName","_aMarker","_aMarkername"];
			if (side _x != sideLogic) then {
				_unitName = name _x;
				_aMarkername = format["DbgMarker: %1",(vehicleVarName _x)];
				_aMarker = createMarkerLocal [_aMarkername,[0,0]];
				_aMarker setMarkerShapeLocal "ICON";
				_aMarker setMarkerTypeLocal "mil_dot";
				_aMarker setMarkerTextLocal _unitName;
				_aMarker setMarkerSizeLocal [0.75,0.75];
				_aMarker setMarkerAlphaLocal 0.75;
				
				if (side _x == WEST) then {
					_aMarker setMarkerColorLocal "colorBlufor";
				};
				if (side _x == EAST) then {
					_aMarker setMarkerColorLocal "colorOpfor";
				};
				if (side _x == RESISTANCE) then {
					_aMarker setMarkerColorLocal "colorIndependent";
				};				

				while {alive _x} do {				
					_aMarker setMarkerDirLocal (getDir _x);
					_aMarker setMarkerPosLocal (getPos _x);
					sleep 0.1;
				};
				if (!alive _x) exitWith {
					_aMarker setMarkerTypeLocal "KIA";
					_aMarker setMarkerDirLocal 0;
					_aMarker setMarkerColorLocal "colorRED";
				};
			};
		} forEach playableUnits;
	};
};

//-----------------------------------