// *****************
// SPL_DestroyUndead
// *****************

const int	SPL_Cost_DESTROYUNDEAD		=	30; //*6
const int 	SPL_Damage_DESTROYUNDEAD	=	75; //soll halt wirklich killen!

INSTANCE Spell_DestroyUndead(C_Spell_Proto)
{
	time_per_mana			= 30;
	damage_per_level 		= SPL_Damage_DESTROYUNDEAD;
	spelltype				= SPELL_NEUTRAL;
};

func int Spell_Logic_DestroyUndead	(var int manaInvested)
{
	//return Spell_Logic_Basic(self, SPL_Cost_DESTROYUNDEAD);
	return Spell_Logic_Invest(self, manaInvested, SPL_Cost_DESTROYUNDEAD, 6, FALSE);
};


func void Spell_Cast_DestroyUndead(var int spellLevel)
{
	//Spell_Cast_Basic(self, SPL_Cost_DESTROYUNDEAD);
	self.aivar[AIV_SelectSpell] += 1;
};
