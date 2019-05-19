// ****************
// Alle Heal Spells
// ****************

const int SPL_Cost_PalLightHeal		= 10;
const int SPL_Cost_PalMediumHeal	= 20;
const int SPL_Cost_PalFullHeal		= 40;
const int SPL_Cost_LightHeal		= 10;
const int SPL_Cost_MediumHeal		= 20;
const int SPL_Cost_FullHeal			= 40;

const int SPL_Heal_PalLightHeal		= 75;
const int SPL_Heal_PalMediumHeal	= 150;
const int SPL_Heal_PalFullHeal		= 300;

const int SPL_Heal_LightHeal		= 50;
const int SPL_Heal_MediumHeal		= 100;
const int SPL_Heal_FullHeal			= 200;

// ------ Instanz für alle normalen Heal-Sprüche ------
instance Spell_Heal (C_Spell_Proto)
{
	time_per_mana			= 0;
	spelltype 				= SPELL_NEUTRAL;
	targetCollectAlgo		= TARGET_COLLECT_CASTER;
};


// ------ Instanz für alle Paladin Heal-Sprüche ------
instance Spell_PalHeal (C_Spell_Proto)
{
	time_per_mana			= 0;
	spelltype 				= SPELL_NEUTRAL;
	targetCollectAlgo		= TARGET_COLLECT_CASTER;
};


// ------ SPL_PalLightHeal -------
func int Spell_Logic_PalLightHeal (var int manaInvested)
{	
	return Spell_Logic_Basic(self, SPL_Cost_PalLightHeal);
};

// ------ SPL_PalMediumHeal -------
func int Spell_Logic_PalMediumHeal (var int manaInvested)
{
	return Spell_Logic_Basic(self, SPL_Cost_PalMediumHeal);
};


// ------ PalFullHeal -------
func int Spell_Logic_PalFullHeal (var int manaInvested)
{
	return Spell_Logic_Basic(self, SPL_Cost_PalFullHeal);
};


// ------ SPL_LightHeal -------
func int Spell_Logic_LightHeal (var int manaInvested)
{
	return Spell_Logic_Basic(self, SPL_Cost_LightHeal);
};

// ------ SPL_MediumHeal -------
func int Spell_Logic_MediumHeal (var int manaInvested)
{
	return Spell_Logic_Basic(self, SPL_Cost_MediumHeal);
};


// ------ SPL_FullHeal -------
func int Spell_Logic_FullHeal (var int manaInvested)
{	
	return Spell_Logic_Basic(self, SPL_Cost_FullHeal);
};



func void Spell_Cast_Heal()
{
	if ( Npc_GetActiveSpell(self) == SPL_LightHeal		)	
	{	
		Spell_Cast_Basic(self, SPL_Cost_LightHeal);
		Npc_ChangeAttribute	(self,ATR_HITPOINTS, +SPL_Heal_LightHeal);
		return;
	};
	
	if ( Npc_GetActiveSpell(self) == SPL_MediumHeal		)	
	{	
		Spell_Cast_Basic(self, SPL_Cost_MediumHeal);
		Npc_ChangeAttribute	(self,ATR_HITPOINTS, +SPL_Heal_MediumHeal);
		return;
	};
	
	if ( Npc_GetActiveSpell(self) == SPL_FullHeal		)	
	{	
		Spell_Cast_Basic(self, SPL_Cost_FullHeal);
		Npc_ChangeAttribute	(self,ATR_HITPOINTS, + SPL_Heal_FullHeal);
		return;
	};
	
	self.aivar[AIV_SelectSpell] += 1;
};

func void Spell_Cast_PalHeal()
{
	if ( Npc_GetActiveSpell(self) == SPL_PalLightHeal		)	
	{	
		Spell_Cast_Basic(self, SPL_Cost_PalLightHeal);
		Npc_ChangeAttribute	(self,ATR_HITPOINTS, +SPL_Heal_PalLightHeal);
		return;
	};
	
	if ( Npc_GetActiveSpell(self) == SPL_PalMediumHeal		)	
	{	
		Spell_Cast_Basic(self, SPL_Cost_PalMediumHeal);
		Npc_ChangeAttribute	(self,ATR_HITPOINTS, +SPL_Heal_PalMediumHeal);
		return;
	};
	
	if ( Npc_GetActiveSpell(self) == SPL_PalFullHeal		)	
	{	
		Spell_Cast_Basic(self, SPL_Cost_PalFullHeal);
		Npc_ChangeAttribute	(self,ATR_HITPOINTS, +SPL_Heal_PalFullHeal);
		return;
	};
	
	self.aivar[AIV_SelectSpell] += 1;
};
