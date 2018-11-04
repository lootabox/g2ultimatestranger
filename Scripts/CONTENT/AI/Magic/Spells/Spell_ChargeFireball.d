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
	canTurnDuringInvest     = TRUE;
};

func int Spell_Logic_ChargeFireball (var int manaInvested) 
{
	var int STEP_size; STEP_size = STEP_ChargeFireball;
	if (Npc_GetActiveSpellIsScroll(self)) {STEP_size = SPL_Cost_Scroll;};
	
	if (manaInvested == 0)
	{
		if (self.attribute[ATR_MANA] < STEP_size) { return SPL_SENDSTOP; };
		self.attribute[ATR_MANA] -= STEP_size;
		self.aivar[AIV_SpellLevel] = 1; //Start mit Level 1
	}
	else if (manaInvested > (STEP_size*1))
	&& (self.aivar[AIV_SpellLevel] <= 1)
	{
		if (self.attribute[ATR_MANA] < STEP_size) { return SPL_SENDCAST; };
		self.attribute[ATR_MANA] -= STEP_size;
		self.aivar[AIV_SpellLevel] = 2;
		return SPL_NEXTLEVEL; //Lev2 erreicht
	}
	else if (manaInvested > (STEP_size*2))
	&& (self.aivar[AIV_SpellLevel] <= 2)
	{
		if (self.attribute[ATR_MANA] < STEP_size) { return SPL_SENDCAST; };
		self.attribute[ATR_MANA] -= STEP_size;
		self.aivar[AIV_SpellLevel] = 3;
		return SPL_NEXTLEVEL; //Lev3 erreicht
	}
	else if (manaInvested > (STEP_size*3))
	&& (self.aivar[AIV_SpellLevel] <= 3)
	{
		if (self.attribute[ATR_MANA] < STEP_size) { return SPL_SENDCAST; };
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

func void Spell_Cast_ChargeFireball(var int spellLevel)
{
	self.aivar[AIV_SelectSpell] += 1;
};
