//Amulette//

// Schutzamulette
 
const int Value_Am_ProtFire 		= 600;	const int Am_ProtFire		= 10;
const int Value_Am_ProtEdge 		= 800;	const int Am_ProtEdge		= 10;
const int Value_Am_ProtMage 		= 700;	const int Am_ProtMage		= 10;
const int Value_Am_ProtPoint 		= 500;	const int Am_ProtPoint		= 10;

const int Value_Am_ProtTotal 		= 1000;	const int Am_TProtFire		= 8; // Schutzamulett Total
											const int AM_TProtEdge		= 8;
											const int Am_TProtMage		= 8;
											const int Am_TProtPoint		= 8;
// Andere Amulette

const int Value_Am_Dex 				= 1000;	const int Am_Dex			= 10;
const int Value_Am_Mana 			= 1000;	const int Am_Mana			= 10; //ITAM_HP
const int Value_Am_Strg 			= 1000;	const int Am_Strg			= 10;
const int Value_Am_Hp 				= 400;	const int Am_Hp				= 40;

const int Value_Am_HpMana 			= 1300;	const int Am_HpMana_Hp		= 30; // Mana + Hp Amulett
											const int Am_HpMana_Mana	= 10;

const int Value_Am_DexStrg 			= 1600;	const int Am_DexStrg_Dex	= 8; // Strg + Dex Amulett
											const int Am_DexStrg_Strg	= 8;
/******************************************************************************************/
INSTANCE  ItAm_Prot_Fire_01(ItAm_Prototype)
{
	value 			=	Value_Am_ProtFire;

	visual 			=	"ItAm_Prot_Fire_01.3ds";

	on_equip		=	Equip_ItAm_Prot_Fire_01;
	on_unequip		=	UnEquip_ItAm_Prot_Fire_01;

	description		= "Amulet of Fire";
	
	TEXT[2]			= NAME_Prot_Fire;
	COUNT[2]		= Am_ProtFire;
	TEXT[5]			= NAME_Value;
	COUNT[5]		= value;
};

	FUNC VOID Equip_ItAm_Prot_Fire_01()
	{
	 	self.protection [PROT_FIRE] += Am_ProtFire;
	};

	FUNC VOID UnEquip_ItAm_Prot_Fire_01()
	{
		self.protection [PROT_FIRE] -= Am_ProtFire;
	};

/******************************************************************************************/
	INSTANCE  ItAm_Prot_Edge_01(ItAm_Prototype) // Waffen Schutz Amulett
{
	value 			=	Value_Am_ProtEdge;

	visual 			=	"ItAm_Prot_Edge_01.3ds";

	on_equip		=	Equip_ItAm_Prot_Edge_01;
	on_unequip		=	UnEquip_ItAm_Prot_Edge_01;

	description		= "Harness Amulet";
	
	TEXT[2]			= NAME_Prot_Edge;
	COUNT[2]		= Am_ProtEdge;
	
	TEXT[5]			= NAME_Value;
	COUNT[5]		= value;
};

	FUNC VOID Equip_ItAm_Prot_Edge_01()
	{
		self.protection [PROT_EDGE] += Am_ProtEdge;
		self.protection [PROT_BLUNT] += Am_ProtEdge;
	};

	FUNC VOID UnEquip_ItAm_Prot_Edge_01()
	{
		self.protection [PROT_EDGE] -= Am_ProtEdge;
		self.protection [PROT_BLUNT] -= Am_ProtEdge;
	};

/******************************************************************************************/
	INSTANCE  ItAm_Prot_Point_01(ItAm_Prototype) // Geschoss Schutz Amulett 
{
	value 			=	Value_Am_ProtPoint;

	visual 			=	"ItAm_Prot_Point_01.3ds";

	on_equip		=	Equip_ItAm_Prot_Point_01;
	on_unequip		=	UnEquip_ItAm_Prot_Point_01;

	description		= "Amulet of Oak Skin";
	
	TEXT[2]			= NAME_Prot_Point;
	COUNT[2]		= Am_ProtPoint;
	
	TEXT[5]			= NAME_Value;
	COUNT[5]		= value;
};

	FUNC VOID Equip_ItAm_Prot_Point_01()
	{
		self.protection [PROT_POINT] += Am_ProtPoint;
	};

	FUNC VOID UnEquip_ItAm_Prot_Point_01()
	{
		self.protection [PROT_POINT] -= Am_ProtPoint;
	};

/******************************************************************************************/
	INSTANCE  ItAm_Prot_Mage_01(ItAm_Prototype) // Magie Schutz Amulett von Serpentes an KDF f�r alle Minenanteile (Mission -> MIS_Serpentes_MinenAnteil_KDF == LOG_SUCCESS)
{
	value 			=	Value_Am_ProtMage;

	visual 			=	"ItAm_Prot_Mage_01.3ds";

	on_equip		=	Equip_ItAm_Prot_Mage_01;
	on_unequip		=	UnEquip_ItAm_Prot_Mage_01;

	description		= "Amulet of Spiritual Power";
	
	TEXT[2]			= NAME_Prot_Magic;
	COUNT[2]		= Am_ProtMage;
	
	TEXT[5]			= NAME_Value;
	COUNT[5]		= value;
};

	FUNC VOID Equip_ItAm_Prot_Mage_01()
	{
		self.protection [PROT_MAGIC] += Am_ProtMage;
	};

	FUNC VOID UnEquip_ItAm_Prot_Mage_01()
	{
		self.protection [PROT_MAGIC] -= Am_ProtMage;
	};

/******************************************************************************************/

	INSTANCE  ItAm_Prot_Total_01(ItAm_Prototype)//ItAm_AmulettOfDeath_Mis (alle + 30)  MAGIER_EXKLUSIV_AMULETT f�r den Endkampf des KDFs  (Kapitel 5)

{
	value 			=	Value_Am_ProtTotal;

	visual 			=	"ItAm_Prot_Total_01.3ds";

	on_equip		=	Equip_Value_Am_ProtTotal;
	on_unequip		=	UnEquip_Value_Am_ProtTotal;

	description		= "Amulet of Ore Skin";
	
	TEXT[1]			= NAME_Prot_Edge;
	COUNT[1]		= AM_TProtEdge;
	TEXT[2] 		= NAME_Prot_Point;
	COUNT[2]		= AM_TProtPoint;
	TEXT[3]			= NAME_Prot_Fire;
	COUNT[3]		= AM_TProtFire;
	TEXT[4]			= NAME_Prot_Magic;
	COUNT[4]		= AM_TProtMage;
	TEXT[5]			= NAME_Value;
	COUNT[5]		= value;
};

	FUNC VOID Equip_Value_Am_ProtTotal()
	{
		self.protection [PROT_EDGE]   += AM_TProtEdge;
		self.protection [PROT_BLUNT]  += AM_TProtEdge;
		self.protection [PROT_POINT]  += AM_TProtPoint;
		self.protection [PROT_FIRE]   += AM_TProtFire;
		self.protection [PROT_MAGIC]  += AM_TProtMage;

	};

	FUNC VOID UnEquip_Value_Am_ProtTotal()
	{
		self.protection [PROT_EDGE]   -=  AM_TProtEdge;
		self.protection [PROT_BLUNT]  -=  AM_TProtEdge;
		self.protection [PROT_POINT]  -=  AM_TProtPoint;
		self.protection [PROT_FIRE]   -=  AM_TProtFire;
		self.protection [PROT_MAGIC]  -=  AM_TProtMage;
	};

/******************************************************************************************/
	INSTANCE  ItAm_Dex_01(ItAm_Prototype)	//Joly: von Dar an KDF und DJG vergeben ab Kapitel 4 \ Xardas_Secret-area f�r PAL	(Kapitel 3)
{
	value 			=	Value_Am_Dex;

	visual 			=	"ItAm_Dex_01.3ds";

	on_equip		=	Equip_ItAm_Dex_01;
	on_unequip		=	UnEquip_ItAm_Dex_01;

	description		= "Amulet of Agility";
	
	TEXT[2]			= NAME_Bonus_Dex;
	COUNT[2]		= Am_Dex;
	
	TEXT[5]			= NAME_Value;
	COUNT[5]		= value;
};

	FUNC VOID Equip_ItAm_Dex_01()
	{
		Npc_ChangeAttribute(self,ATR_DEXTERITY,+ Am_Dex);
	};

	FUNC VOID UnEquip_ItAm_Dex_01()
	{
		Npc_ChangeAttribute(self,ATR_DEXTERITY,- Am_Dex);
	};

/******************************************************************************************/

	INSTANCE  ItAm_Strg_01(ItAm_Prototype) //in LOCkpick Truhe Fingers
{
	value 			=	Value_Am_Strg;

	visual 			=	"ItAm_Strg_01.3ds";

	on_equip		=	Equip_ItAm_Strg_01;
	on_unequip		=	UnEquip_ItAm_Strg_01;

	description		= "Amulet of Strength";
	
	TEXT[2]			= NAME_Bonus_Str;
	COUNT[2]		= Am_Strg;
	
	TEXT[5]			= NAME_Value;
	COUNT[5]		= value;
};

	FUNC VOID Equip_ItAm_Strg_01()
	{
		Npc_ChangeAttribute(self,ATR_STRENGTH,+ Am_Strg);
	};

	FUNC VOID UnEquip_ItAm_Strg_01()
	{
		Npc_ChangeAttribute(self,ATR_STRENGTH,- Am_Strg);
	};

/******************************************************************************************/

	INSTANCE  ItAm_Hp_01(ItAm_Prototype)  //von Bennet dem Schmied an den PAL und dem KDF        (Kapitel 3)\Xardas_Secret-area f�r DJG	(Kapitel 3)
{
	value 			=	Value_Am_Hp;

	visual 			=	"ItAm_Hp_01.3ds";

	on_equip		=	Equip_ItAm_Hp_01;
	on_unequip		=	UnEquip_ItAm_Hp_01;

	description		= "Amulet of Life";

	TEXT[2]			= NAME_Bonus_HP;
	COUNT[2]		= Am_Hp;
	
	TEXT[5]			= NAME_Value;
	COUNT[5]		= value;
};

	FUNC VOID Equip_ItAm_Hp_01()
	{
		self.attribute[ATR_HITPOINTS_MAX] = self.attribute[ATR_HITPOINTS_MAX] + Am_Hp;
	};

	FUNC VOID UnEquip_ItAm_Hp_01()
	{
		self.attribute [ATR_HITPOINTS_MAX] = self.attribute [ATR_HITPOINTS_MAX] -Am_Hp;
	};

/******************************************************************************************/
	INSTANCE  ItAm_Mana_01(ItAm_Prototype) //in der OW von Angar an alle SC Gilden!  (Kapitel 4)
{
	value 			=	Value_Am_Mana;

	visual 			=	"ItAm_Mana_01.3ds";

	on_equip		=	Equip_ItAm_Mana_01;
	on_unequip		=	UnEquip_ItAm_Mana_01;

	description		= "Amulet of Magic";
	
	TEXT[2]			= NAME_Bonus_Mana;
	COUNT[2]		= Am_Mana;
	
	TEXT[5]			= NAME_Value;
	COUNT[5]		= value;
};

	FUNC VOID Equip_ItAm_Mana_01()
	{
		self.attribute[ATR_MANA_MAX] = self.attribute[ATR_MANA_MAX] + Am_Mana;
	};

	FUNC VOID UnEquip_ItAm_Mana_01 ()
	{
		self.attribute[ATR_MANA_MAX] = self.attribute[ATR_MANA_MAX] - Am_Mana;
	};

/******************************************************************************************/
	INSTANCE  ItAm_Dex_Strg_01(ItAm_Prototype)	// wird dem PAL von Ulthar �berreicht f�r die Reinigung der Schreine Kapitel 3\
{
	value 			=	Value_Am_DexStrg;

	visual 			=	"ItAm_Dex_Strg_01.3ds";

	on_equip		=	Equip_ItAm_Dex_Strg_01;
	on_unequip		=	UnEquip_ItAm_Dex_Strg_01;

	description		= "Amulet of Power";
	
	TEXT[2] 		= NAME_Bonus_Str;
	COUNT[2]		= Am_DexStrg_Strg;
	TEXT[3]			= NAME_Bonus_Dex;
	COUNT[3]		= Am_DexStrg_Dex;
	
	TEXT[5]			= NAME_Value;
	COUNT[5]		= value;
};

	FUNC VOID Equip_ItAm_Dex_Strg_01()
	{
		Npc_ChangeAttribute(self,ATR_DEXTERITY,+ Am_DexStrg_Dex );
		Npc_ChangeAttribute(self,ATR_STRENGTH,+ Am_DexStrg_Strg );
	};

	FUNC VOID UnEquip_ItAm_Dex_Strg_01 ()
	{
		Npc_ChangeAttribute(self,ATR_DEXTERITY,-Am_DexStrg_Dex );
		Npc_ChangeAttribute(self,ATR_STRENGTH,-Am_DexStrg_Strg );
	};

/******************************************************************************************/
	INSTANCE  ItAm_Hp_Mana_01 (ItAm_Prototype)	//Xardas_Secret-area f�r KDF	(Kapitel 3)
{
	value 			=	Value_Am_HpMana;

	visual 			=	"ItAm_Hp_Mana_01.3ds";

	on_equip		=	Equip_ItAm_Hp_Mana_01 ;
	on_unequip		=	UnEquip_ItAm_Hp_Mana_01 ;

	description		= "Amulet of Enlightenment";
	
	TEXT[2] 		= NAME_Bonus_Mana;
	COUNT[2]		= Am_HpMana_Mana;
	
	TEXT[3]			= NAME_Bonus_HP;
	COUNT[3]		= Am_HpMana_Hp;
	
	TEXT[5]			= NAME_Value;
	COUNT[5]		= value;
};

	FUNC VOID Equip_ItAm_Hp_Mana_01 ()
	{
		self.attribute[ATR_HITPOINTS_MAX] = self.attribute[ATR_HITPOINTS_MAX] + Am_HpMana_Hp;
		self.attribute[ATR_MANA_MAX] = self.attribute[ATR_MANA_MAX] + Am_HpMana_Mana;
	};

	FUNC VOID UnEquip_ItAm_Hp_Mana_01 ()
	{
		self.attribute[ATR_MANA_MAX] = self.attribute[ATR_MANA_MAX] - Am_HpMana_Mana;
		self.attribute[ATR_HITPOINTS_MAX] = self.attribute[ATR_HITPOINTS_MAX] - Am_HpMana_Hp;
	};

/******************************************************************************************/
