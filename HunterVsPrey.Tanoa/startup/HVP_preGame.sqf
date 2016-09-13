/*
	HVP PreGame loot phase
	By Sinbane
	Loads the players into the game in an invulnerable and invincible state
*/
//-----------------------------------
//-SET PLAYERS AS INVISIBLE AND INVULNERABLE

{
	if (isPlayer _x) then {
		hideObjectGlobal _x;
		_x allowDamage false;
	};
} forEach allUnits;

//-----------------------------------
//-SET A SPAWN ON THE GROUND