// ***********************************************************
// B_GetLearnCostAttribute
// -----------------------
// ermittelt die Kosten eines Attributspunktes (abh. v. Gilde)
// ***********************************************************
	
func int B_GetLearnCostAttribute (var C_NPC oth, var int attribut)
{
	var int kosten; kosten = 0;

	// ------ Kosten für Stärke ------
	if (attribut == ATR_STRENGTH) 
	{
		if (oth.aivar[REAL_STRENGTH] >= 80)		{	kosten = (5);	}
		else if (oth.aivar[REAL_STRENGTH] >= 60) 	{	kosten = (4);	}
		else if (oth.aivar[REAL_STRENGTH] >= 40) 	{	kosten = (3);	}
		else if (oth.aivar[REAL_STRENGTH] >= 20) 	{	kosten = (2);	}
		else 										{	kosten = (1);	};
	};
	
	// ------ Kosten für Dexterity ------
	if (attribut == ATR_DEXTERITY) 
	{
		if (oth.aivar[REAL_DEXTERITY] >= 80)		{	kosten = (5);	}
		else if (oth.aivar[REAL_DEXTERITY] >= 60)	{	kosten = (4);	}
		else if (oth.aivar[REAL_DEXTERITY] >= 40)	{	kosten = (3);	}
		else if (oth.aivar[REAL_DEXTERITY] >= 20)	{	kosten = (2);	}
		else 										{	kosten = (1);	};
	};
	
	// ------ Kosten für Mana MAX ------
	if (attribut == ATR_MANA_MAX)
	{		
		if (oth.aivar[REAL_MANA_MAX] >= 80)		{	kosten = (5);	}
		else if (oth.aivar[REAL_MANA_MAX] >= 60) 	{	kosten = (4);	}
		else if (oth.aivar[REAL_MANA_MAX] >= 40) 	{	kosten = (3);	}
		else if (oth.aivar[REAL_MANA_MAX] >= 20) 	{	kosten = (2);	}
		else 										{	kosten = (1);	};
	};
	
	return kosten;
};
