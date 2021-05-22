
func int C_NpcIsWeakToIce(var C_Npc slf)
{
	if (slf.aivar[AIV_MM_REAL_ID] == ID_Bloodhound)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_DRAGON_FIRE)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_MOLERAT)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_ORCWARRIOR)
	|| (slf.aivar[AIV_MM_REAL_ID] == ID_WARAN)
	|| (slf.guild == GIL_DRACONIAN)
	|| (slf.guild == GIL_FIREGOLEM)
	|| (slf.guild == GIL_GOBBO) && (slf.level < 15) // goblins, black goblins
	|| (slf.guild == GIL_Gargoyle) // Fire devil
	|| (slf.guild == GIL_SCAVENGER) // scavengers, orc biters
	|| (slf.guild == GIL_SNAPPER) // snappers, razors, dragon snappers
	|| (slf.guild == GIL_WARAN) // lizards, fire lizards
	|| (MageStaff_Good_2H_02_Equipped)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	};
};
