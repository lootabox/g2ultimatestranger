
// *************************
// SPL_Extricate (mud-freak)
// *************************

const int SPL_Cost_Extricate       = 20;
const int SPL_Damage_Extricate     = 1; // Vorsicht, es kommt Fallschaden dazu

INSTANCE Spell_Extricate (C_Spell_Proto) {
    time_per_mana           = 0;
    damage_per_level        = SPL_Damage_Extricate;
    damageType              = DAM_FLY;
    canTurnDuringInvest     = TRUE;
    targetCollectAlgo       = TARGET_COLLECT_NONE; // Per Kollision ermittelt
    targetCollectRange      = 0;
};

func int Spell_Logic_Extricate(var int manaInvested) {
	if (Spell_Logic_Basic(self, SPL_Cost_Extricate) == SPL_SENDCAST)
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

func void Spell_Cast_Extricate() {
	Spell_Cast_Basic(self, SPL_Cost_Extricate);
};
