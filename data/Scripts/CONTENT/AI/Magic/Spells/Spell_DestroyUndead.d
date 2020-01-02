// *****************
// SPL_DestroyUndead
// *****************

const int	SPL_Cost_DESTROYUNDEAD		=	50;
const int 	SPL_Damage_DESTROYUNDEAD 	= 	100; //soll halt wirklich killen!
const int	SPL_Damage_Per_Mana_DESTROYUNDEAD		=	2;

INSTANCE Spell_DestroyUndead(C_Spell_Proto)
{
	time_per_mana			= 0;
	damage_per_level 		= SPL_Damage_DESTROYUNDEAD;				
	spelltype				= SPELL_NEUTRAL;
};

func int Spell_Logic_DestroyUndead	(var int manaInvested)
{
	return Spell_Logic_Basic(self, SPL_Cost_DESTROYUNDEAD);
};


func void Spell_Cast_DestroyUndead()
{
	Spell_Cast_Basic(self, SPL_Cost_DESTROYUNDEAD);
};
