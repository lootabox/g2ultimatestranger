
func int C_NpcIsWeakToLightning(var C_Npc slf)
{
	if (slf.aivar[AIV_MM_REAL_ID] == ID_DRAGON_SWAMP)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_ORCELITE)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_SWAMPRAT)
	|| (slf.guild == GIL_GIANT_BUG) // field raider
	|| (slf.guild == GIL_GOBBO) && (slf.level >= 15) // goblin warriors
	|| (slf.guild == GIL_LURKER)
	|| (slf.guild == GIL_MEATBUG)
	|| (slf.guild == GIL_MINECRAWLER) // minecrawler, minecrawler warrior, mantis
	|| (slf.guild == GIL_SWAMPGOLEM)
	|| (slf.guild == GIL_SWAMPSHARK)
	{
		return TRUE;
	}
	else if (C_BodyStateContains(slf,BS_SWIM))
		|| (C_BodyStateContains(slf,BS_DIVE))
		|| (GetWaterLevel(slf) == WATERLEVEL_WADE)
		//|| (Wld_IsRaining() && (CurrentLevel == NEWWORLD_ZEN || CurrentLevel == OLDWORLD_ZEN || CurrentLevel == ADDONWORLD_ZEN))
	{
		return TRUE;
	}
	else if (Buff_Has(slf, elemental_weakness))
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	};
};
