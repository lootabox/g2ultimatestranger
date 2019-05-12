// ************
// SPL_WindFist
// ************

const int SPL_Cost_WindFist				= 80; //4*20
const int STEP_WindFist					= 20;
const int SPL_Damage_WindFist			= 50;

INSTANCE Spell_WindFist (C_Spell_Proto)
{
	time_per_mana			= 30;
	damage_per_level		= SPL_Damage_WindFist;			//pro Level !!!
	damageType				= DAM_FLY;
	
	targetCollectAlgo		= TARGET_COLLECT_FOCUS_FALLBACK_NONE;
	targetCollectRange		= 1000;
	targetCollectType		= TARGET_TYPE_NPCS;
};

func int Spell_Logic_WindFist (var int manaInvested)
{
	return Spell_ProcessManaTier(self, manaInvested, STEP_WindFist);
};

func void Spell_Cast_WindFist(var int spellLevel)
{
	self.aivar[AIV_SelectSpell] += 1;
};
