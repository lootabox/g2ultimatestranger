// ******************
// ZS_MM_Rtn_Summoned
// ******************

func void HandleSummonDegen(var c_npc summon)
{
	/*
		GIL_SUMMONED_WOLF			SPL_Degen_SummonWolf
		GIL_SUMMONED_GOBBO_SKELETON	SPL_Degen_SummonGoblinSkeleton
		GIL_SUMMONED_SKELETON		SPL_Degen_SummonSkeleton
		GIL_SummonedGuardian		SPL_Degen_SummonGuardian
		GIL_SUMMONED_GOLEM			SPL_Degen_SummonGolem
		GIL_SummonedZombie			SPL_Degen_SummonZombie
		GIL_SUMMONED_DEMON			SPL_Degen_SummonDemon
	*/

	var int degen;
	if		(summon.guild == GIL_SUMMONED_WOLF)				{ degen = SPL_Degen_SummonWolf; }
	else if	(summon.guild == GIL_SUMMONED_GOBBO_SKELETON)	{ degen = SPL_Degen_SummonGoblinSkeleton; }
	else if	(summon.guild == GIL_SUMMONED_SKELETON)			{ degen = SPL_Degen_SummonSkeleton; }
	else if	(summon.guild == GIL_SummonedGuardian)			{ degen = SPL_Degen_SummonGuardian; }
	else if	(summon.guild == GIL_SUMMONED_GOLEM)			{ degen = SPL_Degen_SummonGolem; }
	else if	(summon.guild == GIL_SummonedZombie)			{ degen = SPL_Degen_SummonZombie; }
	else if	(summon.guild == GIL_SUMMONED_DEMON)			{ degen = SPL_Degen_SummonDemon; };
	
	var c_item wpn; wpn = Npc_GetEquippedMeleeWeapon(self);
	if (Hlp_IsItem(wpn, ItMW_Addon_Stab02) || Hlp_IsItem(wpn, ItMW_Addon_Stab02_Infused)) { degen -= 1; };

	Npc_ChangeAttribute(summon, ATR_HITPOINTS, -degen);
};


func void B_SummonedAssessTalk()
{
	Npc_ChangeAttribute (self, ATR_HITPOINTS, -self.attribute[ATR_HITPOINTS_MAX]);
};

func void ZS_MM_Rtn_Summoned ()
{
	Npc_SetPercTime	(self,	1);
	Npc_PercEnable	(self,	PERC_ASSESSPLAYER,		B_MM_AssessPlayer);
	Npc_PercEnable	(self,	PERC_ASSESSENEMY,		B_MM_AssessEnemy);
	
	Npc_PercEnable	(self,	PERC_ASSESSMAGIC,  		B_AssessMagic);
	Npc_PercEnable	(self,	PERC_ASSESSDAMAGE,		B_MM_AssessDamage);
	Npc_PercEnable	(self,  PERC_ASSESSFIGHTSOUND, 	B_MM_AssessOthersDamage);
	
	if (Hlp_GetInstanceID(self) == Hlp_GetInstanceID(Wisp_Detector))
	{
		Npc_PercEnable 	(self,	PERC_ASSESSTALK, 	B_AssessTalk);
	}
	else
	{
		Npc_PercEnable 	(self,	PERC_ASSESSTALK, 	B_SummonedAssessTalk);
	};

	// FUNC
	
	B_SetAttitude (self, ATT_FRIENDLY);
	self.aivar[AIV_PARTYMEMBER] = TRUE;

	AI_StandUp (self);
	AI_SetWalkmode	(self, NPC_RUN);
};

func int ZS_MM_Rtn_Summoned_Loop()
{
	// ------ beim Spieler bleiben ------
	B_MM_WispDetect ();
	if (Npc_GetDistToNpc (self, hero) > 500)
	{
		AI_GotoNpc (self, hero);
	}
	else //<= 500
	{
		if (Npc_GetStateTime(self) >= 1)
		{
			// ------ zum Spieler drehen ------
			if (!Npc_CanSeeNpc(self, hero))
			{
				AI_TurnToNpc (self, hero);
			};
			
			// ------ Summon Time -------
			self.aivar[AIV_SummonTime] = (self.aivar[AIV_SummonTime] + Npc_GetStateTime(self)); //weil AI_Goto länger dauern kann
			HandleSummonDegen(self);

			/* if (self.aivar[AIV_SummonTime] >= MONSTER_SUMMON_TIME)
			{
				 Npc_ChangeAttribute (self, ATR_HITPOINTS, -self.attribute[ATR_HITPOINTS_MAX]);
			}; */
			
			Npc_SetStateTime (self, 0);
		};
	};
	
	self.wp = Npc_GetNearestWP (self);
	return LOOP_CONTINUE;
};

func void ZS_MM_Rtn_Summoned_End()
{

};

			/*// ------ MANA - Entzug ------			
			if (self.aivar[AIV_MM_REAL_ID] == ID_SUMMONED_GOBBO_SKELETON)
			{					
				Npc_ChangeAttribute (hero, ATR_MANA, -1);
			};
			
			if (self.aivar[AIV_MM_REAL_ID] == ID_SUMMONED_WOLF)
			{					
				Npc_ChangeAttribute (hero, ATR_MANA, -2);
			};
			
			if (self.aivar[AIV_MM_REAL_ID] == ID_SUMMONED_SKELETON)
			{					
				Npc_ChangeAttribute (hero, ATR_MANA, -3);
			};
			
			if (self.aivar[AIV_MM_REAL_ID] == ID_SUMMONED_GOLEM)
			{					
				Npc_ChangeAttribute (hero, ATR_MANA, -4);
			};
			
			if (self.aivar[AIV_MM_REAL_ID] == ID_SUMMONED_DEMON)
			{					
				Npc_ChangeAttribute (hero, ATR_MANA, -5);
			};
			
			if (hero.attribute[ATR_MANA] <= 0)
			{
				if (self.aivar[AIV_MM_REAL_ID] == ID_SUMMONED_DEMON)
				{
					B_SetAttitude (self, ATT_HOSTILE);
				}
				else
				{
					Npc_ChangeAttribute (self, ATR_HITPOINTS, -self.attribute[ATR_HITPOINTS_MAX]);
				};
			};*/
