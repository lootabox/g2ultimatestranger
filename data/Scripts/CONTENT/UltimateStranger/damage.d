// https://forum.worldofplayers.de/forum/threads/1149697-Script-Eigene-Schadensberechnung

class oSDamageDescriptor {
	var int validFields; 		// zDWORD 0x00
	
	var int attackerVob; 		// zCVob* 0x04
	var int attackerNpc; 		// oCNpc* 0x08
	var int hitVob; 			// zCVob* 0x0C
	var int hitPfx;				// oCVisualFX* 0x10
	var int itemWeapon; 		// oCItem* 0x14
		
	var int spellID;			// zDWORD 0x18
	var int spellCat; 			// zDWORD 0x1C
	var int spellLevel;			// zDWORD 0x20
	
	var int dmgMode;			// zDWORD 0x24
	var int weaponMode;			// zDWORD 0x28
	
	var int dmgArray[8];	 	// zDWORD[8] 0x2C Presumably before deduction of armor 
	var int dmgTotal;			// zREAL 0x4C // After deducting armor values? 
	var int dmgMultiplier;		// zREAL 0x50
	
	var int locationHit[3]; 	// zVEC3 0x54
	var int directionFly[3];	// zVEC3 0x58
	
	var string visualFXStr;		// zSTRING 0x5C
	
	var int duration;			// zREAL 0x60
	var int interval; 			// zREAL 0x64
	var int dmgPerInterval;		// zREAL 0x68
	var int dmgDontKill;		// zBOOL 0x6C
	
	var int bitfield; // 1 -> Once, 2 -> finished, 4 -> isDead, 8 -> isUnconscious
	
	var int azimuth;			// zREAL 0x74
	var int elevation;			// zREAL 0x78
	var int timeCurrent;		// zREAL 0x7C
	var int dmgReal;			// zREAL 0x80
	var int dmgEffective;		// zREAL 0x84
	var int dmgArrayEffective[8]; // zDWORD[8] 0x104 // Probably after deduction of armor 
	var int vobParticleFX;		// zCVob* 0x108
	var int particleFX;			// zCParticleFX* 0x10C
	var int visualFX;			// zCVisualFX* 0x110
};

/*
WD = Weapon Damage
STR = Strength
AP = Armor Protection of the enemy

		GOTHIC 1
Damage:
Melee		WD   + STR - AP
Melee Crit	WDx2 + STR - AP
Range		WD         - AP
Range Crit	WDx2       - AP (dex only influenced range)

Chance for a Critical Hit:
1H: lvl1: 5% for the ctitical hit, cost 10 LPs, lvl2: 10% cost 20 more LPs
2H: lvl1: 5%/30LP, lvl2: 10%/40LP
Bow: lvl1: 15%/10LP, lvl2: 30%/20LP
X-Bow: lvl1: 20%/10LP, lvl2: 40%/20LP

		GOTHIC 2
Melee		(WD + STR - AP - 1) / 10		>= 5
Melee Crit	 WD + STR - AP					>= 5
Range		 WD + DEX - AP

		ULTIMATE STRANGER
Melee		WD   + STR - AP				>= 5 (npc only)
Melee Crit	WDx2 + STR - AP				>= 5 (npc only)
Range		WD   + DEX - AP
*/

func int Handle_Weapon_Dmg(var c_npc att, var c_npc vic)
{
	// If melee weapon is readied use that, otherwise use equipped ranged weapon
	var c_item wpn;
	if (Npc_HasReadiedMeleeWeapon(att)) { wpn = Npc_GetEquippedMeleeWeapon(att); }
	else { wpn = Npc_GetEquippedRangedWeapon(att); };
	
	// Get base weapon damage
	var int dmg; dmg = wpn.damageTotal;
	
	// Check for weapon specials
	/* if ( 		wpn.weight == Value_Orkschlaechter_Weapon_ID && (vic.guild == GIL_ORC || vic.guild == GIL_UNDEADORC) ) {
		dmg += Value_Orkschlaechter_BonusDmg;
	} else if ( wpn.weight == Value_Blessed_2_Weapon_ID && C_NpcIsUndead(vic) ) {
		dmg += Value_Blessed_BonusDmg_2;
	} else if ( wpn.weight == Value_Blessed_3_Weapon_ID && C_NpcIsUndead(vic) ) {
		dmg += Value_Blessed_BonusDmg_3;
	} else if ( wpn.weight == Value_Special_4_Weapon_ID && (vic.guild == GIL_DRAGON || vic.guild == GIL_DRACONIAN) ) {
		dmg += Value_Special_4_BonusDmg;
	} else if ( wpn.weight == Value_ManaSword_1h_Weapon_ID ) {
		dmg += (att.attribute[ATR_MANA] * Value_ManaSword_1h_Percentage / 100);
	} else if ( wpn.weight == Value_ManaSword_2h_Weapon_ID ) {
		dmg += (att.attribute[ATR_MANA] * Value_ManaSword_2h_Percentage / 100);
	} else if ( wpn.weight == Value_WolfSword_Weapon_ID && (vic.guild == GIL_WOLF || vic.guild == GIL_SUMMONED_WOLF || vic.guild == GIL_SUMMONED_BLACK_WOLF)) {
		dmg += Value_WolfSword_BonusDmg;
	} else if ( wpn.weight == Value_Inquisitor_Weapon_ID && C_NpcIsEvil(vic) ) {
		dmg += Value_Inquisitor_BonusDmg;
	}; */

	// Check for crit (melee)
	var int skill; skill = 100; // ranged always crit
	if		(wpn.flags & ITEM_SWD 		|| wpn.flags & ITEM_AXE)		{ skill = att.hitChance[NPC_TALENT_1H]; }
	else if	(wpn.flags & ITEM_2HD_SWD 	|| wpn.flags & ITEM_2HD_AXE)	{ skill = att.hitChance[NPC_TALENT_2H]; };
	if (r_Max(99) < skill) { dmg *= 2; }; // crit doubles weapon damage

	// Add stat
	var int stat;
	if 		(wpn.mainflag & ITEM_KAT_NF) { stat = att.attribute[ATR_STRENGTH]; }
	else if	(wpn.mainflag & ITEM_KAT_FF) { stat = att.attribute[ATR_DEXTERITY]; };
	dmg += stat;

	// Handle protection
	var int prot;
	if 		wpn.damagetype == DAM_EDGE		{ prot = vic.protection[PROT_EDGE]; }
	else if wpn.damagetype == DAM_BLUNT		{ prot = vic.protection[PROT_BLUNT]; }
	else if wpn.damagetype == DAM_POINT		{ prot = vic.protection[PROT_POINT]; }
	else if wpn.damagetype == DAM_MAGIC		{ prot = vic.protection[PROT_MAGIC]; }
	else if wpn.damagetype == DAM_FIRE		{ prot = vic.protection[PROT_FIRE]; }
	else if wpn.damagetype == DAM_FLY		{ prot = vic.protection[PROT_FLY]; };
	if (prot == IMMUNE) 	{ return 0; }
	else 					{ dmg -= prot; };

	// Handle combo
	if (Npc_IsPlayer(att) && Npc_HasReadiedMeleeWeapon(att))
	{
		var oCNpc oCHer; oCHer = Hlp_GetNpc(hero);
		var oCAniCtrl_Human modelState; modelState = _^(oCHer.anictrl);
		dmg /= (10 - modelState.combonr); // 5 -> 2
	};

	return dmg;
};

func int Handle_Magic_Dmg(var c_npc att, var c_npc vic, var int spellID, var int dmg)
{
	// Get protection amount
	var int prot;
	if (att.guild == GIL_DRAGON)	{ prot = vic.protection[PROT_FIRE]; }
	else							{ prot = vic.protection[PROT_MAGIC]; };
	if (prot == IMMUNE)				{ return 0; };

	// Get equipped staff
	var c_item wpn; wpn = Npc_GetEquippedMeleeWeapon(att);

	// FIRE SPELLS ---------------------------------------------------------------------------
	if	(spellID == SPL_Firebolt)
	||	(spellID == SPL_InstantFireball)
	||	(spellID == SPL_Firestorm)
	||	(spellID == SPL_ChargeFireball)
	||	(spellID == SPL_Pyrokinesis)
	||	(spellID == SPL_Firerain)
	||	(spellID == SPL_Explosion)
	{
		// Figure out burn dot
		var int fireDot;
		if		(spellID == SPL_Firebolt)			{ fireDot = SPL_Damage_Firebolt_dot; }
		else if	(spellID == SPL_InstantFireball)	{ fireDot = SPL_Damage_InstantFireball_dot; }
		else if	(spellID == SPL_Firestorm)			{ fireDot = SPL_Damage_InstantFireStorm_dot; }
		else if	(spellID == SPL_ChargeFireball)		{ fireDot = SPL_Damage_ChargeFireball_dot; }
		else if	(spellID == SPL_Pyrokinesis)		{ fireDot = SPL_Damage_FireStorm_dot; }
		else if	(spellID == SPL_Firerain)			{ fireDot = SPL_Damage_Firerain_dot; }
		else if	(spellID == SPL_Explosion)			{ fireDot = SPL_Damage_Explosion_dot; };

		if (Hlp_IsValidItem(wpn))
		{
			// Fire staff
			if (Hlp_IsItem(wpn, ItMW_Addon_Stab01))
			|| (Hlp_IsItem(wpn, ItMW_Addon_Stab01_Infused))
			{
				// Bonus 2: Burning (+20%)
				if (Hlp_IsItem(wpn, ItMW_Addon_Stab01_Infused))
				{
					fireDot = fireDot * 120 / 100;
				};
				// Bonus 1: Damage Bonus vs. burning (+10)
				if (Buff_Has(vic, burn_dot))
				{
					dmg += 10;
				};
			};
		};
		// Play burn FX on corpses for flavor in any case
		if (dmg - prot >= vic.attribute[ATR_HITPOINTS])
		{
			Wld_StopEffect_Ext("VOB_MAGICBURN", vic, vic, FALSE);
			Wld_PlayEffect ("VOB_MAGICBURN", vic, vic, 0, 0, 0, FALSE);
		}
		else if (dmg + fireDot > prot)
		{
			// Reduce protection not negated by instant damage from dot
			if (dmg < prot)
			{
				fireDot -= (prot - dmg);
				prot = dmg;
			};

			// Create dot debuff
			if (fireDot > 0)
			{
				burn_dot_apply(vic, fireDot, att);
				Wld_StopEffect_Ext("VOB_MAGICBURN", vic, vic, FALSE);
				Wld_PlayEffect ("VOB_MAGICBURN", vic, vic, 0, 0, 0, FALSE);
			};
		};
	}
	// ICE SPELLS ---------------------------------------------------------------------------
	else if	(spellID == SPL_Icebolt)
		||	(spellID == SPL_IceLance)
		||	(spellID == SPL_IceCube)
		||	(spellID == SPL_IceWave)
		||	(spellID == SPL_Geyser)
		||	(spellID == SPL_WaterFist)
		||	(spellID == SPL_Thunderstorm)
	{
		if (Hlp_IsValidItem(wpn))
		{
			// Ice staff
			if (Hlp_IsItem(wpn, ItMW_Addon_Stab03_Infused))
			{
				Print ( "ICE DEBUFF 2" );
			};
		};
		

		// Apply ice cube dot, add remainder to main damage
		if ((spellID == SPL_IceCube)
		||	(spellID == SPL_IceWave))
		&& (!C_NpcIsFireBase(vic)) // firebase immune to freeze
		&& (!C_NpcIsIceBase(vic)) // icebase immune to freeze
		{
			var int freezeDuration; freezeDuration = (dmg + SPL_FREEZE_DAMAGE * SPL_FREEZE_TIME - prot) / SPL_FREEZE_DAMAGE;
			if		(freezeDuration > SPL_FREEZE_TIME)		{ self.aivar[AIV_FreezeStateTime] = 0; }
			else if	(freezeDuration > 0)					{ self.aivar[AIV_FreezeStateTime] = SPL_FREEZE_TIME - freezeDuration; }
			else											{ self.aivar[AIV_FreezeStateTime] = SPL_FREEZE_TIME + 1; };
			//Print(ConcatStrings("Start: ", IntToString(self.aivar[AIV_FreezeStateTime])));
		};
	}
	// LIGHTNING SPELLS ---------------------------------------------------------------------------
	else if	(spellID == SPL_Zap)
		||	(spellID == SPL_ChargeZap)
		||	(spellID == SPL_LightningFlash)
		||	(spellID == SPL_AdanosBall)
	{
		// Lightning spell stagger
		if	(!C_NpcIsUndead(self))
		||	(spellID == SPL_AdanosBall)
		{
			if (!Npc_HasBodyFlag(self, BS_FLAG_INTERRUPTABLE))
			{
				AI_PlayAni(self, "T_STUMBLE");
			};
		};
		// Thunder staff
		if (Hlp_IsValidItem(wpn))
		{
			// Bonus 2: Ignore protection
			if (Hlp_IsItem(wpn, ItMW_Addon_Stab02_Infused))
			{
				if (prot < 20)
				{ dmg += prot; }
				else
				{ dmg += 20; };
			};
		};
	};

	// Handle protection
	dmg -= prot;

	return dmg;
};

func int DMG_OnDmg(var int victimPtr, var int attackerPtr, var int dmg, var int dmgDescriptorPtr) {
	Var c_npc vic; vic = _^(victimPtr);
	Var oSDamageDescriptor dmgDesc; dmgDesc = _^(dmgDescriptorPtr);

	// Damage calculations
	if (attackerptr) {
		Var c_npc att; att = _^(attackerptr);

		// Weapon was associated with attack -> was melee/ranged attack
		if (dmgDesc.itemWeapon)
		{
			dmg = Handle_Weapon_Dmg(att, vic);
		}
		// Fist responsibly
		else if (Npc_IsInFightMode(att, FMODE_FIST))
		{
			dmg = att.attribute[ATR_STRENGTH] - vic.protection[PROT_BLUNT];
		}
		// Magic
		else if (dmgDesc.spellID >= 0)
		{
			dmg = Handle_Magic_Dmg(att, vic, dmgDesc.spellID, dmgDesc.dmgArray[DAM_INDEX_FLY] || dmgDesc.dmgArray[DAM_INDEX_MAGIC]);
		};

		// Apply minimum damage of 5 only for NPCs
		if (!Npc_IsPlayer(att) && dmg < 5)	{ dmg = 5; }
		else if (dmg < 0)					{ dmg = 0; };
//Print(ConcatStrings(pristr, ConcatStrings(" -> ", IntToString(dmg))));
	};

	// Monster specials
	if (att.aivar[AIV_MM_REAL_ID] == ID_BLOODFLY || att.aivar[AIV_MM_REAL_ID] == ID_SWAMPDRONE)
	{
		if (att.level > 3)
		{
			Buff_Apply(vic, venom_bloodfly, att);
		} else {
			Buff_Apply(vic, venom_small_bloodfly, att);
		};
	};

	return dmg;
};


var int _DMG_DmgDesc;
func void _DMG_OnDmg_Post() {
	EDI = DMG_OnDmg(EBP, MEM_ReadInt(MEM_ReadInt(ESP+644)+8), EDI, _DMG_DmgDesc);
};
func void _DMG_OnDmg_Pre() {
	_DMG_DmgDesc = ESI; // I'm preeeeetty sure it won't get moved in the meantime...
	if (_DMG_DmgDesc)
	{
		Var oSDamageDescriptor dmgDesc; dmgDesc = _^(_DMG_DmgDesc);
	};
};
func void InitCustomDamageHook() {
	const int dmg = 0;
	if (dmg) { return; };
	HookEngineF(6736583/*0x66CAC7*/, 5, _DMG_OnDmg_Post);
	HookEngineF(6710800/*0x666610*/, 7, _DMG_OnDmg_Pre);
	dmg = 1;
};
