
// Rather crude, but should be fine since there is only one fire mage staff in the game
var int Staff_Fire_Charged;

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
1H:		lvl1: 5%/10LP,	lvl2: 10%/20LP
2H:		lvl1: 5%/30LP,	lvl2: 10%/40LP
Bow:	lvl1: 15%/10LP,	lvl2: 30%/20LP
X-Bow:	lvl1: 20%/10LP,	lvl2: 40%/20LP

		GOTHIC 2 / NOTR
Melee		(WD + STR - AP - 1) / 10		>= 5
Melee Crit	 WD + STR - AP					>= 5
Range		 WD + DEX - AP

		ULTIMATE STRANGER
Melee		WD   + STR - AP				>= 5 (npc only)
Melee Crit	WDx2 + STR - AP				>= 5 (npc only)
Range		WD   + DEX - AP
*/

func int Check_Spell_Block(var c_npc vic, var int spellID)
{
	// Only player can block spells
	if (Npc_IsPlayer(vic))
	{
		// Check for rune sword / rune power
		var c_item wpn; wpn = Npc_GetReadiedWeapon(vic);
		if (Npc_HasReadiedMeleeWeapon(vic))
		{
			if (Hlp_IsItem(wpn, ItMw_Runenschwert))
			|| (Hlp_IsItem(wpn, ItMw_Zweihaender3))
			{
				if (C_BodyStateContains(vic, BS_PARADE))
				{
					// Some spells cant be blocked
					if (spellID == SPL_BreathOfDeath)
					|| (spellID == SPL_DestroyUndead)
					|| (spellID == SPL_Earthquake)
					|| (spellID == SPL_Explosion)
					|| (spellID == SPL_Extricate)
					|| (spellID == SPL_Firerain)
					|| (spellID == SPL_Firestorm)
					|| (spellID == SPL_Geyser)
					|| (spellID == SPL_IceWave)
					|| (spellID == SPL_LightningFlash)
					|| (spellID == SPL_MassDeath)
					|| (spellID == SPL_Pyrokinesis)
					|| (spellID == SPL_Quake)
					|| (spellID == SPL_Skull)
					|| (spellID == SPL_Swarm)
					|| (spellID == SPL_Thunderstorm)
					|| (spellID == SPL_WindFist)
					{
						return FALSE;
					};
					return TRUE;
				};
			};
		};
	};
	return FALSE;
};

func int Handle_Melee_Dmg(var c_npc vic, var c_npc att)
{
	// If melee weapon was used, it should be readied when dealing damage
	var c_item wpn; wpn = Npc_GetReadiedWeapon(att);
	
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
	} else if ( wpn.weight == Value_WolfSword_Weapon_ID && (vic.guild == GIL_WOLF || vic.guild == GIL_SUMMONED_WOLF || vic.guild == GIL_SUMMONED_BLACK_WOLF)) {
		dmg += Value_WolfSword_BonusDmg;
	} else if ( wpn.weight == Value_Inquisitor_Weapon_ID && C_NpcIsEvil(vic) ) {
		dmg += Value_Inquisitor_BonusDmg;
	}; */

	// Check for crit
	var int skill; skill = 0;
	if		(wpn.flags & ITEM_SWD 		|| wpn.flags & ITEM_AXE)		{ skill = att.hitChance[NPC_TALENT_1H]; }
	else if	(wpn.flags & ITEM_2HD_SWD 	|| wpn.flags & ITEM_2HD_AXE)	{ skill = att.hitChance[NPC_TALENT_2H]; };
	if (r_Max(99) < skill) { dmg *= 2; }; // crit doubles weapon damage

	// Add stat
	dmg += att.attribute[ATR_STRENGTH];

Print(ConcatStrings(ConcatStrings(att.name," - "),wpn.name));
var string pristr; pristr = IntToString(dmg);

	// Get protection
	var int prot;
	if 		wpn.damagetype == DAM_EDGE		{ prot = vic.protection[PROT_EDGE]; }
	else if wpn.damagetype == DAM_BLUNT		{ prot = vic.protection[PROT_BLUNT]; }
	else if wpn.damagetype == DAM_POINT		{ prot = vic.protection[PROT_POINT]; };

	// Check immunity
	if (prot == IMMUNE) 	{ return 0; };

	// Handle water protection
	if (C_BodyStateContains(vic, BS_SWIM)) || (C_BodyStateContains(vic, BS_DIVE)) { prot *= 2; };

	// Reduce protection
	dmg -= prot;

	// Handle combo
	if (Npc_IsPlayer(att) && Npc_HasReadiedMeleeWeapon(att))
	{
		var oCNpc oCHer; oCHer = Hlp_GetNpc(hero);
		var oCAniCtrl_Human modelState; modelState = _^(oCHer.anictrl);
		dmg /= (10 - modelState.combonr); // 5 -> 2
	};

Print(ConcatStrings(pristr, ConcatStrings(" -> ", IntToString(dmg))));
	return dmg;
};

func int Handle_Fist_Dmg(var c_npc vic, var c_npc att)
{
	// Handle protection and calculate damage
	var int dmg; dmg = att.attribute[ATR_STRENGTH];
	if		(att.damage[DAM_INDEX_FIRE] > 0) ||
			(att.damagetype & DAM_FIRE)		{ dmg -= vic.protection[PROT_FIRE]; }
	else if	(att.damagetype & DAM_EDGE)		{ dmg -= vic.protection[PROT_EDGE]; }
	else if	(att.damagetype & DAM_BLUNT)	{ dmg -= vic.protection[PROT_BLUNT]; }
	else if	(att.damagetype & DAM_POINT)	{ dmg -= vic.protection[PROT_POINT]; }
	else if	(att.damagetype & DAM_MAGIC)	{ dmg -= vic.protection[PROT_MAGIC]; }
	else									{ dmg -= vic.protection[PROT_BLUNT]; }; // failsafe

	// Bloodfly / Swampdrone venom
	if (att.aivar[AIV_MM_REAL_ID] == ID_BLOODFLY || att.aivar[AIV_MM_REAL_ID] == ID_SWAMPDRONE)
	{
		dot_venom_apply(vic, att.damage[DAM_INDEX_POINT], att);
	};
	// Fire lizard / dragon breath
	if (dmg > 1 && (att.aivar[AIV_MM_REAL_ID] == ID_FIREWARAN || att.guild == GIL_DRAGON))
	{
		var int fireDot; fireDot = dmg;
		dot_burn_apply(vic, fireDot, 4, att);
	};

	return dmg;
};

func int Handle_Magic_Dmg(var c_npc vic, var c_npc att, var int spellID, var int dmg)
{
var string pristr; pristr = IntToString(dmg);

	// Handle infused fire mage staff
	if (Staff_Fire_Charged == TRUE)
	{
		dmg = dmg * 5 / 4;
	};

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
		// Handle protection
		if		(C_NpcIsWeakToFire(vic))	{ dmg -= prot / 2; }
		else if	(C_NpcIsFireBase(vic))		{ dmg -= prot * 2; }
		else								{ dmg -= prot; };

		// Figure out burn dot
		var int fireDot; fireDot = dmg / 2; dmg -= fireDot;
		var int fireTicks; fireTicks = BURN_DOT_VFX_DURATION_SEC;

		if (Hlp_IsValidItem(wpn))
		{
			// Fire staff
			if (Hlp_IsItem(wpn, ItMW_Addon_Stab01))
			{
				dmg += 10;
			}
			else if (Hlp_IsItem(wpn, ItMW_Addon_Stab01_Infused))
			{
				Staff_Fire_Charged = TRUE;
			};
		};
		// Play burn FX on corpses for flavor in any case
		if (dmg >= vic.attribute[ATR_HITPOINTS])
		{
			Wld_StopEffect_Ext("VOB_BURN", vic, vic, FALSE);
			Wld_PlayEffect ("VOB_BURN", vic, vic, 0, 0, 0, FALSE);
		}
		// Create dot debuff
		else if (fireDot > 0)
		{
			dot_burn_apply(vic, fireDot, fireTicks, att);
pristr = ConcatStrings(pristr, ConcatStrings(" -> dot ", IntToString(fireDot)));
		};
	}
	// ICE SPELLS ---------------------------------------------------------------------------
	else if	(spellID == SPL_Icebolt)
		||	(spellID == SPL_IceLance)
		||	(spellID == SPL_IceCube)
		||	(spellID == SPL_IceWave)
		||	(spellID == SPL_Thunderstorm)
	{
		// Handle protection
		if		(C_NpcIsWeakToIce(vic))		{ dmg -= prot / 2; }
		else if	(C_NpcIsIceBase(vic))		{ dmg -= prot * 2; }
		else								{ dmg -= prot; };

		// Apply ice cube dot, add remainder to main damage
		if	(spellID == SPL_IceCube)
		||	(spellID == SPL_IceWave)
		{
			// Calculate freeze dot
			var int freezeDot; freezeDot = SPL_FREEZE_DAMAGE;
			if		(C_NpcIsFireBase(vic))	{ freezeDot *= 2; }
			else if	(C_NpcIsIceBase(vic))	{ freezeDot /= 2; };

			var int freezeDuration; freezeDuration = dmg / freezeDot;
			if	(!C_NpcIsLarge(vic) && freezeDuration > 0)
			{
				// Initialize freeze effect duration and reduce dot from dmg
				vic.aivar[AIV_FreezeStateTime] = SPL_FREEZE_TIME - freezeDuration;
				dmg -= freezeDot * freezeDuration;
pristr = ConcatStrings(pristr, ConcatStrings(" -> dot ", IntToString(freezeDot * freezeDuration)));
			}
			else
			{
				// Bypass freeze effect
				vic.aivar[AIV_FreezeStateTime] = SPL_FREEZE_TIME + 1;
			};
			//Print(ConcatStrings("Start: ", IntToString(vic.aivar[AIV_FreezeStateTime])));
		};
	}
	// LIGHTNING SPELLS ---------------------------------------------------------------------------
	else if	(spellID == SPL_Zap)
		||	(spellID == SPL_ChargeZap)
		||	(spellID == SPL_LightningFlash)
		||	(spellID == SPL_AdanosBall)
	{
		// Handle protection
		if		(C_NpcIsWeakToLightning(vic))	{ dmg -= prot / 2; }
		else if	(C_NpcIsIceBase(vic))			{ dmg -= prot * 2; }
		else									{ dmg -= prot; };

		// Lightning spell stagger at full hitpoints
		if	(!C_NpcIsUndead(vic))
		&&	(spellID != SPL_AdanosBall)
		&&	(self.attribute[ATR_HITPOINTS] >= self.attribute[ATR_HITPOINTS_MAX])
		{
			if (!Npc_HasBodyFlag(vic, BS_FLAG_INTERRUPTABLE))
			{
				AI_PlayAni(vic, "T_STUMBLE");
			};
		};
	}
	// WATER SPELLS ---------------------------------------------------------------------------
	else if	(spellID == SPL_Geyser)
		||	(spellID == SPL_WaterFist)
	{
		// Handle protection
		if	(C_NpcIsWeakToWater(vic)) {
			if (C_NpcIsLarge(vic)) {
				dmg -= prot;
			} else {
				dmg -= prot / 2;
			};
		}
		else if	(C_NpcIsLarge(vic))			{ dmg -= prot * 2; }
		else								{ dmg -= prot; };
	}
	// FATAL ONLY SPELLS -----------------------------------------------------------------------
	else if	(spellID == SPL_DestroyUndead)
		||	(spellID == SPL_BreathOfDeath) && (att.guild != GIL_SKELETON_MAGE)
		||	(spellID == SPL_MassDeath)
	{
		dmg -= prot;
		if (dmg < vic.attribute[ATR_HITPOINTS])
		{
			dmg = 0;
		};
	}
	// OTHER SPELLS -----------------------------------------------------------------------
	else
	{
		dmg -= prot;
	};

Print(ConcatStrings(pristr, ConcatStrings(" -> ", IntToString(dmg))));
	return dmg;
};

func int DMG_OnDmg(var int victimPtr, var int attackerPtr, var int dmg, var int dmgDescriptorPtr) {
	var c_npc vic; vic = _^(victimPtr);
	var oSDamageDescriptor dmgDesc; dmgDesc = _^(dmgDescriptorPtr);

	// Damage calculations
	if (attackerPtr) {
		var c_npc att; att = _^(attackerPtr);

		// Weapon was associated with attack -> was melee/ranged attack
		if (dmgDesc.itemWeapon)
		{
			// var oCItem wpn; wpn = _^(dmgDesc.itemWeapon);
			// if (wpn.mainflag == ITEM_KAT_MUN) { dmg = Handle_Ranged_Dmg(vic, att); };
			if (Npc_HasReadiedMeleeWeapon(att))	{ dmg = Handle_Melee_Dmg(vic, att); };
		}
		// Magic
		else if (dmgDesc.spellLevel > 0) //(dmgDesc.spellID >= 0)
		{
			if (Check_Spell_Block(vic, dmgDesc.spellID))
			{
				Wld_PlayEffect("spellFX_Block_Suck",vic,vic,0,0,0,FALSE);
				return 0;
			};
			dmg = Handle_Magic_Dmg(vic, att, dmgDesc.spellID, dmgDesc.dmgArray[DAM_INDEX_BARRIER] + dmgDesc.dmgArray[DAM_INDEX_FLY] + dmgDesc.dmgArray[DAM_INDEX_MAGIC]);
		}
		// Fist responsibly
		else if (Npc_IsInFightMode(att, FMODE_FIST))
		{
			dmg = Handle_Fist_Dmg(vic, att);
		};
		if (dmg < 0) { dmg = 0; };
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
