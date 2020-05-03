// ***********************************************************************************************************
// Spell_ProcessMana_Release
// -------------------------
// wird aufgerufen, NACHDEM die Action Taste losgelassen wurde, 
// und in Spell_ProcessMana der Spruch NOCH NICHT GECASTED und NOCH NICHT GESTOPPT wurde
// es macht keinen Sinn, diese Funktion was anderes als SPL_SENDSTOP oder SPL_SENDCAST zurückliefern zu lassen
// self 	= Der Caster
// other 	= Das Opfer (kann auch leer sein)
// ***********************************************************************************************************

func int Spell_ProcessMana_Release (var int manaInvested)
{
	var int activeSpell; activeSpell = Npc_GetActiveSpell(self);
	
	// ------ Spells, die beim loslassen der Taste gecastet werden ------
	if		(activeSpell == SPL_Pyrokinesis				)	{	Staff_Water_Charged = FALSE;	return	SPL_SENDCAST;	} //ALIAS CHARGE FIRESTORM!!!
	else if	(activeSpell == SPL_ChargeFireball			)	{	Staff_Water_Charged = FALSE;	return	SPL_SENDCAST;	}
	else if	(activeSpell == SPL_ChargeZap				)	{	Staff_Water_Charged = FALSE;	return	SPL_SENDCAST;	}
	else if	(activeSpell == SPL_WINDFIST				)	{	Staff_Water_Charged = FALSE;	return	SPL_SENDCAST;	}

	else if	(activeSpell == SPL_DestroyUndead			)	{	Staff_Water_Charged = FALSE;	return	SPL_SENDCAST;	}
	else if	(activeSpell == SPL_Light					)	{	Staff_Water_Charged = FALSE;	return	SPL_SENDCAST;	}
	else if	(activeSpell == SPL_PalLight				)	{	Staff_Water_Charged = FALSE;	return	SPL_SENDCAST;	}

	else if	(activeSpell == SPL_SummonWolf				)	{	Staff_Water_Charged = FALSE;	return	SPL_SENDCAST;	}
	else if	(activeSpell == SPL_SummonGoblinSkeleton	)	{	Staff_Water_Charged = FALSE;	return	SPL_SENDCAST;	}
	else if	(activeSpell == SPL_SummonSkeleton			)	{	Staff_Water_Charged = FALSE;	return	SPL_SENDCAST;	}
	else if	(activeSpell == SPL_SummonDemon				)	{	Staff_Water_Charged = FALSE;	return	SPL_SENDCAST;	}
	else if	(activeSpell == SPL_ArmyOfDarkness			)	{	Staff_Water_Charged = FALSE;	return	SPL_SENDCAST;	}
	else if	(activeSpell == SPL_SummonGuardian			)	{	Staff_Water_Charged = FALSE;	return	SPL_SENDCAST;	}
	else if	(activeSpell == SPL_SummonMud				)	{	Staff_Water_Charged = FALSE;	return	SPL_SENDCAST;	};

	// ------ Alle anderen Spells (Aufrechterhaltung oder Loslassen OHNE gecastet zu haben (zu wenig investiert) ------	
	return SPL_SENDSTOP;
};
