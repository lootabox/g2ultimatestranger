// *********
// SPL_Sleep
// *********

const int SPL_Cost_Sleep				= 30;	
const int SPL_TIME_Sleep				= 30;	// in ZS_MagicSleep


instance Spell_Sleep (C_Spell_Proto)
{
	time_per_mana			= 0;					//Wert wird nicht gebraucht - Spell wirkt INSTANT
	spelltype 				= SPELL_NEUTRAL;
	targetCollectAlgo		= TARGET_COLLECT_FOCUS;
};

func int Spell_Logic_Sleep (var int manaInvested) //Parameter manaInvested wird hier nicht benutzt
{
	if ((Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll)))
	|| (self.attribute[ATR_MANA] >= SPL_Cost_Sleep)
	{
		if (Npc_GetActiveSpellIsScroll(self))
		{
			self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
		}
		else
		{
			self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Sleep;
		};

		if (!C_BodyStateContains(other, BS_SWIM))
		&& (!C_BodyStateContains(other, BS_DIVE))
		&& (!C_NpcIsDown(other))
		&& (other.guild < GIL_SEPERATOR_HUM)
		//&& (other.level - self.level <= 3) //EGAL, sonst Spell witzlos (Klau-Wachen)
		//&& (C_NpcIsGateGuard (self) == FALSE) //EGAL, weil PAL oder Kdf kritische Wachen sind
		&& ((other.flags != NPC_FLAG_IMMORTAL)
		|| (Hlp_GetInstanceID(other) == Hlp_GetInstanceID(Richter))
		|| (Hlp_GetInstanceID(other) == Hlp_GetInstanceID(VLK_400_Larius))
		|| (Hlp_GetInstanceID(other) == Hlp_GetInstanceID(Cornelius)))
		&& (Npc_GetDistToNpc (self,other) <= 1000)
		&& ((other.guild != GIL_KDF)
		&& (other.guild != GIL_PAL)
		|| (Npc_IsPlayer(other)))
		&& (other.guild != GIL_DMT)
		&& (other.guild != GIL_KDW)
		&& (Hlp_GetInstanceID(other) != Hlp_GetInstanceID(Vatras))
		&& (Hlp_GetInstanceID(other) != Hlp_GetInstanceID(Myxir_CITY))
		&& (Hlp_GetInstanceID(other) != Hlp_GetInstanceID(KDF_511_Daron))
		{		
			Npc_ClearAIQueue	(other);
			B_ClearPerceptions	(other);
			AI_StartState		(other, ZS_MagicSleep, 0, "");
		};
		return SPL_SENDCAST; //Spell wird auch gecasted, wenn keine Auswirkungen (other geht nicht in ZS) Mana is dann weg - Pech gehabt! (soll so sein!)
	}
	else //nicht genug Mana
	{
		return SPL_SENDSTOP;
	};
};


func void Spell_Cast_Sleep()
{
	//self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Sleep;			// nicht drin, wegen Kommentar oben
	
	self.aivar[AIV_SelectSpell] += 1;
};






