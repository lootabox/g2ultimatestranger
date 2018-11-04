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
	var int STEP_size; STEP_size = STEP_Firestorm;
	if (Npc_GetActiveSpellIsScroll(self)) {STEP_size = SPL_Cost_Scroll;};
	if (self.attribute[ATR_MANA]<STEP_size)
	{
		return SPL_SENDCAST;
	}
	else if (manaInvested == 0)
	{
		self.attribute[ATR_MANA] -= STEP_size;
		self.aivar[AIV_SpellLevel] = 1; //Start mit Level 1
	}
	else if (manaInvested > (STEP_size*1))
	&& (self.aivar[AIV_SpellLevel] <= 1)
	{
		self.attribute[ATR_MANA] -= STEP_size;
		self.aivar[AIV_SpellLevel] = 2;
		return SPL_NEXTLEVEL; //Lev2 erreicht
	}
	else if (manaInvested > (STEP_size*2))
	&& (self.aivar[AIV_SpellLevel] <= 2)
	{
		self.attribute[ATR_MANA] -= STEP_size;
		self.aivar[AIV_SpellLevel] = 3;
		return SPL_NEXTLEVEL; //Lev3 erreicht
	}
	else if (manaInvested > (STEP_size*3))
	&& (self.aivar[AIV_SpellLevel] <= 3)
	{
		self.attribute[ATR_MANA] -= STEP_size;
		self.aivar[AIV_SpellLevel] = 4;
		return SPL_NEXTLEVEL; //Lev4 erreicht
	}
	else if (manaInvested > (STEP_size*3))
	&& (self.aivar[AIV_SpellLevel] == 4)
	{
		return SPL_SENDCAST;
	};
	return SPL_STATUS_CANINVEST_NO_MANADEC;
};

func void Spell_Cast_Pyrokinesis(var int spellLevel)
{	
	self.aivar[AIV_SelectSpell] += 1;
};
