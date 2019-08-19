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
	return Spell_Logic_Basic(self, SPL_Cost_Sleep);
};

func int Npc_HasSleepAnimation(var c_npc oth)
{
	return (oth.guild < GIL_SEPERATOR_HUM)
	|| ((!C_NpcIsGolem(oth))
	&& (!C_NpcIsUndead(oth))
	&& (oth.guild != GIL_HARPY)
	&& (oth.guild != GIL_SWAMPSHARK)
	&& (oth.guild != GIL_BLOODFLY)
	&& (oth.guild != GIL_MEATBUG)
	&& (oth.guild != GIL_SHEEP)
	&& (oth.guild != GIL_GIANT_BUG)
	&& (oth.guild != GIL_MINECRAWLER)
	&& (oth.guild != GIL_DEMON)
	&& (oth.guild != GIL_DRAGON));
};

func void Spell_Cast_Sleep()
{
	Spell_Cast_Basic(self, SPL_Cost_Sleep);

	if (!C_BodyStateContains(other, BS_SWIM))
	&& (!C_BodyStateContains(other, BS_DIVE))
	&& (!C_NpcIsDown(other))
	&& (Npc_HasSleepAnimation(other))
	&& (!Npc_IsInState(other, ZS_Attack))
	&& (!Npc_IsInState(other, ZS_MM_Attack))
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
	//Spell wird auch gecasted, wenn keine Auswirkungen (other geht nicht in ZS) Mana is dann weg - Pech gehabt! (soll so sein!)

	self.aivar[AIV_SelectSpell] += 1;
};






