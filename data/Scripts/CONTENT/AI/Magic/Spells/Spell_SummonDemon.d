// ***************
// SPL_SummonDemon
// ***************

const int SPL_Cost_SummonDemon		= 120;
const int SPL_Degen_SummonDemon		= 20;


INSTANCE Spell_SummonDemon (C_Spell_Proto)	//ehem. Spell_Demon
{
	time_per_mana			= 0;
	targetCollectAlgo		= TARGET_COLLECT_NONE;
};

func int Spell_Logic_SummonDemon(var int manaInvested)
{
	var c_item wpn; wpn = Npc_GetEquippedMeleeWeapon(self);
	if (Hlp_IsItem(wpn, ItMW_Addon_Stab02_Infused))
	{
		return Spell_Logic_Invest(self, manaInvested, SPL_Cost_SummonDemon, 3, TRUE);
	}
	else
	{
		return Spell_Logic_Invest(self, manaInvested, SPL_Cost_SummonDemon, 2, TRUE);
	};
};

func void Spell_Cast_SummonDemon()
{
	if (Npc_IsPlayer(self)) 
	{
		if (Npc_GetActiveSpellLevel(self) > 2)
		{
			Wld_SpawnNpcRange	(self,	Summoned_DemonLord,		1,	1000);
		}
		else
		{
			Wld_SpawnNpcRange	(self,	Summoned_Demon,			1,	1000);
		};
	}
	else
	{
		Wld_SpawnNpcRange	(self,	Demon,			1,	1000);
	};

	self.aivar[AIV_SelectSpell] += 1;
};


