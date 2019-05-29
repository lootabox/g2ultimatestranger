
// *****************
// B_StopMagicCage
// *****************

func void B_RestartMagicCage() {
    if (Npc_GetLastHitSpellID(self) == SPL_MagicCage) {
        Npc_SetStateTime(self,0);
    };
};


func void B_StopMagicCage() {
    Npc_PercEnable(self, PERC_ASSESSMAGIC, B_AssessMagic);

    Npc_ClearAIQueue(self);
    AI_StandUp(self);

    if (self.guild < GIL_SEPERATOR_HUM) {
        B_AssessDamage();
    } else {
        Npc_SetTempAttitude(self, ATT_HOSTILE); //falls nicht schon Gilden-Attitüde hostile ist
    };

    // nach Aufruf dieses Befehles wird die Loop über return LOOP_END beendet
};

// **************
// ZS_MagicCage
// **************

func int ZS_MagicCage() {
    Npc_PercEnable(self, PERC_ASSESSMAGIC, B_RestartMagicCage);

    Npc_StopAni(self, "S_FIRE_VICTIM");

    // Opfer wird in Bodystate Unconscious versetzt
    if (!C_BodyStateContains(self, BS_UNCONSCIOUS)) {
        AI_PlayAniBS(self, "T_STAND_2_FREEZE_VICTIM", BS_UNCONSCIOUS);
    };
    self.aivar[AIV_CageStateTime] = 0;
};

func int ZS_MagicCage_Loop () {
    // EXIT LOOP IF...
    if (Npc_GetStateTime(self) > SPL_Time_MagicCage) {
        B_StopMagicCage();
        return LOOP_END;
    };

    // LOOP FUNC
    if (Npc_GetStateTime(self) != self.aivar[AIV_CageStateTime]) {
        self.aivar[AIV_CageStateTime] = Npc_GetStateTime(self);
    };

    return LOOP_CONTINUE;
};

func void ZS_MagicCage_End() { };
