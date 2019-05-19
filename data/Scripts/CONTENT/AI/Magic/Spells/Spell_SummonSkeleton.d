// ******************
// SPL_SummonSkeleton
// ******************

const int SPL_Cost_SummonSkeleton			= 60;


INSTANCE Spell_SummonSkeleton (C_Spell_Proto)	//ehem. Spell_Skeleton
{
	time_per_mana			= 0;
	targetCollectAlgo		= TARGET_COLLECT_NONE;
};

func int Spell_Logic_SummonSkeleton(var int manaInvested)
{
	return Spell_Logic_Basic(self, SPL_Cost_SummonSkeleton);
};

func void Spell_Cast_SummonSkeleton()
{
	if (Npc_IsPlayer(self)) 
	{		
		Wld_SpawnNpcRange	(self,	Summoned_Skeleton,			1,	500);
	}
	else
	{
		Wld_SpawnNpcRange	(self,	Skeleton,			1,	500);
	};

	Spell_Cast_Basic(self, SPL_Cost_SummonSkeleton);
};
