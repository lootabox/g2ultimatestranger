// ******************
// SPL_ChargeZap
// ******************

const int SPL_Cost_ChargeZap		= 10; //*4
const int SPL_Damage_ChargeZap 		= 30;

INSTANCE Spell_ChargeZap (C_Spell_Proto)
{
	time_per_mana			= 100;
	damage_per_level		= SPL_Damage_ChargeZap;
	damageType				= DAM_MAGIC;
};

func int Spell_Logic_ChargeZap (var int manaInvested) 
{
	return Spell_Logic_Invest(self, manaInvested, SPL_Cost_ChargeZap, 4, FALSE);
};

func void Spell_Cast_ChargeZap(var int spellLevel)
{
	self.aivar[AIV_SelectSpell] += 1;
};
