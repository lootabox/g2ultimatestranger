//****************************
//	Firedragon Prototype		
//****************************

PROTOTYPE Mst_Default_Dragon_Fire(C_Npc)			
{
	name							= "Fire Dragon";
	guild							= GIL_DRAGON;
	aivar[AIV_MM_REAL_ID]			= ID_DRAGON_FIRE;
	level							= 450;
	
	bodyStateInterruptableOverride = TRUE;
	
	//----- Attribute ----	
	attribute	[ATR_STRENGTH]		=	140;
	attribute	[ATR_DEXTERITY]		=	140; //100
	attribute	[ATR_HITPOINTS_MAX]	=	700;
	attribute	[ATR_HITPOINTS]		=	700;
	attribute	[ATR_MANA_MAX] 		=	1000;
	attribute	[ATR_MANA] 			=	1000;
	
	//------ Protections ----	
	protection	[PROT_BLUNT]		=	100;
	protection	[PROT_EDGE]			=	100;
	protection	[PROT_POINT]		=	100;
	protection	[PROT_FIRE]			=	50;
	protection	[PROT_FLY]			=	IMMUNE;
	protection	[PROT_MAGIC]		=	100; //50
	
	//------ Damage Types ----	
	damagetype 						=	DAM_EDGE|DAM_FLY; //DAM_FIRE is handled by damage script to bypass engine burn effect
//	damage		[DAM_INDEX_BLUNT]	=	0;
//	damage		[DAM_INDEX_EDGE]	=	0;
//	damage		[DAM_INDEX_POINT]	=	0;
	damage		[DAM_INDEX_FIRE]	=	attribute[ATR_STRENGTH];
//	damage		[DAM_INDEX_FLY]		=	1; //Opfer fliegt f�r Fire+Fly
//	damage		[DAM_INDEX_MAGIC]	=	0;

	//----- Kampf-Taktik ----	
	fight_tactic	=	FAI_DRAGON;
	
	//----- Sense & Ranges ----	
	senses			=	SENSE_HEAR | SENSE_SEE | SENSE_SMELL;
	senses_range	=	PERC_DIST_DRAGON_ACTIVE_MAX;

	aivar[AIV_MM_FollowTime]	= FOLLOWTIME_MEDIUM;
	aivar[AIV_MM_FollowInWater] = FALSE;

	//aivar[AIV_MaxDistToWp]		= 700;
	aivar[AIV_OriginalFightTactic] 	= FAI_DRAGON;
	
	//----- Daily Routine ----
	start_aistate				= ZS_MM_Rtn_DragonRest;

	aivar[AIV_MM_RestStart] 	= OnlyRoutine;
};


//******************
//	Visuals
//******************

func void B_SetVisuals_Dragon_Fire()
{
	Mdl_SetVisual			(self,	"Dragon.mds");
	//								Body-Mesh				Body-Tex	Skin-Color	Head-MMS	Head-Tex	Teeth-Tex	ARMOR
	Mdl_SetVisualBody		(self,	"Dragon_FIRE_Body",		DEFAULT,	DEFAULT,	"",			DEFAULT,  	DEFAULT,	-1);
};

//*****************
//	Firedragon
//*****************

INSTANCE Dragon_Fire	(Mst_Default_Dragon_Fire)
{
	name				=	"Feomathar";
	flags				= 	NPC_FLAG_IMMORTAL;
	B_SetVisuals_Dragon_Fire();
	Npc_SetToFistMode(self);
};

//**************************
//	Firedragon Dragonisland
//*************************

INSTANCE Dragon_Fire_Island	(Mst_Default_Dragon_Fire)
{
	name				=	"Feodaron";
	flags				= 	NPC_FLAG_IMMORTAL;
	B_SetVisuals_Dragon_Fire();
	Npc_SetToFistMode(self);
};
