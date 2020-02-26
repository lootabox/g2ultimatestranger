
const int Value_Ru_Acid			= 1500;
const int Value_Ru_AdanosBall	= 1500;
const int Value_Ru_Explosion	= 1500;
const int Value_Ru_Extricate	= 1500;
const int Value_Ru_HealOther	= 1500;
const int Value_Ru_MagicCage	= 1500;
const int Value_Ru_Quake		= 1500;
const int Value_Ru_Rage			= 1500;

INSTANCE ItRu_Acid (C_Item)
{
    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    value               =   Value_Ru_Acid;

    visual              =   "ItRu_Acid.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_Acid;
    mag_circle          =   3;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER";

    description         =   NAME_SPL_Acid;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Manakosten;
    COUNT   [1]         =   SPL_Cost_Acid;

    TEXT    [2]         =   NAME_Dam_Magic; // Die +5 kommen vom SFX, der ausspielt
    COUNT   [2]         =   (SPL_DmgPerSec_Acid * SPL_Time_Acid) + SPL_Damage_Acid + 5;

    TEXT    [3]         =   NAME_Sec_Duration;
    COUNT   [3]         =   SPL_Time_Acid;

    TEXT    [4]         =   NAME_DamagePerSec;
    COUNT   [4]         =   SPL_DmgPerSec_Acid;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

INSTANCE ItRu_AdanosBall (C_Item)
{
    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    value               =   Value_Ru_AdanosBall;

    visual              =   "ItRu_AdanosBall.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_AdanosBall;
    mag_circle          =   3;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER_BLUE";

    description         =   NAME_SPL_AdanosBall;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Manakosten;
    COUNT   [1]         =   SPL_Cost_AdanosBall;
	
	TEXT	[2]			=	NAME_Dam_Magic;
	COUNT	[2]			=	SPL_Damage_AdanosBall;

	TEXT	[3]			=	NAME_Stun_AdanosBall;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

INSTANCE ItRu_Explosion (C_Item)
{
    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    value               =   Value_Ru_Explosion;

    visual              =   "ItRu_Explosion.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_Explosion;
    mag_circle          =   3;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER_YELLOW";

    description         =   NAME_SPL_Explosion;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Manakosten;
    COUNT   [1]         =   SPL_Cost_Explosion;
	
	TEXT	[2]			=	NAME_Dam_Magic;
	COUNT	[2]			=	SPL_Damage_Explosion;

	TEXT	[3]			=	ConcatStrings(NAME_Dot_Half, NAME_Sec_Duration);
	COUNT	[3]			=	BURN_DOT_VFX_DURATION_SEC;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

INSTANCE ItRu_Extricate (C_Item)
{
    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    value               =   Value_Ru_Extricate;

    visual              =   "ItRu_Extricate.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_Extricate;
    mag_circle          =   3;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER";

    description         =   NAME_SPL_Extricate;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Manakosten;
    COUNT   [1]         =   SPL_Cost_Extricate;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

INSTANCE ItRu_HealOther (C_Item)
{
    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    value               =   Value_Ru_HealOther;

    visual              =   "ItRu_HealOther.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_HealOther;
    mag_circle          =   3;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER";

    description         =   NAME_SPL_HealOther;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Manakosten;
    COUNT   [1]         =   SPL_Cost_HealOther;
	
	TEXT	[2]			=	NAME_HealingPerCast;
	COUNT	[2]			=	SPL_Heal_HealOther;

    TEXT    [3]         =   ConcatStrings(NAME_ShortRange, NAME_Instant);

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

INSTANCE ItRu_MagicCage (C_Item)
{
    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    value               =   Value_Ru_MagicCage;

    visual              =   "ItRu_MagicCage.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_MagicCage;
    mag_circle          =   3;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER";

    description         =   NAME_SPL_MagicCage;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Manakosten;
    COUNT   [1]         =   SPL_Cost_MagicCage;

    TEXT    [3]         =   NAME_Sec_Duration;
    COUNT   [3]         =   SPL_Time_MagicCage;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

INSTANCE ItRu_Quake (C_Item)
{
    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    value               =   Value_Ru_Quake;

    visual              =   "ItRu_Quake.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_Quake;
    mag_circle          =   3;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER";

    description         =   NAME_SPL_Quake;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Manakosten;
    COUNT   [1]         =   SPL_Cost_Quake;
	
	TEXT	[2]			=	NAME_Dam_Magic;
	COUNT	[2]			=	SPL_Damage_Quake;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

INSTANCE ItRu_Rage (C_Item)
{
    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    value               =   Value_Ru_Rage;

    visual              =   "ItRu_Rage.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_Rage;
    mag_circle          =   3;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER_RED";

    description         =   NAME_SPL_Rage;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Manakosten;
    COUNT   [1]         =   SPL_Cost_Rage;

    TEXT    [2]         =   NAME_Rage;

    TEXT    [3]         =   ConcatStrings(NAME_ShortRange, NAME_Instant);

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};
