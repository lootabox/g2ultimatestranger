
const int Value_Sc_Acid			= 200;
const int Value_Sc_AdanosBall	= 150;
const int Value_Sc_Explosion	= 200;
const int Value_Sc_Extricate	= 200;
const int Value_Sc_HealOther	= 200;
const int Value_Sc_MagicCage	= 200;
const int Value_Sc_Quake		= 200;
const int Value_Sc_Rage			= 200;

INSTANCE ItSc_Acid (C_Item)
{
    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_Acid;

    visual              =   "ItSc_Acid.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_Acid;
    cond_atr[2]         =   ATR_MANA_MAX;
    cond_value[2]       =   C_GetScrollCost(SPL_Cost_Acid);

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER";

    description         =   NAME_SPL_Acid;

    TEXT    [0]         =   Name_MageScroll ;

    TEXT    [1]         =   NAME_Mana_needed;
    COUNT   [1]         =   C_GetScrollCost(SPL_Cost_Acid);

    TEXT    [2]         =   NAME_Dam_Magic; // Die +5 kommen vom SFX, der ausspielt
    COUNT   [2]         =   (SPL_DmgPerSec_Acid * SPL_Time_Acid) + SPL_Damage_Acid + 5;

    TEXT    [3]         =   NAME_Sec_Duration;
    COUNT   [3]         =   SPL_Time_Acid;

    TEXT    [4]         =   NAME_DamagePerSec;
    COUNT   [4]         =   SPL_DmgPerSec_Acid;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

INSTANCE ItSc_AdanosBall (C_Item)
{
    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_AdanosBall;

    visual              =   "ItSc_AdanosBall.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_AdanosBall;
    cond_atr[2]         =   ATR_MANA_MAX;
    cond_value[2]       =   C_GetScrollCost(SPL_Cost_AdanosBall);

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER_BLUE";

    description         =   NAME_SPL_AdanosBall;

    TEXT    [0]         =   Name_MageScroll ;

    TEXT    [1]         =   NAME_Mana_needed;
    COUNT   [1]         =   C_GetScrollCost(SPL_Cost_AdanosBall);
	
	TEXT	[2]			=	NAME_Dam_Magic;
	COUNT	[2]			=	SPL_Damage_AdanosBall;

	TEXT	[3]			=	NAME_Stun_AdanosBall;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

INSTANCE ItSc_Explosion (C_Item)
{
    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_Explosion;

    visual              =   "ItSc_Explosion.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_Explosion;
    cond_atr[2]         =   ATR_MANA_MAX;
    cond_value[2]       =   C_GetScrollCost(SPL_Cost_Explosion);

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER_YELLOW";

    description         =   NAME_SPL_Explosion;

    TEXT    [0]         =   Name_MageScroll ;

    TEXT    [1]         =   NAME_Mana_needed;
    COUNT   [1]         =   C_GetScrollCost(SPL_Cost_Explosion);
	
	TEXT	[2]			=	NAME_Dam_Magic;
	COUNT	[2]			=	SPL_Damage_Explosion;

	TEXT	[3]			=	ConcatStrings(NAME_Dot_Third, NAME_Sec_Duration);
	COUNT	[3]			=	FIRE_SPELL_DOT_VFX_DURATION_MS / 1000;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

INSTANCE ItSc_Extricate (C_Item)
{
    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_Extricate;

    visual              =   "ItSc_Extricate.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_Extricate;
    cond_atr[2]         =   ATR_MANA_MAX;
    cond_value[2]       =   C_GetScrollCost(SPL_Cost_Extricate);

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER";

    description         =   NAME_SPL_Extricate;

    TEXT    [0]         =   Name_MageScroll ;

    TEXT    [1]         =   NAME_Mana_needed;
    COUNT   [1]         =   C_GetScrollCost(SPL_Cost_Extricate);

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

INSTANCE ItSc_HealOther (C_Item)
{
    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_HealOther;

    visual              =   "ItSc_HealOther.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_HealOther;
    cond_atr[2]         =   ATR_MANA_MAX;
    cond_value[2]       =   C_GetScrollCost(SPL_Cost_HealOther);

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER";

    description         =   NAME_SPL_HealOther;

    TEXT    [0]         =   Name_MageScroll ;

    TEXT    [1]         =   NAME_Mana_needed;
    COUNT   [1]         =   C_GetScrollCost(SPL_Cost_HealOther);
	
	TEXT	[2]			=	NAME_HealingPerCast;
	COUNT	[2]			=	SPL_Heal_HealOther;

    TEXT    [3]         =   ConcatStrings(NAME_ShortRange, NAME_Instant);

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

INSTANCE ItSc_MagicCage (C_Item)
{
    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_MagicCage;

    visual              =   "ItSc_MagicCage.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_MagicCage;
    cond_atr[2]         =   ATR_MANA_MAX;
    cond_value[2]       =   C_GetScrollCost(SPL_Cost_MagicCage);

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER";

    description         =   NAME_SPL_MagicCage;

    TEXT    [0]         =   Name_MageScroll ;

    TEXT    [1]         =   NAME_Mana_needed;
    COUNT   [1]         =   C_GetScrollCost(SPL_Cost_MagicCage);

    TEXT    [3]         =   NAME_Sec_Duration;
    COUNT   [3]         =   SPL_Time_MagicCage;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

INSTANCE ItSc_Quake (C_Item)
{
    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_Quake;

    visual              =   "ItSc_Quake.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_Quake;
    cond_atr[2]         =   ATR_MANA_MAX;
    cond_value[2]       =   C_GetScrollCost(SPL_Cost_Quake);

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER";

    description         =   NAME_SPL_Quake;

    TEXT    [0]         =   Name_MageScroll ;

    TEXT    [1]         =   NAME_Mana_needed;
    COUNT   [1]         =   C_GetScrollCost(SPL_Cost_Quake);
	
	TEXT	[2]			=	NAME_Dam_Magic;
	COUNT	[2]			=	SPL_Damage_Quake;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

INSTANCE ItSc_Rage (C_Item)
{
    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_Rage;

    visual              =   "ItSc_Rage.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_Rage;
    cond_atr[2]         =   ATR_MANA_MAX;
    cond_value[2]       =   C_GetScrollCost(SPL_Cost_Rage);

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER_RED";

    description         =   NAME_SPL_Rage;

    TEXT    [0]         =   Name_MageScroll ;

    TEXT    [1]         =   NAME_Mana_needed;
    COUNT   [1]         =   C_GetScrollCost(SPL_Cost_Rage);

    TEXT    [2]         =   NAME_Rage;

    TEXT    [3]         =   ConcatStrings(NAME_ShortRange, NAME_Instant);

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

/*******************************************************************************************/
INSTANCE ItSc_Teleport_Maya (C_Item)
{
	name 				=	NAME_Spruchrolle;

	mainflag 			=	ITEM_KAT_RUNE;
	flags 				=	ITEM_MULTI | ITEM_MISSION;

	value 				=	50;

	visual				=	"ItSc_Teleport_Maya.3DS";
	material			=	MAT_LEATHER;

	spell				= 	SPL_Teleport_Maya;
	cond_atr[2]   		=	ATR_MANA_MAX;
	cond_value[2]  		=	C_GetScrollCost(SPL_COST_TELEPORT);

	wear				= 	WEAR_EFFECT;
	effect				=	"SPELLFX_WEAKGLIMMER";

	description			=  NAME_SPL_Teleport_Maya;
	
	TEXT	[0]			=	Name_MageScroll	;

	TEXT	[1]			=	NAME_Mana_needed;
	COUNT	[1]			=	C_GetScrollCost(SPL_COST_TELEPORT);
	
	TEXT	[5]			=	NAME_Value;
	COUNT	[5]			=	value;
};
/*******************************************************************************************/