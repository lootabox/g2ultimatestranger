// ***************
// SPL_Pyrokinesis  ALIAS  ChargeFireStorm
// ***************

const int SPL_Cost_FireStorm		= 200; //4*50
const int STEP_Firestorm			= 50;
const int SPL_Damage_FireStorm 		= 75;

	// obsolete:
	const int SPL_PYRO_DAMAGE_PER_SEC = 20;	// wird in ZS_Pyro (Pyrokinese-Opfer) benutzt, dort KEIN Rùstungsschutz!
	////////////

INSTANCE Spell_Pyrokinesis (C_Spell_Proto)
{
	time_per_mana			= 30;
	damage_per_level		= SPL_Damage_FireStorm;		
	damageType				= DAM_MAGIC;				
	canTurnDuringInvest     = TRUE;
};

func int Spell_Logic_Pyrokinesis (var int manaInvested)
{
	return Spell_ProcessManaTier(self, manaInvested, STEP_Firestorm);
};

func void Spell_Cast_Pyrokinesis(var int spellLevel)
{	
	self.aivar[AIV_SelectSpell] += 1;
};
