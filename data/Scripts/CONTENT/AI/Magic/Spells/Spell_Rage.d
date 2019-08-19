
// ********************
// SPL_Rage (mud-freak)
// ********************

const int SPL_Cost_Rage            = 50;
const int SPL_Victims_Rage         = 1;    // Wie viele soll Victim angreifen

INSTANCE Spell_Rage (C_Spell_Proto) {
    time_per_mana           = 0;
    spelltype               = SPELL_BAD;
	targetCollectAlgo		= TARGET_COLLECT_FOCUS;
};

func int Spell_Logic_Rage(var int manaInvested) {
	return Spell_Logic_Basic(self, SPL_Cost_Rage);
};

func void Spell_Cast_Rage() {
	if (!C_BodyStateContains(other, BS_SWIM))
	&& (!C_BodyStateContains(other, BS_DIVE))
	&& (!C_NpcIsDown(other))
	&& ((other.guild < GIL_SEPERATOR_HUM) || ((!C_NpcIsGolem(other)) && (!C_NpcIsUndead(other))))
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
        Npc_ClearAIQueue(other);
        B_ClearPerceptions(other);
        other.aivar[AIV_RageStateTime] = 0; // Wichtig!
        AI_StartState(other, ZS_Rage, 0, "");
    };

	Spell_Cast_Basic(self, SPL_Cost_Rage);
};
