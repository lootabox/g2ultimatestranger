// ******************
// SPL_Geyser	K3
// ******************

const int SPL_Cost_Geyser 				= 75;
const int SPL_Damage_Geyser 			= 150; 


INSTANCE Spell_Geyser	(C_Spell_Proto)
{							
	time_per_mana			= 0;
	damage_per_level		= SPL_Damage_Geyser;
	damageType				= DAM_MAGIC;
};

func int Spell_Logic_Geyser (var int manaInvested) //Parameter wird hier nicht gebraucht
{
	return Spell_Logic_Basic(self, SPL_Cost_Geyser);
};

func void Spell_Cast_Geyser()
{
	Spell_Cast_Basic(self, SPL_Cost_Geyser);
};
