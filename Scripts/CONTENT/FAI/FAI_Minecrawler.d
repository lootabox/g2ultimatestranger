// *************************
// Kampf - AI Minecraler (5)
// *************************

/*
MOVE_RUN				
MOVE_RUNBACK			wie Jumpback ohne Parade-Fenster
MOVE_JUMPBACK			
MOVE_TURN				
MOVE_STRAFE				

MOVE_ATTACK				

MOVE_PARADE			
MOVE_STANDUP		
MOVE_WAIT				200 ms
*/


// ************************************
// Meine Reaktionen auf Gegner-Aktionen
// ************************************

// ------ Gegner attackiert mich ------
INSTANCE FA_ENEMY_PREHIT_5 (C_FightAI)
{
	move[0] = MOVE_STRAFE;
	move[1] = MOVE_JUMPBACK;
};

// ------ Gegner macht Sturmattacke ------
INSTANCE FA_ENEMY_STORMPREHIT_5 (C_FightAI)
{
	move[0] = MOVE_STRAFE;
};


// *******************************************
// Gegner in W-Reichweite (Treffer-Reichweite)
// *******************************************

// ------ Ich bin im Combo-Fenster ------
INSTANCE FA_MY_W_COMBO_5 (C_FightAI)
{
	// --- Wird nie erreicht (Neue FAI-Bewertung erst wenn Ani zuende gespielt) ---
};

// ------ Ich renne auf den Gegner zu ------
INSTANCE FA_MY_W_RUNTO_5 (C_FightAI)
{
	move[0] = MOVE_TURN; // --- STANDARDEINTRAG (Stehenbleiben) ---
};

// ------- Ich Strafe gerade ------
INSTANCE FA_MY_W_STRAFE_5 (C_FightAI)
{
	// --- Wird nie erreicht (Neue FAI-Bewertung erst wenn Ani zuende gespielt) ---
};

// ------- Ich habe Gegner im Fokus (kann treffen) -------
INSTANCE FA_MY_W_FOCUS_5 (C_FightAI)
{
	move[0] = MOVE_ATTACK;
};

// ------- Ich habe Gegner NICHT im Fokus -------
INSTANCE FA_MY_W_NOFOCUS_5 (C_FightAI)
{
	move[0] = MOVE_TURN; // --- STANDARDEINTRAG ---
};


// *************************************************
// Gegner in G-Reichweite (Sturmattacken-Reichweite)
// *************************************************

// ------ Ich bin im Combo-Fenster ------
INSTANCE FA_MY_G_COMBO_5 (C_FightAI)
{
	// --- Wird nie erreicht (Neue FAI-Bewertung erst wenn Ani zuende gespielt) ---
};

// ------ Ich renne auf den Gegner zu (kann Sturmattacke machen) ------
INSTANCE FA_MY_G_RUNTO_5 (C_FightAI)
{
	//move[0] = MOVE_ATTACK; //Sturmattacke
	move[0] = MOVE_RUN;
};

// ------- Ich Strafe gerade ------
INSTANCE FA_MY_G_STRAFE_5 (C_FightAI)
{
	// --- Wird nie erreicht (Neue FAI-Bewertung erst wenn Ani zuende gespielt) ---
};

// ------- Ich habe Gegner im Fokus -------
INSTANCE FA_MY_G_FOCUS_5 (C_FightAI)
{
	move[0] = MOVE_RUN; // --- STANDARDEINTRAG ---
};


// ***************************************
// Gegner in FK-Reichweite (weit entfernt)
// ***************************************

// ------- Ich habe Gegner im Fokus -------
INSTANCE FA_MY_FK_FOCUS_5 (C_FightAI)
{
	move[0] = MOVE_RUN; // --- STANDARDEINTRAG ---
};

// ------- Ich habe Gegner NICHT im Fokus (gilt auch f�r G-Distanz!) -------
INSTANCE FA_MY_G_FK_NOFOCUS_5 (C_FightAI)
{
	move[0] = MOVE_TURN; // --- STANDARDEINTRAG ---
};


// ***********************************
// FAI f�r Fernkampf 
// ---------------------------
// (wird bei jeder Entfernung benutzt)
// ***********************************

// ------ Gegner im Fokus ------
INSTANCE FA_MY_FK_FOCUS_FAR_5 (C_FightAI)
{
	move[0] = MOVE_ATTACK; // --- STANDARDEINTRAG ---
};

// ------ Gegner NICHT im Fokus ------
INSTANCE FA_MY_FK_NOFOCUS_FAR_5 (C_FightAI)
{
	move[0] = MOVE_TURN; // --- STANDARDEINTRAG ---
};


// ***********************************
// FAI f�r Magie
// ---------------------------
// (wird bei jeder Entfernung benutzt)
// ***********************************

// ------ Gegner im Fokus ------
INSTANCE FA_MY_FK_FOCUS_MAG_5 (C_FightAI)
{
	move[0] = MOVE_ATTACK; // --- STANDARDEINTRAG ---
	move[1] = MOVE_WAIT_LONGER;
	move[2] = MOVE_WAIT_LONGER;
	move[3] = MOVE_WAIT_LONGER;
	move[4] = MOVE_WAIT_LONGER;
	move[5] = MOVE_WAIT_LONGER;
};

// ------ Gegner NICHT im Fokus -------
INSTANCE FA_MY_FK_NOFOCUS_MAG_5 (C_FightAI)
{
	move[0] = MOVE_TURN; // --- STANDARDEINTRAG ---
};
