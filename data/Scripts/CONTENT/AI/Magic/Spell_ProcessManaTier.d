func int Spell_ProcessManaTier(var C_NPC slf, var int manaInvested, var int STEP_size)
{
	var int STEP_cost; STEP_cost = STEP_size;
	if (Npc_GetActiveSpellIsScroll(slf)) {STEP_cost = SPL_Cost_Scroll;};

	if (manaInvested == 0) {
		slf.aivar[AIV_SpellLevel] = 0; // make sure to start at 0
		if (slf.attribute[ATR_MANA] < STEP_cost) { return SPL_SENDSTOP; }; // plays special animation at manaInvested 0
	};

	var int tier; tier = manaInvested / STEP_size;
	if (slf.aivar[AIV_SpellLevel] < tier)
	{
		if (tier == 4)
		{
			return SPL_SENDCAST; // fire latest at 4x STEP_size
		};
		if (slf.attribute[ATR_MANA] < STEP_cost) { return SPL_SENDCAST; }; // fire instead of advancing if not enough mana
		slf.attribute[ATR_MANA] -= STEP_cost;
		slf.aivar[AIV_SpellLevel] = tier;
		return SPL_NEXTLEVEL; // advance tier
	};
	return SPL_STATUS_CANINVEST_NO_MANADEC; // can invest, cannot advance
};
