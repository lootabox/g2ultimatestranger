// *****************
// B_StopMagicFreeze
// *****************

func void B_RestartFreeze()
{
	if (Npc_GetLastHitSpellID(self) == SPL_IceCube)
	|| (Npc_GetLastHitSpellID(self) == SPL_IceWave)
	{
		// Get total damage (main + dot - prot) -> get freeze duration (total / dot_dps)
		var int freezeDuration; freezeDuration = (SPL_Damage_IceCube + SPL_FREEZE_DAMAGE * SPL_TIME_FREEZE - self.protection[PROT_MAGIC]) / SPL_FREEZE_DAMAGE;
		if (freezeDuration > 0)
		{
			// No exceeding max duration
			if (freezeDuration > SPL_TIME_FREEZE) { freezeDuration = SPL_TIME_FREEZE; };

			self.aivar[AIV_FreezeStateTime] = SPL_TIME_FREEZE - freezeDuration;
			Npc_SetStateTime(self, self.aivar[AIV_FreezeStateTime]);
		}
		else
		{
			self.aivar[AIV_FreezeStateTime] = SPL_TIME_FREEZE + 1;
		};
	};
};

// **************
// ZS_MagicFreeze
// **************

func int ZS_MagicFreeze()
{
	Npc_PercEnable		(self, PERC_ASSESSMAGIC, B_RestartFreeze); 		// falls ein NSC nochmal von einem Freezespell getroffen wurde, so muss die State Time reseted werden

	Npc_StopAni(self, "S_FIRE_VICTIM");										// falls der NSC am Zappeln ist, brich die Ani ab

	// Opfer wird in Bodystate Unconscious versetzt
	if (!C_BodyStateContains(self, BS_UNCONSCIOUS)) 
	{
		AI_PlayAniBS 		(self, "T_STAND_2_FREEZE_VICTIM", BS_UNCONSCIOUS);
	};
	B_ClearRuneInv(self);
	//self.aivar[AIV_FreezeStateTime] = 0;
	B_RestartFreeze();
};



func int ZS_MagicFreeze_Loop ()
{	
	// EXIT LOOP IF...
	Print(IntToString(self.aivar[AIV_FreezeStateTime]));
	if (self.aivar[AIV_FreezeStateTime] > SPL_TIME_FREEZE)
	{
		return LOOP_END;
	};

	// LOOP FUNC
	if (Npc_GetStateTime(self) != self.aivar[AIV_FreezeStateTime])
	{
		self.aivar[AIV_FreezeStateTime] = Npc_GetStateTime(self);
	};
	
	return				LOOP_CONTINUE;
};


func void ZS_MagicFreeze_End()
{
	Npc_PercEnable	(self, PERC_ASSESSMAGIC, B_AssessMagic);
	
	Npc_ClearAIQueue(self);
	AI_StandUp		(self);

	if (self.guild < GIL_SEPERATOR_HUM)
	{
		B_AssessDamage();
	}
	else
	{
		Npc_SetTempAttitude (self, ATT_HOSTILE); //falls nicht schon Gilden-Attitüde hostile ist 
	};
	
	// nach Aufruf dieses Befehles wird die Loop über return LOOP_END beendet
};
