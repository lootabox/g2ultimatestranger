// ******************
// SPL_SummonZombie		/k4
// ******************

const int SPL_Cost_SummonZombie			= 80;
const int SPL_Degen_SummonZombie		= 4;


INSTANCE Spell_SummonZombie (C_Spell_Proto)	
{
	time_per_mana			= 18;
	targetCollectAlgo		= TARGET_COLLECT_FOCUS_FALLBACK_NONE;	// Do not change.
	targetCollectRange		= 1000;				// Maximum distance (cm) to traverse. Can be freely adjusted.
	targetCollectAzi		= 0;				// Do not display focus names.
	targetCollectElev		= 0;
};

func int Spell_Logic_SummonZombie(var int manaInvested)
{
	return Spell_Logic_Invest_Summon(self, manaInvested, SPL_Cost_SummonZombie);
};

func void Spell_Cast_SummonZombie(var int spellLevel)
{
	Spell_Cast_Summon(self, spellLevel, Zombie01, Summoned_Zombie, Summoned_Armored_Zombie);
};
