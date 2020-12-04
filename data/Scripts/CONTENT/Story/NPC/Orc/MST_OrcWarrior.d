//*****************************
//	Orc WARRIOR Prototype		
//*****************************

PROTOTYPE Mst_Default_OrcWarrior(C_Npc)			
{
	//----- Monster -----
	name							=	"Orc Warrior";
	guild							=	GIL_ORC;
	aivar[AIV_MM_REAL_ID]			= 	ID_ORCWARRIOR;
	voice							=	18;
	level							=	25;
	
	//----- Attribute -----	
	attribute	[ATR_STRENGTH]		=	60;
	attribute	[ATR_DEXTERITY]		=	60;
	attribute	[ATR_HITPOINTS_MAX]	=	200;
	attribute	[ATR_HITPOINTS]		=	200;
	attribute	[ATR_MANA_MAX] 		=	0;
	attribute	[ATR_MANA] 			=	0;
	
	//----- Protections ----	
	protection	[PROT_BLUNT]		=	60;
	protection	[PROT_EDGE]			=	60;
	protection	[PROT_POINT]		=	60;
	protection	[PROT_FIRE]			=	30; //0
	protection	[PROT_FLY]			=	60;
	protection	[PROT_MAGIC]		=	60; //0
	
	//----- HitChances -----
	HitChance	[NPC_TALENT_1H]			= 60;
	HitChance	[NPC_TALENT_2H]			= 60;
	HitChance	[NPC_TALENT_BOW]		= 60;
	HitChance	[NPC_TALENT_CROSSBOW]	= 60;
	
	//----- Damage Types ----	
	damagetype 						=	DAM_POINT;
//	damage		[DAM_INDEX_BLUNT]	=	0;
//	damage		[DAM_INDEX_EDGE]	=	0;
//	damage		[DAM_INDEX_POINT]	=	0;
//	damage		[DAM_INDEX_FIRE]	=	0;
//	damage		[DAM_INDEX_FLY]		=	0;
//	damage		[DAM_INDEX_MAGIC]	=	0;

	fight_tactic	=	FAI_ORC;

	//----- Senses & Ranges ----
	senses			= SENSE_HEAR | SENSE_SEE | SENSE_SMELL;
	senses_range	= PERC_DIST_ORC_ACTIVE_MAX;
	
	aivar[AIV_MM_FollowTime]	= FOLLOWTIME_MEDIUM;
	aivar[AIV_MM_FollowInWater] = FALSE;
};

//**************
//	Visuals
//**************

func void B_SetVisuals_OrcWarrior()
{
	Mdl_SetVisual			(self,	"Orc.mds");
	//								Body-Mesh			Body-Tex	Skin-Color	Head-MMS	Head-Tex	Teeth-Tex	ARMOR
	Mdl_SetVisualBody		(self,	"Orc_BodyWarrior",	DEFAULT,	DEFAULT,	"Orc_HeadWarrior",	DEFAULT,  	DEFAULT,	-1);
};

func void B_SetVisuals_OrcScout()
{
	Mdl_SetVisual			(self,	"Orc.mds");
	//								Body-Mesh			Body-Tex	Skin-Color	Head-MMS	Head-Tex	Teeth-Tex	ARMOR
	Mdl_SetVisualBody		(self,	"Orc_BodyScout",	DEFAULT,	DEFAULT,	"Orc_HeadWarrior",	DEFAULT,  	DEFAULT,	-1);
};

//******************
//	Orc Warrior Roam    														
//******************

INSTANCE OrcWarrior_Roam (Mst_Default_OrcWarrior)
{
	//-------- visual --------
	B_SetVisuals_OrcWarrior();

	//-------- inventory --------
	EquipItem (self, ItMw_2H_OrcAxe_03);
	
	//----- Daily Routine ----
	start_aistate				= ZS_MM_AllScheduler;

	aivar[AIV_MM_RoamStart] 	= OnlyRoutine;
};
//******************
//	Orc Warrior Rest    														
//******************

INSTANCE OrcWarrior_Rest (Mst_Default_OrcWarrior)
{
	//-------- visual --------
	B_SetVisuals_OrcWarrior();

	//-------- inventory --------
	EquipItem (self, ItMw_2H_OrcAxe_02);
	
	//----- Daily Routine ----
	start_aistate				= ZS_MM_AllScheduler;

	aivar[AIV_MM_RestStart] 	= OnlyRoutine;
};
//******************
//	Orc Warrior Sit    														
//******************

INSTANCE OrcWarrior_Sit (Mst_Default_OrcWarrior)
{
	//-------- visual --------
	B_SetVisuals_OrcWarrior();

	//-------- inventory --------
	EquipItem (self, ItMw_2H_OrcAxe_03);
	
	//----- Daily Routine ----
	start_aistate				= ZS_MM_AllScheduler;

	aivar[AIV_MM_OrcSitStart] 	= OnlyRoutine;
};



//******************************************************************************************************************************************************************************************************
//	Story Orks   														
//******************************************************************************************************************************************************************************************************

// ------ Ork vor Stadt ------
INSTANCE OrcWarrior_Harad (Mst_Default_OrcWarrior)
{
	name							=	"Orc Scout";
	
	level							=	15;
	
	//----- Attribute -----	
	attribute	[ATR_STRENGTH]		=	50; //60
	attribute	[ATR_DEXTERITY]		=	50; //60
	attribute	[ATR_HITPOINTS_MAX]	=	150; //200
	attribute	[ATR_HITPOINTS]		=	150; //200
	
	//----- Protections ----	
	protection	[PROT_BLUNT]		=	30; //60
	protection	[PROT_EDGE]			=	30; //60
	protection	[PROT_POINT]		=	30; //60
	protection	[PROT_FIRE]			=	30;
	protection	[PROT_FLY]			=	30; //60
	protection	[PROT_MAGIC]		=	30; //60
	
	//-------- visual --------
	B_SetVisuals_OrcScout();

	//-------- inventory --------
	// EquipItem (self, ItMw_2H_OrcAxe_01);
	EquipItem (self, ItMw_2H_OrcSword_01);
	
	//----- Daily Routine ----
	start_aistate				= ZS_MM_AllScheduler;

	aivar[AIV_MM_RestStart] 	= OnlyRoutine;
};


// ----- Lobarts Orks ------
INSTANCE OrcWarrior_Lobart1 (Mst_Default_OrcWarrior)
{
	//-------- visual --------
	B_SetVisuals_OrcWarrior();

	//-------- inventory --------
	EquipItem (self, ItMw_2H_OrcAxe_03);
	
	//----- Daily Routine ----
	start_aistate				= ZS_MM_AllScheduler;

	aivar[AIV_MM_RestStart] 	= OnlyRoutine;
};

INSTANCE OrcWarrior_Lobart2 (Mst_Default_OrcWarrior)
{
	//-------- visual --------
	B_SetVisuals_OrcWarrior();

	//-------- inventory --------
	EquipItem (self, ItMw_2H_OrcAxe_03);
	
	//----- Daily Routine ----
	start_aistate				= ZS_MM_AllScheduler;

	aivar[AIV_MM_RestStart] 	= OnlyRoutine;
};

INSTANCE OrcWarrior_Lobart3 (Mst_Default_OrcWarrior)
{
	//-------- visual --------
	B_SetVisuals_OrcWarrior();

	//-------- inventory --------
	EquipItem (self, ItMw_2H_OrcAxe_03);
	
	//----- Daily Routine ----
	start_aistate				= ZS_MM_AllScheduler;

	aivar[AIV_MM_RestStart] 	= OnlyRoutine;
};

INSTANCE OrcWarrior_Lobart4 (Mst_Default_OrcWarrior)
{
	//-------- visual --------
	B_SetVisuals_OrcWarrior();

	//-------- inventory --------
	EquipItem (self, ItMw_2H_OrcAxe_03);
	
	//----- Daily Routine ----
	start_aistate				= ZS_MM_AllScheduler;

	aivar[AIV_MM_RestStart] 	= OnlyRoutine;
};

INSTANCE OrcWarrior_Lobart5 (Mst_Default_OrcWarrior)
{
	//-------- visual --------
	B_SetVisuals_OrcWarrior();

	//-------- inventory --------
	EquipItem (self, ItMw_2H_OrcAxe_03);
	
	//----- Daily Routine ----
	start_aistate				= ZS_MM_AllScheduler;

	aivar[AIV_MM_RestStart] 	= OnlyRoutine;
};

INSTANCE OrcWarrior_Lobart6 (Mst_Default_OrcWarrior)
{
	//-------- visual --------
	B_SetVisuals_OrcWarrior();

	//-------- inventory --------
	EquipItem (self, ItMw_2H_OrcAxe_03);
	
	//----- Daily Routine ----
	start_aistate				= ZS_MM_AllScheduler;

	aivar[AIV_MM_RestStart] 	= OnlyRoutine;
};
