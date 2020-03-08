
func int C_NpcIsWeakToWater(var C_Npc slf)
{
	if (slf.aivar[AIV_MM_REAL_ID] == ID_BLOODFLY)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_SWAMPDRONE)
	|| (slf.guild == GIL_DEMON)
	|| (slf.guild == GIL_FIREGOLEM)
	|| (slf.guild == GIL_Gargoyle) // Fire devil
	|| (slf.guild == GIL_HARPY)
	|| (slf.guild == GIL_SUMMONED_DEMON)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	};
};
