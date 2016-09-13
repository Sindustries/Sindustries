	
	while {animationState player isEqualTo "para_pilot"} do {
		if (daytime < 7 || daytime > 17) then {
			if (side player isEqualTo EAST || side player isEqualTo RESISTANCE) then {
				if (HVPGameType isEqualTo 1) then {
					player action ["nvGoggles", player];
				};
			};
			if (side player isEqualTo WEST || HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
				_smoke = "F_20mm_White" createVehicle (player ModelToWorld [0,50,-50]); 
				_smoke setVelocity [0,0,-7];
				sleep 4;
			};
		} else {
			player action ["nvGogglesOff", player];
			if (side player isEqualTo WEST || HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
				_smoke = createVehicle ["SmokeShellBlue", (getposATL player), [], 0, "NONE"];
			};
			sleep 8;
		};		
	};