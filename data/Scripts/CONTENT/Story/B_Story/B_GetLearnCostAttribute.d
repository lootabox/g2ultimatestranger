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
		if (oth.aivar[REAL_MANA_MAX] >= 120)		{	kosten = (5);	}
		else if (oth.aivar[REAL_MANA_MAX] >= 90) 	{	kosten = (4);	}
		else if (oth.aivar[REAL_MANA_MAX] >= 60) 	{	kosten = (3);	}
		else if (oth.aivar[REAL_MANA_MAX] >= 30) 	{	kosten = (2);	}
		else 										{	kosten = (1);	};
	};
	
	return kosten;
};

func int B_GetLearnCostAttribute2 (var C_NPC oth, var int attribute, var int amount)
{
	// Get current attribute value, without bonuses
	var int current;
		 if (attribute == ATR_STRENGTH)		{ current = oth.aivar[REAL_STRENGTH]; }
	else if (attribute == ATR_DEXTERITY)	{ current = oth.aivar[REAL_DEXTERITY]; }
	else if (attribute == ATR_MANA_MAX)		{ current = oth.aivar[REAL_MANA_MAX]; };

	// Different attributes have different intervals for LP cost increases
	var int interval;				  interval = 20;
	if (attribute == ATR_MANA_MAX)	{ interval = 30; };

	// Base cost (x amount) based on current attribute value
	var int cost; cost = amount + amount * (current/interval);

	// Extra value may be added near interval threshold to prevent exploiting
	var int extra; extra = (current - interval * (current/interval)) + (amount - interval);
		 if (extra > 5) { cost += 5; }
	else if (extra > 0) { cost += extra; };
	return cost;
};
