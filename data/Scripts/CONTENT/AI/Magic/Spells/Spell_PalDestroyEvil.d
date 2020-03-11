// ******************
// SPL_PalDestroyEvil
// ******************

const int SPL_Cost_PalDestroyEvil 			= 40;	
const int SPL_Damage_PalDestroyEvil 		= 400; 

INSTANCE Spell_PalDestroyEvil (C_Spell_Proto)
{
	time_per_mana			= 0;
	damage_per_level 		= SPL_DAMAGE_PalDestroyEvil;
	spelltype				= SPELL_NEUTRAL;
};

func int Spell_Logic_PalDestroyEvil	(var int manaInvested)
{
	return Spell_Logic_Basic(self, SPL_Cost_PalDestroyEvil);
};

func void Spell_Cast_PalDestroyEvil()
{
	Spell_Cast_Basic(self, SPL_Cost_PalDestroyEvil);
};
