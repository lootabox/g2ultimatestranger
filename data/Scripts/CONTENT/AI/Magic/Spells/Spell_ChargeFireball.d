// ******************
// SPL_ChargeFireball
// ******************

const int SPL_Cost_ChargeFireball		= 160; //4*40
const int STEP_ChargeFireball			= 40;
const int SPL_Damage_ChargeFireball 	= 75;

INSTANCE Spell_ChargeFireball (C_Spell_Proto)
{
	time_per_mana			= 30;
	damage_per_level		= SPL_Damage_ChargeFireball;
	damageType				= DAM_MAGIC;
};

func int Spell_Logic_ChargeFireball (var int manaInvested) 
{
	return Spell_ProcessManaTier(self, manaInvested, STEP_ChargeFireball);
};

func void Spell_Cast_ChargeFireball(var int spellLevel)
{
	self.aivar[AIV_SelectSpell] += 1;
};