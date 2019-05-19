
func int Spell_Logic_Basic (var c_npc slf, var int manaCost)
{
	if (Npc_GetActiveSpellIsScroll(slf) && (slf.attribute[ATR_MANA] >= C_GetScrollCost(manaCost)))
	{
		return SPL_SENDCAST;
	}
	else if (slf.attribute[ATR_MANA] >= manaCost)
	{	
		return SPL_SENDCAST;
	}
	else
	{
		return SPL_SENDSTOP;
	};
};

func void Spell_Cast_Basic (var c_npc slf, var int manaCost)
{
	if (Npc_GetActiveSpellIsScroll(slf))
	{
		slf.attribute[ATR_MANA] -= C_GetScrollCost(manaCost);
	}
	else
	{
		slf.attribute[ATR_MANA] -= manaCost;
	};
	slf.aivar[AIV_SelectSpell] += 1;
};

func int Spell_Logic_Invest(var C_NPC slf, var int manaInvested, var int STEP_size, var int maxLevel)
{
	var int STEP_cost; STEP_cost = STEP_size;
	if (Npc_GetActiveSpellIsScroll(slf)) {STEP_cost = C_GetScrollCost(STEP_cost);};

	if (manaInvested == 0) {
		if (slf.attribute[ATR_MANA] < STEP_cost) { return SPL_SENDSTOP; }; // plays special animation at manaInvested 0
		slf.attribute[ATR_MANA] -= STEP_cost;
		slf.aivar[AIV_SpellLevel] = 0; // make sure to start at 0
	};

	var int tier; tier = manaInvested / STEP_size;
	if (slf.aivar[AIV_SpellLevel] < tier)
	{
		if (tier == maxLevel)
		{
			return SPL_SENDCAST; // fire latest at max level
		};
		if (slf.attribute[ATR_MANA] < STEP_cost) { return SPL_SENDCAST; }; // fire instead of advancing if not enough mana
		slf.attribute[ATR_MANA] -= STEP_cost;
		slf.aivar[AIV_SpellLevel] = tier;
		return SPL_NEXTLEVEL; // advance tier
	};
	return SPL_STATUS_CANINVEST_NO_MANADEC; // can invest, cannot advance
};

