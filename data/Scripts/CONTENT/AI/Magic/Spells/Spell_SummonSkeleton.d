// ******************
// SPL_SummonSkeleton
// ******************

const int SPL_Cost_SummonSkeleton			= 60;
const int SPL_Degen_SummonSkeleton			= 4;


INSTANCE Spell_SummonSkeleton (C_Spell_Proto)	//ehem. Spell_Skeleton
{
	time_per_mana			= 0;
	targetCollectAlgo		= TARGET_COLLECT_NONE;
};

func int Spell_Logic_SummonSkeleton(var int manaInvested)
{
	var c_item wpn; wpn = Npc_GetEquippedMeleeWeapon(self);
	if (Hlp_IsItem(wpn, ItMW_Addon_Stab02_Infused))
	{
		return Spell_Logic_Invest(self, manaInvested, SPL_Cost_SummonSkeleton, 3, TRUE);
	}
	else
	{
		return Spell_Logic_Invest(self, manaInvested, SPL_Cost_SummonSkeleton, 2, TRUE);
	};
};

func void Spell_Cast_SummonSkeleton()
{
	if (Npc_IsPlayer(self)) 
	{
		if (Npc_GetActiveSpellLevel(self) > 2)
		{
			Wld_SpawnNpcRange	(self,	Summoned_Skeleton,			1,	500);
		}
		else
		{
			Wld_SpawnNpcRange	(self,	Summoned_Lesser_Skeleton,	1,	500);
		};
	}
	else
	{
		Wld_SpawnNpcRange	(self,	Skeleton,			1,	500);
	};

	self.aivar[AIV_SelectSpell] += 1;
};
