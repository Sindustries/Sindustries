/*
	SMS Config
	Author: Sinbane
*/
//-----------------------------------

SMS_maxBlood = 1000;				//Max blood level
SMS_bloodRegen = 15;				//How much blood to be replenished
SMS_bloodRegenRate = 10;			//How often to replish (in sec)
SMS_bleedRate = 8;					//How often bleed ticks happen (in sec)
SMS_passOutNum = 0.50;				//At what % blood to pass out
SMS_passOutChance = 10;				//Change of passing out each bleed tick
SMS_bleedOutNum = 0.10;				//At what % blood to enter bleedout
SMS_bleedoutChance = 10;			//Chance that the player will bleedout each blood tick while lower than bleedout threshold
SMS_bleedDMGMult = 0.025;			//Incoming damage will be multiplied by this to get bleed rate modifier
SMS_bloodLossCOEF = 2.5;			//Overall damage to blood level after adding up damage to all body parts

//-----------------------------------