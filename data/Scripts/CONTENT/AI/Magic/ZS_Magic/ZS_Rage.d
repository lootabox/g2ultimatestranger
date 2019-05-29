
// *************
// ZS_Rage
// *************
func void ZS_Rage () {

    if (self.aivar[AIV_RageStateTime] == 0) {
        // ------ Guardpassage resetten ------
        self.aivar[AIV_Guardpassage_Status] = GP_NONE;

        Npc_SetRefuseTalk(self, 0);

        // ------ Temp_Att (upset) "resetten" ------
        Npc_SetTempAttitude(self, Npc_GetPermAttitude(self, hero));

        // ------ Bewegungs-Overlays resetten ------
        B_StopLookAt(self);
        AI_StopPointAt(self);

        Npc_ClearAIQueue(self);

        if (!Npc_HasBodyFlag(self, BS_FLAG_INTERRUPTABLE)) {
            AI_StandUp(self);
        } else {
            AI_StandUpQuick(self);
        };

        B_ClearPerceptions(self);
        Wld_PlayEffect("spellFX_Rage_TARGET", self, self, 0, 0, 0, 0);
        if (self.guild < GIL_SEPERATOR_HUM) {
            AI_Wait(self, 0.5);
            AI_TurnToNpc(self, hero); // Achtung: Setzt voraus, dass nur Hero den Spell benutzt.
            AI_Wait(self, 0.5);
            AI_PlayAni(self, "T_GREETNOV");
            AI_Wait(self, 0.3);
        };
    };
};


func int ZS_Rage_Loop () {
    // ZS verlassen
    if (self.aivar[AIV_RageStateTime] >= SPL_Victims_Rage) {
        Npc_ClearAIQueue(self);
        return LOOP_END;
    };

    self.aivar[AIV_RageStateTime] = self.aivar[AIV_RageStateTime]+1;

    Npc_PerceiveAll(self);

    if (Wld_DetectNpcEx(self, -1, NOFUNC, -1, 0) == TRUE) {
        if (self.guild < GIL_SEPERATOR_HUM) {
            var int rnd; rnd = Hlp_Random (100);
            if (rnd <= 40) {
                Snd_Play3D(self, "SVM_1_BERZERK");
            }
            else if (rnd <= 80) {
                Snd_Play3D(self, "SVM_2_BERZERK");
            }
            else if (rnd <= 99) {
                Snd_Play3D(self, "SVM_3_BERZERK");
            };
        };
        Npc_SetTarget(self, other);
        if (other.guild < GIL_SEPERATOR_HUM) {
            B_Attack(self, other, AR_NONE, 0);
        } else {
            AI_StartState(self, ZS_MM_Attack, 0, "");
        };
    };

    // Wird nie erreicht
    return LOOP_CONTINUE;
};

func void ZS_Rage_End() {
    AI_StandUp(self);
    if (self.guild < GIL_SEPERATOR_HUM) {
        AI_Dodge(self);
        AI_Dodge(self);
        AI_PlayAni(self, "T_SEARCH");
        B_Say_Overlay(self, self, "$WHATWASTHAT");
        AI_RemoveWeapon(self);
        AI_Wait(self, 1);
        AI_PlayAni(self, "T_DONTKNOW");
        AI_Wait(self, 0.5);
    };
    if (self.attribute[ATR_HITPOINTS] < (self.attribute[ATR_HITPOINTS_MAX]/2))
    {
        AI_StartState(self, ZS_HealSelf, 0, "");
        return;
    };
};
