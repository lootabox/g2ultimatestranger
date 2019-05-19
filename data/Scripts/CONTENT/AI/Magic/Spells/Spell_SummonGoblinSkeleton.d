// ************************
// SPL_SummonGoblinSkeleton
// ************************

const int SPL_Cost_SummonGoblinSkeleton		= 20;


INSTANCE Spell_SummonGoblinSkeleton (C_Spell_Proto)	//ehem. Spell_Skeleton
{
	time_per_mana			= 0;
	targetCollectAlgo		= TARGET_COLLECT_NONE;
};

func int Spell_Logic_SummonGoblinSkeleton (var int manaInvested)
{	
	return Spell_Logic_Basic(self, SPL_Cost_SummonGoblinSkeleton);
};

func void Spell_Cast_SummonGoblinSkeleton()
{
	if (Npc_IsPlayer(self)) 
	{		
		Wld_SpawnNpcRange	(self,	SUMMONED_GOBBO_SKELETON,	1,	500);
	}
	else
	{
		Wld_SpawnNpcRange	(self,	GOBBO_SKELETON,	1,	500);
	};
	
	Spell_Cast_Basic(self, SPL_Cost_SummonGoblinSkeleton);
};
