
const int Value_Ri_Xardas 		= 500;
const int Value_Ri_Fernando 	= 500;

/******************************************************************************************/
instance ItRi_Xardas(C_Item)
{
	name 					=	NAME_Ring;

	mainflag 				=	ITEM_KAT_MAGIC;
	flags 					=	ITEM_RING;

	value 					=	Value_Ri_Xardas;

	visual 					=	"ItRi_Xardas.3ds";

	visual_skin 			=	0;
	material 				=	MAT_METAL;
	on_equip				=	Equip_ItRi_Xardas;
	on_unequip				=	UnEquip_ItRi_Xardas;

	wear			= 	WEAR_EFFECT;
	effect			=	"SPELLFX_ITEMGLIMMER"; 

	description				= "Xardas' ???";
	
	TEXT[5]					= NAME_Value;
	COUNT[5]				= value;
	
	INV_ZBIAS				= INVCAM_ENTF_RING_STANDARD;
	INV_ROTZ				= INVCAM_Z_RING_STANDARD;
	INV_ROTX				= INVCAM_X_RING_STANDARD;
};

	FUNC VOID Equip_ItRi_Xardas()
	{
		//
	};

	FUNC VOID UnEquip_ItRi_Xardas()
	{
		//
	};

/******************************************************************************************/
instance ItRi_Fernando(C_Item)
{
	name 					=	NAME_Ring;

	mainflag 				=	ITEM_KAT_MAGIC;
	flags 					=	ITEM_RING;

	value 					=	Value_Ri_Fernando;

	visual 					=	"ItRi_Fernando.3ds";

	visual_skin 			=	0;
	material 				=	MAT_METAL;
	on_equip				=	Equip_ItRi_Fernando;
	on_unequip				=	UnEquip_ItRi_Fernando;

	wear			= 	WEAR_EFFECT;
	effect			=	"SPELLFX_ITEMGLIMMER"; 

	description				= "Fernando's ???";
	
	TEXT[5]					= NAME_Value;
	COUNT[5]				= value;
	
	INV_ZBIAS				= INVCAM_ENTF_RING_STANDARD;
	INV_ROTZ				= INVCAM_Z_RING_STANDARD;
	INV_ROTX				= INVCAM_X_RING_STANDARD;
};

	FUNC VOID Equip_ItRi_Fernando()
	{
		//
	};

	FUNC VOID UnEquip_ItRi_Fernando()
	{
		//
	};

