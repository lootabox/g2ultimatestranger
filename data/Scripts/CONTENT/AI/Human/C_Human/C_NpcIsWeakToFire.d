
func int C_NpcIsWeakToFire(var C_Npc slf)
{
	if (slf.aivar[AIV_MM_REAL_ID] == ID_DRAGON_ICE)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_ORCSHAMAN)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_ORCWARRIOR)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_SHADOWBEAST)
	|| (slf.guild == GIL_FRIENDLY_ORC) // urshak
	|| (slf.guild == GIL_GIANT_RAT) // giant rat (level < 5), desert rat (level >= 5)
	|| (slf.guild == GIL_ICEGOLEM)
	|| (slf.guild == GIL_SHEEP)
	|| (slf.guild == GIL_SUMMONED_WOLF)
	|| (slf.guild == GIL_TROLL)
	|| (slf.guild == GIL_WOLF) // wolf, warg, ice wolf, boar
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	};
};
