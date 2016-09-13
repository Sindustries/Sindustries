/*
	HVP loadout Config
	Author: Sinbane
*/
//-----------------------------------
//-VARIABLES

_ammoChance = (random 100);
_medChance = (random 100);
_mapChance = (random 100);
_gunRoll = (random 100);

//-----------------------------------
//-BLUE/CRU UNIFORM SELECTION

_uniSel = [
"U_IG_Guerilla1_1",
"U_IG_Guerilla2_1",
"U_IG_Guerilla2_2",
"U_IG_Guerilla2_3",
"U_IG_Guerilla3_1",
"U_IG_Guerilla3_2",
"U_I_G_Story_Protagonist_F",
"U_I_G_resistanceLeader_F",
"U_IG_Guerrilla_6_1"
];

if (332350 in (getDLCs 1)) then {
	_uniSel2 = [
	"U_I_C_Soldier_Bandit_1_F",
	"U_I_C_Soldier_Bandit_2_F",
	"U_I_C_Soldier_Bandit_3_F",
	"U_I_C_Soldier_Bandit_4_F",
	"U_I_C_Soldier_Bandit_5_F"
	];
	{_uniSel pushback _x} forEach _uniSel2;
};

_hatSel = [
"H_Booniehat_oli",
"H_Cap_blk",
"H_Cap_grn_BI",
"H_Cap_usblack",
"H_MilCap_oucamo",
"H_MilCap_gry",
"H_Bandanna_surfer",
"H_Bandanna_khk",
"H_Bandanna_gry",
"H_Beret_blk",
"H_Beret_blk_POLICE",
"H_Watchcap_blk",
"H_Hat_blue"
];

//-----------------------------------
//-RED TEAM GHILLIE SELECTION

if (332350 in (getDLCs 1)) then {
	cfg_ghillies = [
	"U_B_FullGhillie_lsh",
	"U_B_FullGhillie_sard",
	"U_B_FullGhillie_ard",
	"U_O_FullGhillie_lsh",
	"U_O_FullGhillie_sard",
	"U_O_FullGhillie_ard",
	"U_I_FullGhillie_lsh",
	"U_I_FullGhillie_sard",
	"U_I_FullGhillie_ard",
	"U_O_T_FullGhillie_tna_F",
	"U_B_T_FullGhillie_tna_F"
	];
} else {
	cfg_ghillies = [
	"U_B_GhillieSuit",
	"U_O_GhillieSuit",
	"U_I_GhillieSuit"
	];
};

//-----------------------------------
//-PERSONALISED GEAR
/* allowed items: headgear */

_userGear = [
/*JAY*/
["76561197983563875","H_Cap_usblack"],
/*VELTEN*/
["76561198020161760","H_Hat_blue"]
];

//-----------------------------------