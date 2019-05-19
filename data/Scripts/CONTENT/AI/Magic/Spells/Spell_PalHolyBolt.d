// ***************
// SPL_PalHolyBolt
// ***************

const int SPL_Cost_PalHolyBolt	 = 10;
const int SPL_Damage_PalHolyBolt = 100;

INSTANCE Spell_PalHolyBolt (C_Spell_Proto)
{
	time_per_mana			= 0;			//Spell wirkt Instant
	damage_per_level 		= SPL_Damage_PalHolyBolt; //+
};

func int Spell_Logic_PalHolyBolt (var int manaInvested)
{
	return Spell_Logic_Basic(self, SPL_Cost_PalHolyBolt);
};

func void Spell_Cast_PalHolyBolt()
{
	Spell_Cast_Basic(self, SPL_Cost_PalHolyBolt);
};
