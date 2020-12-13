
// *****************************************************
INSTANCE ItMw_1h_Broadsword (C_Item)
{	
	name 				=	"Broadsword";

	mainflag 			=	ITEM_KAT_NF;
	flags 				=	ITEM_SWD;	
	material 			=	MAT_METAL;

	value 				=	Value_Broadsword;

	damageTotal  		= 	Damage_Broadsword;
	damagetype 			=	DAM_EDGE;
	range    			=  	RANGE_Broadsword;		

	cond_atr[2]   		=	ATR_STRENGTH;
	cond_value[2]  		=	Condition_Broadsword;
	visual 				=	"ItMw_030_1h_Common_Sword_01.3DS";

	description			= name;
	TEXT[1]				= NAME_Dam_Edge;				COUNT[1]	= damageTotal;
	TEXT[2] 			= NAME_Str_needed;				COUNT[2]	= cond_value[2];
	TEXT[3]				= NAME_Reach;					COUNT[3]	= range*100/253;
	TEXT[4] 			= NAME_OneHanded;
	TEXT[5]				= NAME_Value;					COUNT[5]	= value;
};
// *****************************************************
INSTANCE ItMw_1h_FineBroadsword (C_Item)
{	
	name 				=	"Fine Broadsword";

	mainflag 			=	ITEM_KAT_NF;
	flags 				=	ITEM_SWD;	
	material 			=	MAT_METAL;

	value 				=	Value_FineBroadsword;

	damageTotal			= 	Damage_FineBroadsword;
	damagetype			=	DAM_EDGE;
	range    			=  	Range_FineBroadsword;	
	
	on_equip			=	Equip_1H_10;
	on_unequip			=	UnEquip_1H_10;
		
	cond_atr[2]   		= 	ATR_STRENGTH;
	cond_value[2]  		= 	Condition_FineBroadsword;
	visual 				=	"ItMw_060_1h_Sword_smith_03.3DS";

	description			= name;
	
	TEXT[1]				= NAME_Dam_Edge;				COUNT[1]	= damageTotal;
	TEXT[2] 			= NAME_Str_needed;				COUNT[2]	= cond_value[2];
	TEXT[3]				= NAME_Reach;					COUNT[3]	= range*100/253;
	TEXT[4]				= NAME_ADDON_BONUS_1H;			COUNT[4]	= Waffenbonus_10;
	TEXT[5]				= NAME_Value;					COUNT[5]	= value;
};
// *****************************************************
INSTANCE ItMw_2H_OrcMace_01 (C_Item)
{	
	name 				=	"Krush Karrok";

	mainflag 			=	ITEM_KAT_NF;
	flags 				=	ITEM_2HD_AXE;	
	material 			=	MAT_WOOD;

	value 				=	Value_Orkmace_01;

	damageTotal			= 	Damage_Orkmace_01;
	damagetype			=	DAM_BLUNT;
	range    			=  	Range_Orkmace_01;		

	cond_atr[2]   		=   ATR_STRENGTH;
	cond_value[2]  		=   Condition_Orkmace_01;
	visual 				=	"ItMw_2H_OrcMace_01.3DS";

	description			= name;
	TEXT[1]				= NAME_Dam_Blunt;				COUNT[1]	= damageTotal;
	TEXT[2] 			= NAME_Str_needed;				COUNT[2]	= cond_value[2];
	TEXT[3]				= NAME_Reach;					COUNT[3]	= range*100/253;
	TEXT[4] 			= NAME_TwoHanded;
	TEXT[5]				= NAME_Value;					COUNT[5]	= value;
};
// *****************************************************
