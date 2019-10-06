
// *************************
// SPL_HealOther (mud-freak)
// *************************

const int SPL_Cost_HealOther       = 30;
const int SPL_Heal_HealOther       = 150;

INSTANCE Spell_HealOther (C_Spell_Proto) {
    time_per_mana           = 0;
    spelltype               = SPELL_NEUTRAL;
    targetCollectAlgo       = TARGET_COLLECT_FOCUS;
    targetCollectRange      = 1000;
};

func int Spell_Logic_HealOther(var int manaInvested) {
	return Spell_Logic_Basic(self, SPL_Cost_HealOther);
};

func void Spell_Cast_HealOther() {
    Npc_ChangeAttribute (other, ATR_HITPOINTS, +SPL_Heal_HealOther);
    Wld_PlayEffect ("spellFX_HealOther_TARGET", other, other, 0, 0, 0, 0);
	
	Spell_Cast_Basic(self, SPL_Cost_HealOther);
};
