
// ********************
// SPL_Acid (mud-freak)
// ********************

const int SPL_Cost_Acid           = 5;
const int SPL_Damage_Acid         = 1; // Geregelt in spellFX (dmg over time)
const int SPL_Time_Acid           = 8; // Änderungen hier haben keinen Effekt
const int SPL_DmgPerSec_Acid      = 2; // (= 1/DoT) siehe VisualFxInst.d

INSTANCE Spell_Acid (C_Spell_Proto) {
    time_per_mana           = 0;
    damage_per_level        = SPL_Damage_Acid;
    damageType              = DAM_MAGIC;
};

func int Spell_Logic_Acid(var int manaInvested) {
	return Spell_Logic_Basic(self, SPL_Cost_Acid);
};

func void Spell_Cast_Acid() {
	Spell_Cast_Basic(self, SPL_Cost_Acid);
};
