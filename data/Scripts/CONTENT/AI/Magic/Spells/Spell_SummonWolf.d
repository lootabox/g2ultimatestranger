// **************
// SPL_SummonWolf
// **************

const int SPL_Cost_SummonWolf			= 20;
const int SPL_Degen_SummonWolf			= 2;


INSTANCE Spell_SummonWolf (C_Spell_Proto)
{
	time_per_mana			= 0;
	targetCollectAlgo		= TARGET_COLLECT_NONE;
};

func int Spell_Logic_SummonWolf (var int manaInvested)
{
	var c_item wpn; wpn = Npc_GetEquippedMeleeWeapon(self);
	if (Hlp_IsItem(wpn, ItMW_Addon_Stab02_Infused))
	{
		return Spell_Logic_Invest(self, manaInvested, SPL_Cost_SummonWolf, 3, TRUE);
	}
	else
	{
		return Spell_Logic_Invest(self, manaInvested, SPL_Cost_SummonWolf, 2, TRUE);
	};
};

func void Spell_Cast_SummonWolf()
{
	if (Npc_IsPlayer(self)) 
	{
		if (Npc_GetActiveSpellLevel(self) > 2)
		{
			Wld_SpawnNpcRange	(self,	Summoned_BlackWolf,	1,	500);
		}
		else
		{
			Wld_SpawnNpcRange	(self,	Summoned_Wolf,			1,	500);
		};
	}
	else
	{
		Wld_SpawnNpcRange	(self,	Wolf,			1,	500);
	};

	self.aivar[AIV_SelectSpell] += 1;
};
