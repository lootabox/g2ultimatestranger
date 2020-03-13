// ******************
// SPL_PalDestroyEvil
// ******************

const int SPL_Cost_PalDestroyEvil 			= 40;	
const int SPL_Damage_PalDestroyEvil 		= 400; 

INSTANCE Spell_PalDestroyEvil (C_Spell_Proto)
{
	time_per_mana			= 0;
	damage_per_level 		= SPL_DAMAGE_PalDestroyEvil;
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
	return Spell_Logic_Basic(self, SPL_Cost_PalDestroyEvil);
};

func void Spell_Cast_PalDestroyEvil()
{
	//Spell_Cast_Basic(self, SPL_Cost_PalDestroyEvil);
	Spell_Cast_Focus(SPL_PalDestroyEvil, SPL_Cost_PalDestroyEvil, SPL_Damage_PalDestroyEvil, "spellFX_PalDestroyEvil_HEAVENSRAGE");
	Wld_PlayEffect("MFX_MASSDEATH_TARGET", other, other, 0, 0, 0, FALSE);
};
