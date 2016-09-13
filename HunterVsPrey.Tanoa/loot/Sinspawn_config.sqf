/*
	Sin Loot Spawner Config for HVP2
	Author: Sinbane
	Main settings for Sinspawn
*/
//-----------------------------------
//-CONFIG

_pos = HVP_Pos;						//Pos around which loot will spawn
_size = (HVPZoneSizeMax * 1.25);	//Size of area (radius) from position to spawn loot
_lootChance = HVPLootChance;		//Chance for loot to spawn
_zAdjustHouse = 0.15;				//Height adjustment to prevent loot spawning in the floor
_zAdjustWild = 0.04;				//Same as above, but for wild loot
_safePlace = [0,0,0];				//Don't change
_gunsWithMag = true;				//Whether or not guns should spawn with appropriate mags on same area
_chanceWild = 20;					//% chance of loot spawning in the wild (ignored if wild loot disabled)

//-----------------------------------
//-LOOT SPAWN CHANCES
//------------------ [WEAPONS, MAGS, ITEMS, MEDICAL, CLOTHING, BACKPACKS, SPECIAL CLOTHING, NIGHT VISION]

if (HVPGameType isEqualTo 1) then {
	Sinspawn_lootChance = [5, 20, 8, 4, 10, 5, 0, 0];
};
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
	Sinspawn_lootChance = [20, 45, 12, 4.5, 10, 8, 1.15, 1.9];
};

//-----------------------------------