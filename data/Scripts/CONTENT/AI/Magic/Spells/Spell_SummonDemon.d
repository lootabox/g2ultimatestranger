// ***************
// SPL_SummonDemon
// ***************

const int SPL_Cost_SummonDemon		= 120;


INSTANCE Spell_SummonDemon (C_Spell_Proto)	//ehem. Spell_Demon
{
	time_per_mana			= 0;
	targetCollectAlgo		= TARGET_COLLECT_NONE;
};

func int Spell_Logic_SummonDemon(var int manaInvested)
{
	return Spell_Logic_Basic(self, SPL_Cost_SummonDemon);
};

func void Spell_Cast_SummonDemon()
{
	if (Npc_IsPlayer(self)) 
	{		
		Wld_SpawnNpcRange (self, Summoned_Demon, 1, 1000);
	}
	else
	{
		Wld_SpawnNpcRange (self, Demon, 1, 1000);
	};
	
	Spell_Cast_Basic(self, SPL_Cost_SummonDemon);
};


