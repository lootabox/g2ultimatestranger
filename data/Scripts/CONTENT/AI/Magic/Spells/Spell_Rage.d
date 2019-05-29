
// ********************
// SPL_Rage (mud-freak)
// ********************

const int SPL_Cost_Rage            = 50;
const int SPL_Victims_Rage         = 2;    // Wie viele soll Victim angreifen

INSTANCE Spell_Rage (C_Spell_Proto) {
    time_per_mana           = 0;
    spelltype               = SPELL_BAD;
	targetCollectAlgo		= TARGET_COLLECT_FOCUS;
};

func int Spell_Logic_Rage(var int manaInvested) {
	return Spell_Logic_Basic(self, SPL_Cost_Rage);
};

func void Spell_Cast_Rage() {
    // if (other.flags != NPC_FLAG_IMMORTAL)            // Nicht auf Immortals
    // && (!C_NpcIsUndead(other))                       // Nicht auf Untote
    // {
        Npc_ClearAIQueue(other);
        B_ClearPerceptions(other);
        other.aivar[AIV_RageStateTime] = 0; // Wichtig!
        AI_StartState(other, ZS_Rage, 0, "");
    // };

	Spell_Cast_Basic(self, SPL_Cost_Rage);
};
