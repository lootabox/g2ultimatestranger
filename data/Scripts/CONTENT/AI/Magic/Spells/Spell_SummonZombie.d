// ******************
// SPL_SummonZombie		/k4
// ******************

const int SPL_Cost_SummonZombie			= 80;


INSTANCE Spell_SummonZombie (C_Spell_Proto)	
{
	time_per_mana			= 0;
	spelltype 				= SPELL_BAD;
	targetCollectAlgo		= TARGET_COLLECT_NONE;
};

func int Spell_Logic_SummonZombie(var int manaInvested)
{
	return Spell_Logic_Basic(self, SPL_Cost_SummonZombie);
};

func void Spell_Cast_SummonZombie()
{
	if (Npc_IsPlayer(self)) 
	{		
		Wld_SpawnNpcRange	(self,	Summoned_ZOMBIE,			1,	500);
	}
	else
	{
		Wld_SpawnNpcRange	(self,	Zombie01,			1,	500);
	};
	
	Spell_Cast_Basic(self, SPL_Cost_SummonZombie);
};
