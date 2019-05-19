// ***************
// SPL_SummonGolem
// ***************

const int SPL_Cost_SummonGolem		= 80;


INSTANCE Spell_SummonGolem (C_Spell_Proto)	//ehem. Spell_Golem
{
	time_per_mana			= 0;
	spelltype 				= SPELL_BAD;
	targetCollectAlgo		= TARGET_COLLECT_NONE;
};

func int Spell_Logic_SummonGolem (var int manaInvested)
{	
	return Spell_Logic_Basic(self, SPL_Cost_SummonGolem);
	
};

func void Spell_Cast_SummonGolem()
{
	if (Npc_IsPlayer(self)) 
	{		
		Wld_SpawnNpcRange( self,Summoned_Golem,1,500);
	}
	else
	{
		Wld_SpawnNpcRange( self,StoneGolem,1,500);
	};
	
	Spell_Cast_Basic(self, SPL_Cost_SummonGolem);
};
