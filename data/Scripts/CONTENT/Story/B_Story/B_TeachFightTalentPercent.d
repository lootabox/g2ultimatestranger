// ***************************************************
// B_TeachFightTalentPercent
// -------------------------
// Kosten abh�ngig von "verwandtem" Waffentalent-Level
// ***************************************************

// -------------------------------
func int B_TeachFightTalentPercent (var C_NPC slf, var C_NPC oth, var int talent, var int percent, var int teacherMAX)
{
	var string concatText;
	
	// ------ Kostenberechnung ------
	var int kosten; 
	kosten = B_GetLearnCostTalent(oth, talent, percent);
	
	//EXIT IF...
	
	// ------ falscher Parameter ------
	if (talent!=NPC_TALENT_1H) && (talent!=NPC_TALENT_2H) && (talent!=NPC_TALENT_BOW) && (talent!=NPC_TALENT_CROSSBOW)
	{
		Print ("*** ERROR: Wrong Parameter ***");
		return FALSE;
	};
	
	// ------ Lernen NICHT �ber teacherMax ------
	var int realHitChance;
	if 		(talent == NPC_TALENT_1H)		{	realHitChance = oth.aivar[REAL_TALENT_1H];		}	// Umwandeln von const-Parameter in VAR f�r folgende If-Abfrage
	else if (talent == NPC_TALENT_2H)		{	realHitChance = oth.aivar[REAL_TALENT_2H];		}
	else if (talent == NPC_TALENT_BOW)		{	realHitChance = oth.aivar[REAL_TALENT_BOW];		}
	else if (talent == NPC_TALENT_CROSSBOW) {	realHitChance = oth.aivar[REAL_TALENT_CROSSBOW];	};
	
	if (realHitChance >= teacherMAX)
	{
		concatText = ConcatStrings (PRINT_NoLearnOverPersonalMAX, IntToString(teacherMAX));
		PrintScreen	(concatText, -1, -1, FONT_SCREEN, 2);
		B_Say (slf, oth, "$NOLEARNYOUREBETTER");
		
		return FALSE;
	};
	
	if ((realHitChance + percent) > teacherMAX)
	{
		concatText = ConcatStrings (PRINT_NoLearnOverPersonalMAX, IntToString(teacherMAX));
		PrintScreen	(concatText, -1, -1, FONT_SCREEN, 2);
		B_Say (slf, oth, "$NOLEARNOVERPERSONALMAX");
	
		return FALSE;
	};
	
	// ------ Player hat zu wenig Lernpunkte ------
	if (oth.lp < kosten)
	{
		PrintScreen	(PRINT_NotEnoughLP, -1, -1, FONT_Screen, 2);
		B_Say (slf, oth, "$NOLEARNNOPOINTS");
		
		return FALSE;
	};

		
	// FUNC
				
	// ------ Lernpunkte abziehen ------
	oth.lp = oth.lp - kosten;
	
	// ------ 1H steigern ------
	if (talent == NPC_TALENT_1H)
	{	
		B_RaiseFightTalent (oth, NPC_TALENT_1H, percent);	//Einhand steigern
		B_RaiseRealFightTalentPercent (oth, NPC_TALENT_1H, percent);
		
		if (oth.aivar[REAL_TALENT_1H] > (oth.aivar[REAL_TALENT_2H] * 2))
		{
			B_RaiseFightTalent (oth, NPC_TALENT_2H, percent);	//Zweihand mit hochziehen
			B_RaiseRealFightTalentPercent (oth, NPC_TALENT_2H, percent);
			PrintScreen	(PRINT_Learn1H_and_2H, -1, -1, FONT_Screen, 2);
		}
		else
		{
			PrintScreen	(PRINT_Learn1H, -1, -1, FONT_Screen, 2);
		};
		
		return TRUE;
	};
	
	// ------ 2H steigern ------
	if (talent == NPC_TALENT_2H)
	{	
		B_RaiseFightTalent (oth, NPC_TALENT_2H, percent);	//Zweihand steigern
		B_RaiseRealFightTalentPercent (oth, NPC_TALENT_2H, percent);
		
		if (oth.aivar[REAL_TALENT_2H] > (oth.aivar[REAL_TALENT_1H] * 2))
		{
			B_RaiseFightTalent (oth, NPC_TALENT_1H, percent);	//Einhand mit hochziehen
			B_RaiseRealFightTalentPercent (oth, NPC_TALENT_1H, percent);
			PrintScreen	(PRINT_Learn2H_and_1H, -1, -1, FONT_Screen, 2);
		}
		else
		{
			PrintScreen	(PRINT_Learn2H, -1, -1, FONT_Screen, 2);
		};
		
		return TRUE;
	};
		
	// ------ Bogen steigern ------	
	if (talent == NPC_TALENT_BOW)
	{	
		B_RaiseFightTalent (oth, NPC_TALENT_BOW, percent);	//Bogen steigern
		B_RaiseRealFightTalentPercent (oth, NPC_TALENT_BOW, percent);
		
		if (oth.aivar[REAL_TALENT_BOW] > (oth.aivar[REAL_TALENT_CROSSBOW] * 2))
		{
			B_RaiseFightTalent (oth, NPC_TALENT_CROSSBOW, percent);	//Crossbow mit hochziehen
			B_RaiseRealFightTalentPercent (oth, NPC_TALENT_CROSSBOW, percent);
			PrintScreen	(PRINT_LearnBow_and_Crossbow, -1, -1, FONT_Screen, 2);
		}
		else
		{
			PrintScreen	(PRINT_LearnBow, -1, -1, FONT_Screen, 2);
		};
		
		return TRUE;
	};
	
	// ------ Crossbow steigern ------
	if (talent == NPC_TALENT_CROSSBOW)
	{	
		B_RaiseFightTalent (oth, NPC_TALENT_CROSSBOW, percent);	//Crossbow steigern
		B_RaiseRealFightTalentPercent (oth, NPC_TALENT_CROSSBOW, percent);
		
		if (oth.aivar[REAL_TALENT_CROSSBOW] > (oth.aivar[REAL_TALENT_BOW] * 2))
		{
			B_RaiseFightTalent (oth, NPC_TALENT_BOW, percent);	//Bogen mit hochziehen
			B_RaiseRealFightTalentPercent (oth, NPC_TALENT_BOW, percent);
			PrintScreen	(PRINT_LearnCrossbow_and_Bow, -1, -1, FONT_Screen, 2);
		}
		else
		{
			PrintScreen	(PRINT_LearnCrossbow, -1, -1, FONT_Screen, 2);
		};
		
		return TRUE;
	};
};
