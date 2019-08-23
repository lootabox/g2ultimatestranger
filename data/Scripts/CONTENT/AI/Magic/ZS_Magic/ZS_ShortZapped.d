// **************************************
// B_StopShortZapped
// -----------------
// wird durch Wahrnehmung AssessStopMagic 
// aus ZS_Zapped aufgerufen
// **************************************

const int SPL_TIME_SHORTZAPPED = 3;
const int SPL_TIME_SHORTZAPPED_UNDEAD = SPL_TIME_SHORTZAPPED * 2;

// **********************************
// ZS_ShortZapped
// --------------
// NSC wird von ChargeZap getroffen
// **********************************

func int ZS_ShortZapped()
{
	// ------ Non_interruptable Bodystates stehen sauber auf bzw. beenden sauber
	if (!Npc_HasBodyFlag(self, BS_FLAG_INTERRUPTABLE))
	{
		AI_StandUp (self);
	}
	else
	{
		AI_StandUpQuick (self);
	};
	if (TRUE)
	{
		AI_PlayAni			(self, "T_STAND_2_LIGHTNING_VICTIM" );
	};

	Wld_PlayEffect ("spellFX_Lightning_TARGET", self, self, 0, 0, 0, FALSE);
	self.aivar[AIV_FreezeStateTime] = 0;
};


func int ZS_ShortZapped_Loop ()
{	
	if	(Npc_GetStateTime(self) >= SPL_TIME_SHORTZAPPED_UNDEAD)
	||	(Npc_GetStateTime(self) >= SPL_TIME_SHORTZAPPED)
	&&	(!C_NpcIsUndead(self))
	{
		return LOOP_END;
	};

	if (Npc_GetStateTime(self) != self.aivar[AIV_FreezeStateTime])
	{
		self.aivar[AIV_FreezeStateTime] = Npc_GetStateTime(self);

		// Make sure to keep playing vfx
		if	(C_NpcIsUndead(self))
		&&	(Npc_GetStateTime(self) == SPL_TIME_SHORTZAPPED)
		{
			Wld_PlayEffect ("spellFX_Lightning_TARGET", self, self, 0, 0, 0, FALSE);
		};
	};
	return LOOP_CONTINUE;
};


func void ZS_ShortZapped_End()
{
//	Npc_PercEnable	(self, PERC_ASSESSMAGIC, B_AssessMagic);
	
	Npc_ClearAIQueue(self);
	AI_StandUp		(self);

	if (self.guild < GIL_SEPERATOR_HUM)
	{
		B_AssessDamage();
	}
	else
	{
		Npc_SetTempAttitude (self, ATT_HOSTILE); //falls nicht schon Gilden-Attit�de hostile ist 
	};
	
	// nach Aufruf dieses Befehles wird die Loop �ber return LOOP_END beendet
};
