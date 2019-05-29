
// *************************
// SPL_MagicCage (mud-freak)
// *************************

const int SPL_Cost_MagicCage       = 40;
const int SPL_Damage_MagicCage     = 1;
const int SPL_Time_MagicCage       = 19;

INSTANCE Spell_MagicCage (C_Spell_Proto) {
    time_per_mana           = 0;
    damage_per_level        = SPL_Damage_MagicCage;
    targetCollectAlgo       = TARGET_COLLECT_FOCUS;
    targetCollectType       = TARGET_TYPE_HUMANS; // Käfig: Menschengrösse
};

func int Spell_Logic_MagicCage(var int manaInvested) {
	return Spell_Logic_Basic(self, SPL_Cost_MagicCage);
};

func void Spell_Cast_MagicCage() {
	Spell_Cast_Basic(self, SPL_Cost_MagicCage);
};
