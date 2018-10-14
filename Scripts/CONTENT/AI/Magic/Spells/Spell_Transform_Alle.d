// *********************
// Alle Transform Spells
// *********************

const int SPL_Cost_TrfSheep			= 10;
const int SPL_Cost_TrfScavenger		= 10;
const int SPL_Cost_TrfGiantRat		= 10;
const int SPL_Cost_TrfGiantBug		= 10;
const int SPL_Cost_TrfWolf			= 10;
const int SPL_Cost_TrfWaran			= 10;
const int SPL_Cost_TrfSnapper		= 10;
const int SPL_Cost_TrfWarg			= 10;
const int SPL_Cost_TrfFireWaran		= 10;
const int SPL_Cost_TrfLurker		= 10;
const int SPL_Cost_TrfShadowbeast	= 10;
const int SPL_Cost_TrfDragonSnapper	= 10;

// ------ Instanz für alle Transform-Sprüche ------
INSTANCE Spell_Transform (C_Spell_Proto)
{
	time_per_mana			= 0;
	spelltype 				= SPELL_NEUTRAL;
	targetCollectAlgo		= TARGET_COLLECT_NONE;
	canTurnDuringInvest		= 0;
};

// ------ Schaf ------
func int Spell_Logic_TrfSheep (var int manaInvested)
{
	if (Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
	}
	else if (self.attribute[ATR_MANA] >= SPL_Cost_TrfSheep)
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_TrfSheep;
	}
	else
	{
		return SPL_SENDSTOP;
	};
	if(Npc_IsPlayer(self))
	{
		Wld_StopEffect("SLOW_MOTION");
	};
	Npc_SetActiveSpellInfo(self, Sheep);
	return SPL_SENDCAST;
};

// ------ Scavenger ------
func int Spell_Logic_TrfScavenger (var int manaInvested)
{
	if (Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
	}
	else if (self.attribute[ATR_MANA] >= SPL_Cost_TrfScavenger)
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_TrfScavenger;
	}
	else
	{
		return SPL_SENDSTOP;
	};
	if(Npc_IsPlayer(self))
	{
		Wld_StopEffect("SLOW_MOTION");
	};
	Npc_SetActiveSpellInfo(self, Scavenger);
	return SPL_SENDCAST;
};

// ------ Giant Rat ------
func int Spell_Logic_TrfGiantRat (var int manaInvested)
{
	if (Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
	}
	else if (self.attribute[ATR_MANA] >= SPL_Cost_TrfGiantRat)
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_TrfGiantRat;
	}
	else
	{
		return SPL_SENDSTOP;
	};
	if(Npc_IsPlayer(self))
	{
		Wld_StopEffect("SLOW_MOTION");
	};
	Npc_SetActiveSpellInfo(self, Giant_Rat);
	return SPL_SENDCAST;
};


// ------ Giant BUG ------
func int Spell_Logic_TrfGiantBug (var int manaInvested)
{
	if (Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
	}
	else if (self.attribute[ATR_MANA] >= SPL_Cost_TrfGiantBug)
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_TrfGiantBug;
	}
	else
	{
		return SPL_SENDSTOP;
	};
	if(Npc_IsPlayer(self))
	{
		Wld_StopEffect("SLOW_MOTION");
	};
	Npc_SetActiveSpellInfo(self, Giant_Bug);
	return SPL_SENDCAST;
};

// ------ Wolf ------
func int Spell_Logic_TrfWolf (var int manaInvested)
{
	if (Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
	}
	else if (self.attribute[ATR_MANA] >= SPL_Cost_TrfWolf)
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_TrfWolf;
	}
	else
	{
		return SPL_SENDSTOP;
	};
	if(Npc_IsPlayer(self))
	{
		Wld_StopEffect("SLOW_MOTION");
	};
	Npc_SetActiveSpellInfo(self, Wolf);
	return SPL_SENDCAST;
};

// ------ Waran ------
func int Spell_Logic_TrfWaran (var int manaInvested)
{
	if (Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
	}
	else if (self.attribute[ATR_MANA] >= SPL_Cost_TrfWaran)
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_TrfWaran;
	}
	else
	{
		return SPL_SENDSTOP;
	};
	if(Npc_IsPlayer(self))
	{
		Wld_StopEffect("SLOW_MOTION");
	};
	Npc_SetActiveSpellInfo(self, Waran);
	return SPL_SENDCAST;
};

// ------ Snapper ------
func int Spell_Logic_TrfSnapper (var int manaInvested)
{
	if (Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
	}
	else if (self.attribute[ATR_MANA] >= SPL_Cost_TrfSnapper)
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_TrfSnapper;
	}
	else
	{
		return SPL_SENDSTOP;
	};
	if(Npc_IsPlayer(self))
	{
		Wld_StopEffect("SLOW_MOTION");
	};
	Npc_SetActiveSpellInfo(self, Snapper);
	return SPL_SENDCAST;
};

// ------ Warg ------
func int Spell_Logic_TrfWarg (var int manaInvested)
{
	if (Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
	}
	else if (self.attribute[ATR_MANA] >= SPL_Cost_TrfWarg)
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_TrfWarg;
	}
	else
	{
		return SPL_SENDSTOP;
	};
	if(Npc_IsPlayer(self))
	{
		Wld_StopEffect("SLOW_MOTION");
	};
	Npc_SetActiveSpellInfo(self, Warg);
	return SPL_SENDCAST;
};

// ------ Feuerwaran ------
func int Spell_Logic_TrfFireWaran (var int manaInvested)
{
	if (Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
	}
	else if (self.attribute[ATR_MANA] >= SPL_Cost_TrfFireWaran)
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_TrfFireWaran;
	}
	else
	{
		return SPL_SENDSTOP;
	};
	if(Npc_IsPlayer(self))
	{
		Wld_StopEffect("SLOW_MOTION");
	};
	Npc_SetActiveSpellInfo(self, FireWaran);
	return SPL_SENDCAST;
};

// ------ Lurker ------
func int Spell_Logic_TrfLurker (var int manaInvested)
{
	if (Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
	}
	else if (self.attribute[ATR_MANA] >= SPL_Cost_TrfLurker)
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_TrfLurker;
	}
	else
	{
		return SPL_SENDSTOP;
	};
	if(Npc_IsPlayer(self))
	{
		Wld_StopEffect("SLOW_MOTION");
	};
	Npc_SetActiveSpellInfo(self, Lurker);
	return SPL_SENDCAST;
};

// ------ Shadowbeast ------
func int Spell_Logic_TrfShadowbeast (var int manaInvested)
{
	if (Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
	}
	else if (self.attribute[ATR_MANA] >= SPL_Cost_TrfShadowbeast)
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_TrfShadowbeast;
	}
	else
	{
		return SPL_SENDSTOP;
	};
	if(Npc_IsPlayer(self))
	{
		Wld_StopEffect("SLOW_MOTION");
	};
	Npc_SetActiveSpellInfo(self, Shadowbeast);
	return SPL_SENDCAST;
};

// ------ Dragon Snapper ------
func int Spell_Logic_TrfDragonSnapper (var int manaInvested)
{
	if (Npc_GetActiveSpellIsScroll(self) && (self.attribute[ATR_MANA] >= SPL_Cost_Scroll))
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_Scroll;
	}
	else if (self.attribute[ATR_MANA] >= SPL_Cost_TrfDragonSnapper)
	{
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - SPL_Cost_TrfDragonSnapper;
	}
	else
	{
		return SPL_SENDSTOP;
	};
	if(Npc_IsPlayer(self))
	{
		Wld_StopEffect("SLOW_MOTION");
	};
	Npc_SetActiveSpellInfo(self, DragonSnapper);
	return SPL_SENDCAST;
};





