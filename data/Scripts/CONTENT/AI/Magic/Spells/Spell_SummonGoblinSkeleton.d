// ************************
// SPL_SummonGoblinSkeleton
// ************************

const int SPL_Cost_SummonGoblinSkeleton		= 40;
const int SPL_Degen_SummonGoblinSkeleton	= 3;


INSTANCE Spell_SummonGoblinSkeleton (C_Spell_Proto)	//ehem. Spell_Skeleton
{
	time_per_mana			= 0;
	targetCollectAlgo		= TARGET_COLLECT_NONE;
};

func int Spell_Logic_SummonGoblinSkeleton (var int manaInvested)
{	
	var c_item wpn; wpn = Npc_GetEquippedMeleeWeapon(self);
	if (Hlp_IsItem(wpn, ItMW_Addon_Stab02_Infused))
	{
		return Spell_Logic_Invest(self, manaInvested, SPL_Cost_SummonGoblinSkeleton, 3, TRUE);
	}
	else
	{
		return Spell_Logic_Invest(self, manaInvested, SPL_Cost_SummonGoblinSkeleton, 2, TRUE);
	};
};

func void Spell_Cast_SummonGoblinSkeleton()
{
	if (Npc_IsPlayer(self)) 
	{
		if (Npc_GetActiveSpellLevel(self) > 2)
		{
			Wld_SpawnNpcRange	(self,	SUMMONED_GOBBO_SKELETON,			1,	500);
		}
		else
		{
			Wld_SpawnNpcRange	(self,	SUMMONED_LESSER_GOBBO_SKELETON,		1,	500);
		};
	}
	else
	{
		Wld_SpawnNpcRange	(self,	GOBBO_SKELETON,			1,	500);
	};

	self.aivar[AIV_SelectSpell] += 1;
};
