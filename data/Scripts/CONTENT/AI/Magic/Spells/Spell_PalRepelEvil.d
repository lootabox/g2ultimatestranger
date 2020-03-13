// ****************
// SPL_PalRepelEvil
// ****************

const int SPL_Cost_PalRepelEvil 	= 30;
const int SPL_Damage_PalRepelEvil 	= 300;


INSTANCE Spell_PalRepelEvil (C_Spell_Proto)
{
	time_per_mana			= 0;
	damage_per_level 		= SPL_DAMAGE_PalRepelEvil;
	damageType				= DAM_MAGIC;
	spelltype				= SPELL_NEUTRAL;
};

func int Spell_Logic_PalRepelEvil (var int manaInvested)
{
	return Spell_Logic_Basic(self, SPL_Cost_PalRepelEvil);
};

func void Spell_Cast_PalRepelEvil()
{
	Spell_Cast_Basic(self, SPL_Cost_PalRepelEvil);
};
