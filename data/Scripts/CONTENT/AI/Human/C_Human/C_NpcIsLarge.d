
func int C_NpcIsLarge(var C_Npc slf)
{
	if((C_NpcIsGolem(self))
	|| (self.guild == GIL_DEMON)
	|| (self.guild == GIL_SUMMONED_DEMON)
	|| (self.guild == GIL_TROLL)
	|| (self.guild == GIL_DRAGON))
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	};
};

