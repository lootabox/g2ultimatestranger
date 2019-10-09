
// *************************
// SPL_Explosion (mud-freak)
// *************************

const int SPL_Cost_Explosion        = 50;
const int SPL_Damage_Explosion      = 120;

INSTANCE Spell_Explosion (C_Spell_Proto) {
    time_per_mana           = 0;
    damage_per_level        = SPL_Damage_Explosion;
    damageType              = DAM_MAGIC;
};

func int Spell_Logic_Explosion(var int manaInvested) {
	return Spell_Logic_Basic(self, SPL_Cost_Explosion);
};

func void Spell_Cast_Explosion() {
	Spell_Cast_Basic(self, SPL_Cost_Explosion);
};
