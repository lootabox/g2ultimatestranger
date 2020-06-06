//************************
//	Skeleton Prototype
//************************

PROTOTYPE Mst_Default_Skeleton(C_Npc)			
{
	//----- Monster ----
	name							=	"Skeleton";
	guild							=	GIL_SKELETON;
	aivar[AIV_MM_REAL_ID]			= 	ID_SKELETON;
	level							=	30;

	//----- Attribute ----	
	attribute	[ATR_STRENGTH]		=	100; //+25 Waffe
	attribute	[ATR_DEXTERITY]		=	150;
	attribute	[ATR_HITPOINTS_MAX]	=	150;
	attribute	[ATR_HITPOINTS]		=	150;
	attribute	[ATR_MANA_MAX] 		=	0;
	attribute	[ATR_MANA] 			=	0;

	//----- Protection ----
	protection	[PROT_BLUNT]		=	125;
	protection	[PROT_EDGE]			=	125;
	protection	[PROT_POINT]		=	175; 
	protection	[PROT_FIRE]			=	125;
	protection	[PROT_FLY]			=	125;
	protection	[PROT_MAGIC]		=	0;
		
	//----- Damage Types ----
	damagetype 						=	DAM_EDGE;
//	damage		[DAM_INDEX_BLUNT]	=	0;
//	damage		[DAM_INDEX_EDGE]	=	0;
//	damage		[DAM_INDEX_POINT]	=	0;
//	damage		[DAM_INDEX_FIRE]	=	0;
//	damage		[DAM_INDEX_FLY]		=	0;
//	damage		[DAM_INDEX_MAGIC]	=	0;

	//----- Kampf-Taktik ----
	fight_tactic	=	FAI_HUMAN_STRONG;
	
	//----- Senses & Ranges ----
	senses			= 	SENSE_HEAR | SENSE_SEE | SENSE_SMELL;
	senses_range	=	PERC_DIST_MONSTER_ACTIVE_MAX;
	
	aivar[AIV_MM_FollowTime]	= FOLLOWTIME_MEDIUM;
	aivar[AIV_MM_FollowInWater] = FALSE;
	
	//----- Daily Routine ----
	start_aistate				= ZS_MM_AllScheduler;

	aivar[AIV_MM_RestStart] 	= OnlyRoutine;
};

//***************
//	Visuals
//***************

func void B_SetVisuals_Warrior_Skeleton()
{
	Mdl_SetVisual			(self,	"HumanS.mds");
	//Mdl_ApplyOverlayMds 	(self,	"humans_1hST1.mds");
	Mdl_ApplyOverlayMds		(self,	"humans_pirate.mds");
	//Mdl_ApplyOverlayMds 	(self,	"humans_2hST2.mds");
	Mdl_ApplyOverlayMds		(self,	"humans_axest1.mds");
	Mdl_ApplyOverlayMds 	(self,	"humans_BowT1.mds");
	Mdl_ApplyOverlayMds 	(self,	"humans_CBowT1.mds");
	Mdl_ApplyOverlayMds 	(self,	"humans_skeleton.mds");
	Mdl_ApplyOverlayMds 	(self,	"skeleton_wait.mds");
	//								Body-Mesh		Body-Tex	Skin-Color	Head-MMS	Head-Tex	Teeth-Tex	ARMOR
	Mdl_SetVisualBody		(self,	"Ske_Body3",	DEFAULT,	DEFAULT,	"",			DEFAULT,  	DEFAULT,	-1);
};

func void B_SetVisuals_Skeleton()
{
	Mdl_SetVisual			(self,	"HumanS.mds");
	//Mdl_ApplyOverlayMds 	(self,	"humans_1hST1.mds");
	Mdl_ApplyOverlayMds		(self,	"humans_pirate.mds");
	//Mdl_ApplyOverlayMds 	(self,	"humans_2hST2.mds");
	Mdl_ApplyOverlayMds		(self,	"humans_axest1.mds");
	Mdl_ApplyOverlayMds 	(self,	"humans_BowT1.mds");
	Mdl_ApplyOverlayMds 	(self,	"humans_CBowT1.mds");
	Mdl_ApplyOverlayMds 	(self,	"humans_skeleton.mds");
	Mdl_ApplyOverlayMds 	(self,	"skeleton_wait.mds");
	//								Body-Mesh		Body-Tex	Skin-Color	Head-MMS	Head-Tex	Teeth-Tex	ARMOR
	Mdl_SetVisualBody		(self,	"Ske_Body2",	DEFAULT,	DEFAULT,	"",			DEFAULT,  	DEFAULT,	-1);
};

func void B_SetVisuals_Lesser_Skeleton()
{
	Mdl_SetVisual			(self,	"HumanS.mds");
	//Mdl_ApplyOverlayMds 	(self,	"humans_1hST1.mds");
	Mdl_ApplyOverlayMds		(self,	"humans_pirate.mds");
	//Mdl_ApplyOverlayMds 	(self,	"humans_2hST2.mds");
	Mdl_ApplyOverlayMds		(self,	"humans_axest1.mds");
	Mdl_ApplyOverlayMds 	(self,	"humans_BowT1.mds");
	Mdl_ApplyOverlayMds 	(self,	"humans_CBowT1.mds");
	Mdl_ApplyOverlayMds 	(self,	"humans_skeleton.mds");
	Mdl_ApplyOverlayMds 	(self,	"skeleton_wait.mds");
	//								Body-Mesh		Body-Tex	Skin-Color	Head-MMS	Head-Tex	Teeth-Tex	ARMOR
	Mdl_SetVisualBody		(self,	"Ske_Body",		DEFAULT,	DEFAULT,	"",			DEFAULT,  	DEFAULT,	-1);
};


//**************
//	Skeleton    
//**************

INSTANCE Skeleton			(Mst_Default_Skeleton)
{
	B_SetVisuals_Skeleton();

	//EquipItem (self, ItMw_2H_Sword_M_01);
	EquipItem (self, ItMw_1h_Misc_Axe);
};

INSTANCE Summoned_Skeleton_Evil	(Mst_Default_Skeleton)
{
	level							=	0; //30

	B_SetVisuals_Skeleton();

	//EquipItem (self, ItMw_2H_Sword_M_01);
	EquipItem (self, ItMw_1h_Misc_Axe);
};

//**************
//	Skeleton    
//**************

INSTANCE Summoned_Skeleton (Mst_Default_Skeleton)
{
	name							=	"Summoned Skeleton";
	guild							=	GIL_SUMMONED_SKELETON;
	aivar[AIV_MM_REAL_ID]			= 	ID_SUMMONED_SKELETON;
	level							=	0; //30

	//----- Attribute ----	
	attribute	[ATR_STRENGTH]		=	100; //+25 Waffe
	attribute	[ATR_DEXTERITY]		=	150;
	attribute	[ATR_HITPOINTS_MAX]	=	150;
	attribute	[ATR_HITPOINTS]		=	150;
	attribute	[ATR_MANA_MAX] 		=	0;
	attribute	[ATR_MANA] 			=	0;

	//----- Protection ----
	protection	[PROT_BLUNT]		=	125;
	protection	[PROT_EDGE]			=	125;
	protection	[PROT_POINT]		=	175; 
	protection	[PROT_FIRE]			=	125;
	protection	[PROT_FLY]			=	125;
	protection	[PROT_MAGIC]		=	0;
	
	fight_tactic	=	FAI_HUMAN_NORMAL;
	
	// ------ visual ------
	B_SetVisuals_Lesser_Skeleton();
	
	aivar[AIV_PARTYMEMBER] = TRUE;
	B_SetAttitude (self, ATT_FRIENDLY); 
	
	start_aistate = ZS_MM_Rtn_Summoned;

	//EquipItem (self, ItMw_2H_Sword_M_01);
	EquipItem (self, ItMw_1h_Misc_Axe);
	//EquipItem (self, ItRw_Sld_Bow); //FIXME Carsten: Bogen schieﬂt beim Skelett in Zeitlupe...
};

//**************
//	Lesser Skeleton    
//**************

INSTANCE Lesser_Skeleton	(Mst_Default_Skeleton)
{
	name							=	"Lesser Skeleton";
	
	level							=	15;

	//----- Attribute ----	
	attribute	[ATR_STRENGTH]		=	65; //+15 Waffe
	attribute	[ATR_DEXTERITY]		=	75;
	attribute	[ATR_HITPOINTS_MAX]	=	150;
	attribute	[ATR_HITPOINTS]		=	150;
	attribute	[ATR_MANA_MAX] 		=	0;
	attribute	[ATR_MANA] 			=	0;

	//----- Protection ----
	protection	[PROT_BLUNT]		=	80;
	protection	[PROT_EDGE]			=	80;
	protection	[PROT_POINT]		=	130; 
	protection	[PROT_FIRE]			=	80;
	protection	[PROT_FLY]			=	80;
	
	fight_tactic	=	FAI_HUMAN_NORMAL;
	
	// ------ visual ------
	//B_SetVisuals_Lesser_Skeleton();
	B_SetVisuals_Warrior_Skeleton();
	
	// ------ Waffe ------
	EquipItem (self, ItMw_1h_MISC_Sword);
};


INSTANCE Summoned_Lesser_Skeleton (Mst_Default_Skeleton)
{
	name							=	"Summoned Lesser Skeleton";
	guild							=	GIL_SUMMONED_SKELETON;
	aivar[AIV_MM_REAL_ID]			= 	ID_SUMMONED_SKELETON;
	level							=	0; //15

	//----- Attribute ----	
	attribute	[ATR_STRENGTH]		=	65; //+15 Waffe
	attribute	[ATR_DEXTERITY]		=	75;
	attribute	[ATR_HITPOINTS_MAX]	=	150;
	attribute	[ATR_HITPOINTS]		=	150;
	attribute	[ATR_MANA_MAX] 		=	0;
	attribute	[ATR_MANA] 			=	0;

	//----- Protection ----
	protection	[PROT_BLUNT]		=	80;
	protection	[PROT_EDGE]			=	80;
	protection	[PROT_POINT]		=	130; 
	protection	[PROT_FIRE]			=	80;
	protection	[PROT_FLY]			=	80;
	
	fight_tactic	=	FAI_HUMAN_NORMAL;
	
	// ------ visual ------
	B_SetVisuals_Lesser_Skeleton();
	
	aivar[AIV_PARTYMEMBER] = TRUE;
	B_SetAttitude (self, ATT_FRIENDLY); 
	
	start_aistate = ZS_MM_Rtn_Summoned;

	EquipItem (self, ItMw_1h_MISC_Sword);
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 	Story Skeletons
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//**************
//	Crypt-Skeletons
//**************

INSTANCE Crypt_Skeleton_Room_01			(Mst_Default_Skeleton)
{
	name							=	"Crypt Guard";

	aivar[AIV_EnemyOverride] = TRUE;

	B_SetVisuals_Skeleton();

	EquipItem (self, ItMw_1h_MISC_Sword);
	CreateInvItem (self, ItKe_EVT_CRYPT_01);
};

INSTANCE Crypt_Skeleton_Room_02			(Mst_Default_Skeleton)
{
	name							=	"Crypt Guard";

	aivar[AIV_EnemyOverride] = TRUE;
	
	B_SetVisuals_Skeleton();

	//EquipItem (self, ItMw_2H_Sword_M_01);
	EquipItem (self, ItMw_1h_Misc_Axe);
	CreateInvItem (self, ItKe_EVT_CRYPT_02);
};

INSTANCE Crypt_Skeleton_Room_03			(Mst_Default_Skeleton)
{
	name							=	"Crypt Guard";

	aivar[AIV_EnemyOverride] = TRUE;
	
	B_SetVisuals_Skeleton();

	EquipItem (self, ItMw_1h_MISC_Sword);
	CreateInvItem (self, ItKe_EVT_CRYPT_03);
};
//****************************
//	Archols-Skeletons auf DI
//****************************

INSTANCE Skeleton_Archol1	(Mst_Default_Skeleton)
{
	aivar[AIV_EnemyOverride] = TRUE;

	B_SetVisuals_Skeleton();

	EquipItem (self, ItMw_1h_MISC_Sword);
};

INSTANCE Skeleton_Archol2	(Mst_Default_Skeleton)
{
	aivar[AIV_EnemyOverride] = TRUE;

	B_SetVisuals_Skeleton();

	//EquipItem (self, ItMw_2H_Sword_M_01);
	EquipItem (self, ItMw_1h_Misc_Axe);
};

INSTANCE Skeleton_Archol3	(Mst_Default_Skeleton)
{
	aivar[AIV_EnemyOverride] = TRUE;

	B_SetVisuals_Skeleton();

	EquipItem (self, ItMw_1h_MISC_Sword);
};

INSTANCE Skeleton_Archol4	(Mst_Default_Skeleton)
{
	aivar[AIV_EnemyOverride] = TRUE;

	B_SetVisuals_Skeleton();

	//EquipItem (self, ItMw_2H_Sword_M_01);
	EquipItem (self, ItMw_1h_Misc_Axe);
};

INSTANCE Skeleton_Archol5	(Mst_Default_Skeleton)
{
	aivar[AIV_EnemyOverride] = TRUE;

	B_SetVisuals_Skeleton();

	EquipItem (self, ItMw_1h_MISC_Sword);
};

INSTANCE Skeleton_Archol6	(Mst_Default_Skeleton)
{
	aivar[AIV_EnemyOverride] = TRUE;

	B_SetVisuals_Skeleton();

	//EquipItem (self, ItMw_2H_Sword_M_01);
	EquipItem (self, ItMw_1h_Misc_Axe);
};
//****************************
//	Marios-Skeletons auf DI
//****************************

INSTANCE Skeleton_Mario1	(Mst_Default_Skeleton)
{
	aivar[AIV_EnemyOverride] = TRUE;

	B_SetVisuals_Skeleton();

	EquipItem (self, ItMw_1h_MISC_Sword);
};

INSTANCE Skeleton_Mario2	(Mst_Default_Skeleton)
{
	aivar[AIV_EnemyOverride] = TRUE;

	B_SetVisuals_Skeleton();

	//EquipItem (self, ItMw_2H_Sword_M_01);
	EquipItem (self, ItMw_1h_Misc_Axe);
};

INSTANCE Skeleton_Mario3	(Mst_Default_Skeleton)
{
	aivar[AIV_EnemyOverride] = TRUE;

	B_SetVisuals_Skeleton();

	EquipItem (self, ItMw_1h_MISC_Sword);
};

INSTANCE Skeleton_Mario4	(Mst_Default_Skeleton)
{
	aivar[AIV_EnemyOverride] = TRUE;

	B_SetVisuals_Skeleton();

	//EquipItem (self, ItMw_2H_Sword_M_01);
	EquipItem (self, ItMw_1h_Misc_Axe);
};

//****************************
//	Xardas servant
//****************************

INSTANCE NONE_102_Xardas_Skeleton (Mst_Default_Skeleton)
{
	// ------ NSC ------
	name 		= "Undead Servant";
	guild 		= GIL_NONE;
	id 			= 102;
	npctype		= NPCTYPE_FRIEND;

	// ------ AIVARs ------
	aivar[AIV_DropDeadAndKill] = TRUE;
	
	// ------ Equippte Waffen ------
	EquipItem (self, ItMw_1H_Mace_L_01);

	// ------ visuals ------
	B_SetVisuals_Lesser_Skeleton();

	// ------ TA anmelden ------
	daily_routine 		= Rtn_Start_102;
};

FUNC VOID Rtn_Start_102 ()
{
	TA_Cook_Stove		(00,00,06,00,"NW_XARDAS_TOWER_IN1_32");
	TA_Stand_Sweeping	(06,00,12,00,"NW_XARDAS_TOWER_IN1_22");
	TA_Stand_Sweeping	(12,00,18,00,"NW_XARDAS_TOWER_IN1_21");
	TA_Stand_Sweeping	(18,00,00,00,"NW_XARDAS_TOWER_IN1_30");
};

FUNC VOID Rtn_Tot_102 ()
{
	TA_SLEEP	(08,00,23,00,"TOT");
	TA_SLEEP	(23,00,08,00,"TOT");
};
