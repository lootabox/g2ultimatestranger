// ******************
// SPL_PalDestroyEvil
// ******************

const int SPL_Cost_PalDestroyEvil 			= 60;	
//const int SPL_Damage_PalDestroyEvil 		= 600; 

INSTANCE Spell_PalDestroyEvil (C_Spell_Proto)
{
	time_per_mana			= 0;
//	damage_per_level 		= SPL_DAMAGE_PalDestroyEvil;
	spelltype				= SPELL_NEUTRAL;
	damageType				= DAM_MAGIC;
	targetCollectAlgo		= TARGET_COLLECT_FOCUS;
	targetCollectRange		= FIGHT_DIST_CANCEL;
};

func int Spell_Logic_PalDestroyEvil	(var int manaInvested)
{
	// Cant cast at all if not targeting evil
	if (!C_NpcIsEvil(other))
	{
		return SPL_SENDSTOP;
	};
	return Spell_Logic_Pal(self, SPL_Cost_PalDestroyEvil);
};

func void Spell_Cast_PalDestroyEvil()
{
	// Spell damage for Spell_Cast_Focus is irrelevant since damage calculation overrides it
	Spell_Cast_Focus(SPL_PalDestroyEvil, 0, "spellFX_PalDestroyEvil_HEAVENSRAGE");
	Spell_Cast_Pal(self, SPL_Cost_PalDestroyEvil);
	Wld_PlayEffect("MFX_MASSDEATH_TARGET", other, other, 0, 0, 0, FALSE);
};
