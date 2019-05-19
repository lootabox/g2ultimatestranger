// *********
// SPL_Light
// *********

const int SPL_Cost_PalLight			= 10;
const int SPL_Cost_LIGHT			= 10;

const int SPL_Duration_PalLIGHT		= 5;	//fester Wert wird nur für die IT_Runenverwendet (Zeit in Minuten)
const int SPL_Duration_LIGHT		= 5;	//fester Wert wird nur für die IT_Runenverwendet (Zeit in Minuten)	


INSTANCE Spell_Light (C_Spell_Proto)
{
	time_per_mana			= 500;
	spelltype 				= SPELL_NEUTRAL;
	targetCollectAlgo		= TARGET_COLLECT_NONE;
	targetCollectRange		= 0;
	targetCollectAzi		= 0;
	targetCollectElev		= 0;
};


INSTANCE Spell_PalLight (C_Spell_Proto)
{
	time_per_mana			= 500;
	spelltype 				= SPELL_NEUTRAL;
	targetCollectAlgo		= TARGET_COLLECT_NONE;
	targetCollectRange		= 0;
	targetCollectAzi		= 0;
	targetCollectElev		= 0;
};


// ------ SPL_PalLight ------
func int Spell_Logic_PalLight(var int manaInvested)
{
	return Spell_Logic_Basic(self, SPL_Cost_PalLight);
};


func void Spell_Cast_PalLight()
{
	Spell_Cast_Basic(self, SPL_Cost_PalLight);
};

// ------ SPL_LIGHT ------
func int Spell_Logic_Light(var int manaInvested)
{
	return Spell_Logic_Basic(self, SPL_Cost_Light);
};

func void Spell_Cast_Light()
{
	Spell_Cast_Basic(self, SPL_Cost_Light);
};
