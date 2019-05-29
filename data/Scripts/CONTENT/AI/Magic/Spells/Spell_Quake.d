
// *********************
// SPL_Quake (mud-freak)
// *********************

const int SPL_Cost_Quake           = 5;
const int SPL_Damage_Quake         = 100;

INSTANCE Spell_Quake (C_Spell_Proto) {
    time_per_mana           = 0;
    damage_per_level        = SPL_Damage_Quake;
    targetCollectAlgo       = TARGET_COLLECT_NONE; // Per Kollision ermittelt
    targetCollectRange      = 0;
};

func int Spell_Logic_Quake(var int manaInvested) {
	if (Spell_Logic_Basic(self, SPL_Cost_Quake) == SPL_SENDCAST)
	{
		// Hack damit wir einen Invest FX bekommen
		if (manaInvested == 0)
		{
			return SPL_NEXTLEVEL;
		}
		else
		{
			return SPL_SENDCAST;
		};
	}
	else
	{
		return SPL_SENDSTOP;
	};
};

func void Spell_Cast_Quake() {
	Spell_Cast_Basic(self, SPL_Cost_Quake);
};
