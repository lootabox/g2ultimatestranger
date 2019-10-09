// ***********
// SPL_IceCube
// ***********

const int	SPL_Cost_IceCube			=	20;
const int	SPL_Damage_IceCube			=	80;	// initial hit
const int	SPL_FREEZE_DAMAGE		 	=	SPL_Damage_IceCube / 10; // if changed, also possibly need to modify ZS_MagicFreeze
const int	SPL_FREEZE_TIME				=	SPL_Damage_IceCube / SPL_FREEZE_DAMAGE; // dont touch, only here so it doesnt need to be recalculated constantly

//Achtung: wenn bei FREEZE (19) die Werte ge�ndert werden, mu� auch die Lebensdauer der PFX angepasst werden

INSTANCE Spell_IceCube (C_Spell_Proto)
{
	time_per_mana			= 0;					//Wert wird nicht gebraucht - INSTANT-Spell
	damage_per_level 		= SPL_Damage_IceCube;	//Schaden wird im ZS_MagicFreeze angegeben!
};

func int Spell_Logic_IceCube (var int manaInvested) //Parameter wird hier nicht gebraucht
{
	return Spell_Logic_Basic(self, SPL_Cost_IceCube);
};

func void Spell_Cast_IceCube()
{
	Spell_Cast_Basic(self, SPL_Cost_IceCube);
};
