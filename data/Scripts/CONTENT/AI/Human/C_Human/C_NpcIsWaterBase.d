
func int C_NpcIsWaterBase(var C_Npc slf)
{
	if (slf.guild == GIL_LURKER)
	|| (slf.guild == GIL_SWAMPSHARK)
	|| (slf.guild == GIL_SWAMPGOLEM)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_Swamprat)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_DRAGON_SWAMP)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	};
};
