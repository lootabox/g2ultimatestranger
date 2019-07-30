// ***************
// SPL_SummonGolem
// ***************

const int SPL_Cost_SummonGolem		= 80;
const int SPL_Degen_SummonGolem		= 6;


INSTANCE Spell_SummonGolem (C_Spell_Proto)	//ehem. Spell_Golem
{
	time_per_mana			= 0;
	spelltype 				= SPELL_BAD;
	targetCollectAlgo		= TARGET_COLLECT_NONE;
};

func int Spell_Logic_SummonGolem (var int manaInvested)
{	
	var c_item wpn; wpn = Npc_GetEquippedMeleeWeapon(self);
	if (Hlp_IsItem(wpn, ItMW_Addon_Stab02_Infused))
	{
		return Spell_Logic_Invest(self, manaInvested, SPL_Cost_SummonGolem, 3, TRUE);
	}
	else
	{
		return Spell_Logic_Invest(self, manaInvested, SPL_Cost_SummonGolem, 2, TRUE);
	};
};

func void Spell_Cast_SummonGolem()
{
	if (Npc_IsPlayer(self)) 
	{
		if (Npc_GetActiveSpellLevel(self) > 2)
		{
			Wld_SpawnNpcRange	(self,	Summoned_Magic_Golem,			1,	500);
		}
		else
		{
			Wld_SpawnNpcRange	(self,	Summoned_Golem,	1,	500);
		};
	}
	else
	{
		Wld_SpawnNpcRange	(self,	StoneGolem,			1,	500);
	};
};
