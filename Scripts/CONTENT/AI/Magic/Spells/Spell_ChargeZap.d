// ******************
// SPL_ChargeZap
// ******************

const int SPL_Cost_ChargeZap		= 40; //4*10
const int STEP_ChargeZap			= 10;
const int SPL_Damage_ChargeZap 		= 30;

INSTANCE Spell_ChargeZap (C_Spell_Proto)
{
	time_per_mana			= 100;
	damage_per_level		= SPL_Damage_ChargeZap;
	damageType				= DAM_MAGIC;	
	canTurnDuringInvest     = TRUE;
};

func int Spell_Logic_ChargeZap (var int manaInvested) 
{
	return Spell_ProcessManaTier(self, manaInvested, STEP_ChargeZap);
};

func void Spell_Cast_ChargeZap(var int spellLevel)
{
	self.aivar[AIV_SelectSpell] += 1;
};
