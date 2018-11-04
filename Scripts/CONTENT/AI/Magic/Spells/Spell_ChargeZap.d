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
	var int STEP_size; STEP_size = STEP_ChargeZap;
	if (Npc_GetActiveSpellIsScroll(self)) {STEP_size = SPL_Cost_Scroll;};
	if (self.aivar[AIV_SpellLevel] < 4 && self.attribute[ATR_MANA]<STEP_size)
	{
		return SPL_SENDCAST;
	}
	else if (manaInvested == 0)
	{
		self.attribute[ATR_MANA] -= STEP_size;
		self.aivar[AIV_SpellLevel] = 1; //Start mit Level 1
	}
	else if (manaInvested > (STEP_size*1))
	&& (self.aivar[AIV_SpellLevel] <= 1)
	{
		self.attribute[ATR_MANA] -= STEP_size;
		self.aivar[AIV_SpellLevel] = 2;
		return SPL_NEXTLEVEL; //Lev2 erreicht
	}
	else if (manaInvested > (STEP_size*2))
	&& (self.aivar[AIV_SpellLevel] <= 2)
	{
		self.attribute[ATR_MANA] -= STEP_size;
		self.aivar[AIV_SpellLevel] = 3;
		return SPL_NEXTLEVEL; //Lev3 erreicht
	}
	else if (manaInvested > (STEP_size*3))
	&& (self.aivar[AIV_SpellLevel] <= 3)
	{
		self.attribute[ATR_MANA] -= STEP_size;
		self.aivar[AIV_SpellLevel] = 4;
		return SPL_NEXTLEVEL; //Lev4 erreicht
	}
	else if (manaInvested > (STEP_size*4))
	&& (self.aivar[AIV_SpellLevel] == 4)
	{
		return SPL_SENDCAST;
	};
	return SPL_STATUS_CANINVEST_NO_MANADEC;
};

func void Spell_Cast_ChargeZap(var int spellLevel)
{
	self.aivar[AIV_SelectSpell] += 1;
};
