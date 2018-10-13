//EVENTFUNCTIONS_ADANOSTEMPLE
var int ADW_ADANOSTEMPEL_STONEGRD_TRIGG_FUNC_01_OneTime;                                                       
func void ADW_ADANOSTEMPEL_STONEGRD_TRIGG_FUNC_01 ()
{
	if (ADW_ADANOSTEMPEL_STONEGRD_TRIGG_FUNC_01_OneTime == FALSE)
	{
		B_AWAKE_STONEGUARDIAN (Stoneguardian_ADANOSTEMPELENTRANCE_01);
		B_AWAKE_STONEGUARDIAN (Stoneguardian_ADANOSTEMPELENTRANCE_02);
		B_AWAKE_STONEGUARDIAN (Stoneguardian_ADANOSTEMPELENTRANCE_03);
		B_AWAKE_STONEGUARDIAN (Stoneguardian_ADANOSTEMPELENTRANCE_04);
	
		if ((Npc_IsDead(Stoneguardian_ADANOSTEMPELENTRANCE_01))== FALSE)
		|| ((Npc_IsDead(Stoneguardian_ADANOSTEMPELENTRANCE_02))== FALSE)
		|| ((Npc_IsDead(Stoneguardian_ADANOSTEMPELENTRANCE_03))== FALSE)
		|| ((Npc_IsDead(Stoneguardian_ADANOSTEMPELENTRANCE_04))== FALSE)
		{
			Snd_Play ("THRILLJINGLE_02"); 
		};
	
		B_KillNpc (BDT_10400_Addon_DeadBandit); 
		B_KillNpc (BDT_10401_Addon_DeadBandit);	
		ADW_ADANOSTEMPEL_STONEGRD_TRIGG_FUNC_01_OneTime = TRUE;
	};
};
var int OPEN_ADANOSTEMPELCHEST_01_FUNC_OneTime;
func void OPEN_ADANOSTEMPELCHEST_01_FUNC_S1 ()
{
	if (OPEN_ADANOSTEMPELCHEST_01_FUNC_OneTime == FALSE)
	{
		//B_AWAKE_STONEGUARDIAN (Stoneguardian_TREASUREPITS_05A);
		//B_AWAKE_STONEGUARDIAN (Stoneguardian_TREASUREPITS_05B);
		B_AWAKE_STONEGUARDIAN (Stoneguardian_TREASUREPITS_05C);
		//B_AWAKE_STONEGUARDIAN (Stoneguardian_TREASUREPITS_05D);
		B_AWAKE_STONEGUARDIAN (Stoneguardian_TREASUREPITS_05E);
		//B_AWAKE_STONEGUARDIAN (Stoneguardian_TREASUREPITS_05F);
	
		if ((Npc_IsDead(Stoneguardian_TREASUREPITS_05C))== FALSE)
		|| ((Npc_IsDead(Stoneguardian_TREASUREPITS_05E))== FALSE)
		{
			Snd_Play ("THRILLJINGLE_03"); 
		};

		OPEN_ADANOSTEMPELCHEST_01_FUNC_OneTime = TRUE;
	};
};
var int OPEN_ADANOSTEMPELCHEST_02_FUNC_OneTime;
func void OPEN_ADANOSTEMPELCHEST_02_FUNC_S1 ()
{
	if (OPEN_ADANOSTEMPELCHEST_02_FUNC_OneTime == FALSE)
	{
		B_AWAKE_STONEGUARDIAN (Stoneguardian_TREASUREPITS_09A);
		//B_AWAKE_STONEGUARDIAN (Stoneguardian_TREASUREPITS_09B);
		B_AWAKE_STONEGUARDIAN (Stoneguardian_TREASUREPITS_09C);
		//B_AWAKE_STONEGUARDIAN (Stoneguardian_TREASUREPITS_09D);
		B_AWAKE_STONEGUARDIAN (Stoneguardian_TREASUREPITS_09E);
		//B_AWAKE_STONEGUARDIAN (Stoneguardian_TREASUREPITS_09F);
		
		if ((Npc_IsDead(Stoneguardian_TREASUREPITS_09A))== FALSE)
		|| ((Npc_IsDead(Stoneguardian_TREASUREPITS_09C))== FALSE)
		|| ((Npc_IsDead(Stoneguardian_TREASUREPITS_09E))== FALSE)
		{
			Snd_Play ("THRILLJINGLE_02"); 
		};

		OPEN_ADANOSTEMPELCHEST_02_FUNC_OneTime = TRUE;
	};
};
var int ADW_ADANOSTEMPEL_STONEGRD_TRIGG_FUNC_02_OneTime;
func void ADW_ADANOSTEMPEL_STONEGRD_TRIGG_FUNC_02 ()
{
	if (ADW_ADANOSTEMPEL_STONEGRD_TRIGG_FUNC_02_OneTime == FALSE)
	{
		B_AWAKE_STONEGUARDIAN (Stoneguardian_RHADEMES_14A);
		//B_AWAKE_STONEGUARDIAN (Stoneguardian_RHADEMES_14B);
		//B_AWAKE_STONEGUARDIAN (Stoneguardian_RHADEMES_14C);
		B_AWAKE_STONEGUARDIAN (Stoneguardian_RHADEMES_14D);
		//B_AWAKE_STONEGUARDIAN (Stoneguardian_RHADEMES_14E);
		B_AWAKE_STONEGUARDIAN (Stoneguardian_RHADEMES_14F);
		SC_TookRhademesTrap = TRUE; 
		ADW_ADANOSTEMPEL_STONEGRD_TRIGG_FUNC_02_OneTime = TRUE;
	};
};
var int EVT_RAVEN_AWAKE_FUNC_OneTime;
func void EVT_RAVEN_AWAKE_FUNC ()
{
	/*
	if (EVT_RAVEN_AWAKE_FUNC_OneTime == FALSE)
	{
		var C_NPC Ravn; Ravn = Hlp_GetNpc (BDT_1090_Addon_Raven);
	
		AI_StandUp  (Ravn);
		AI_TurnToNpc (Ravn,hero);
		
		B_StartOtherRoutine	(Ravn,"WaitforPlayer");
		EVT_RAVEN_AWAKE_FUNC_OneTime = TRUE;		
	};
	*/
};



                                                                     
