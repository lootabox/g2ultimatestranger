
func int C_NpcIsIceBase(var C_Npc slf)
{
	if (slf.guild == GIL_ICEGOLEM)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_Icewolf)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_DRAGON_ICE)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	};
};
