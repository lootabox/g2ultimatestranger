// ************
// SPL_WindFist
// ************

const int SPL_Cost_WindFist				= 80; //4*20
const int STEP_WindFist					= 20;
const int SPL_Damage_WindFist			= 50;

INSTANCE Spell_WindFist (C_Spell_Proto)
{
	time_per_mana			= 30;
	damage_per_level		= SPL_Damage_WindFist;			//pro Level !!!
	damageType				= DAM_FLY;
	canTurnDuringInvest     = TRUE;
	
	targetCollectAlgo		= TARGET_COLLECT_FOCUS_FALLBACK_NONE;
	targetCollectRange		= 1000;
	targetCollectType		= TARGET_TYPE_NPCS;
};

func int Spell_Logic_WindFist (var int manaInvested)
{
	var int STEP_size; STEP_size = STEP_WindFist;
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

func void Spell_Cast_WindFist(var int spellLevel)
{
	self.aivar[AIV_SelectSpell] += 1;
};
