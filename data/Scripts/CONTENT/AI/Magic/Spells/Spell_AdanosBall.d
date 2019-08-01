
// **************************
// SPL_Adanosball (mud-freak)
// **************************

const int SPL_Cost_AdanosBall		= 40;
const int SPL_Damage_AdanosBall		= 20;

INSTANCE Spell_AdanosBall (C_Spell_Proto) {
	time_per_mana			= 0;
	damage_per_level		= SPL_Damage_AdanosBall;
	damageType				= DAM_MAGIC;
};

func int Spell_Logic_AdanosBall(var int manaInvested) {
	return Spell_Logic_Basic(self, SPL_Cost_AdanosBall);
};

func void Spell_Cast_AdanosBall() {
	Spell_Cast_Basic(self, SPL_Cost_AdanosBall);
};
