
func int C_NpcIsFireBase(var C_Npc slf)
{
	if (slf.guild == GIL_FIREGOLEM)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_FIREWARAN)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_DRAGON_FIRE)
	|| (slf.guild == GIL_GARGOYLE)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	};
};
