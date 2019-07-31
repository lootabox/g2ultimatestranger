// ***************
// SPL_SummonGolem
// ***************

const int SPL_Cost_SummonGolem		= 80;
const int SPL_Degen_SummonGolem		= 6;


INSTANCE Spell_SummonGolem (C_Spell_Proto)	//ehem. Spell_Golem
{
	time_per_mana			= 18;
	targetCollectAlgo		= TARGET_COLLECT_FOCUS_FALLBACK_NONE;	// Do not change.
	targetCollectRange		= 1000;				// Maximum distance (cm) to traverse. Can be freely adjusted.
	targetCollectAzi		= 0;				// Do not display focus names.
	targetCollectElev		= 0;
};

func int Spell_Logic_SummonGolem (var int manaInvested)
{
	return Spell_Logic_Invest_Summon(self, manaInvested, SPL_Cost_SummonGolem);
};

func void Spell_Cast_SummonGolem(var int spellLevel)
{
	Spell_Cast_Summon(self, spellLevel, StoneGolem, Summoned_Golem, Summoned_Magic_Golem);
};
