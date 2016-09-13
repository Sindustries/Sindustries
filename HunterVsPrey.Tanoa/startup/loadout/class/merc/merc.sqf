/*
	HVP2 Loadout Manager
	TEAM: Green | Class: Mercenary
	By Sinbane
*/
//-----------------------------------
//-GET VARIABLES

_ammoChance = _this select 0;
_medChance = _this select 1;
_mapChance = _this select 2;
_bombChance = (random 100);

//-----------------------------------
//-UNIFORM

_uniSel = [
"U_I_CombatUniform_tshirt",
"U_I_CombatUniform_shortsleeve",
"U_B_CombatUniform_mcam",
"U_B_CombatUniform_mcam_tshirt",
"U_O_CombatUniform_ocamo",
"U_B_CombatUniform_mcam_worn",
"U_B_SpecopsUniform_sgg",
"U_O_CombatUniform_oucamo",
"U_O_SpecopsUniform_ocamo",
"U_O_SpecopsUniform_blk",
"U_IG_Guerilla2_1",
"U_IG_Guerilla2_3",
"U_IG_leader"
];

_hatSel = [
"H_MilCap_ocamo",
"H_MilCap_mcamo",
"H_MilCap_oucamo",
"H_MilCap_rucamo",
"H_MilCap_gry",
"H_MilCap_dgtl",
"H_MilCap_blue",
"H_Bandanna_khk",
"H_Bandanna_khk_hs",
"H_Bandanna_cbr",
"H_Bandanna_sgg",
"H_Bandanna_gry",
"H_Shemag_olive",
"H_Beret_blk",
"H_Beret_red",
"H_Beret_grn",
"H_Beret_grn_SF",
"H_Beret_brn_SF",
"H_Beret_ocamo",
"H_Watchcap_blk",
"H_Watchcap_cbr",
"H_Watchcap_khk",
"H_Watchcap_camo",
"H_Watchcap_sgg"
];

_ownedDLCs = getDLCs 1;
if (332350 in _ownedDLCs) then {
	_uniforms = ["U_B_CTRG_Soldier_F","U_B_CTRG_Soldier_3_F","U_O_V_Soldier_Viper_F"];
	_goggles = ["G_Balaclava_TI_blk_F","G_Balaclava_TI_tna_F","G_Balaclava_TI_G_blk_F","G_Balaclava_TI_G_tna_F"];
	player addUniform (selectRandom _uniforms);
	player addGoggles (selectRandom _goggles);
} else {
	_uniform = selectRandom _uniSel;
	player addUniform _uniform;
};
	
//_hat = selectRandom _hatSel;

//player addHeadgear _hat;
player linkItem "itemMap";
player addWeapon "Rangefinder";

//-----------------------------------
//-POSSIBLE WEAPONS & AMMO

_weapon = [
"arifle_MX_F", 			//MX
"arifle_MX_Black_F", 	//MX Black
"arifle_MXC_F", 		//MXC
"arifle_MXC_Black_F", 	//MXC Black
"arifle_MX_GL_F", 		//MX 3GL
"arifle_MX_GL_Black_F"	//MX 3GL Black
];

if (332350 in _ownedDLCs) then {
	_add = [
	"arifle_MX_khk_F",
	"arifle_MXC_khk_F",
	"arifle_MX_GL_khk_F"
	];
	
	{_weapon pushBack _x} forEach _add;
};

//-----------------------------------
//-ROLL FOR MAIN WEAPON SELECTION

_weproll = selectRandom _weapon;

if (_ammoChance <= HVPLootChance) then {
	player addMagazines ["30Rnd_65x39_caseless_mag_Tracer", 1];
} else {
	player addMagazines ["9Rnd_45ACP_Mag", 1];
};

if (_weproll == "arifle_MX_GL_F" || _weproll == "arifle_MX_GL_Black_F" || _weproll == "arifle_MX_GL_khk_F") then {
	if (_ammoChance <= HVPLootChance) then {
		player addVest "V_BandollierB_cbr";
		player addMagazines ["1Rnd_SmokeRed_Grenade_shell", 2];
		player addMagazines ["1Rnd_SmokeBlue_Grenade_shell", 2];
		player addMagazines ["UGL_FlareGreen_F", 2];
	} else {
		player addMagazines ["1Rnd_SmokeRed_Grenade_shell", 1];
		player addMagazines ["1Rnd_SmokeBlue_Grenade_shell", 1];
		player addMagazines ["UGL_FlareGreen_F", 1];
	};
};

player addWeapon _weproll;
player addPrimaryWeaponItem "acc_flashlight";
player addWeapon "hgun_ACPC2_F";

//-----------------------------------
//-ROLL FOR NON-STANDARD WEAPONS

if (_bombChance <= HVPLootChance) then {
	player addBackpack "B_Bergen_blk";
	player additem "ToolKit";
	player additem "MineDetector";
	player addMagazines ["APERSTripMine_Wire_Mag", 2];
	player addMagazines ["DemoCharge_Remote_Mag", 1];
	player addMagazines ["APERSBoundingMine_Range_Mag", 1]; 
};

if (_medChance <= HVPLootChance) then {
	player additem "FirstAidKit";
};

//-----------------------------------