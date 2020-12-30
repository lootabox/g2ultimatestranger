
// https://forum.worldofplayers.de/forum/threads/1149697-Script-Eigene-Schadensberechnung?p=26611509&viewfull=1#post26611509

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

func int DMG_Apply_Damage(var c_npc att, var c_npc vic, var int dmgBefore, var int dmgAfter) {
	if (Npc_IsPlayer(att)) {
		// Hero has no minimum damage
		if (dmgAfter > 0)	{ return dmgAfter; }
		else				{ return 0; };
	} else {
		// Calculate NPC minimum damage
		var int dmgMin; dmgMin = dmgBefore * NPC_MINIMAL_PERCENT / 100;
		if (dmgMin < NPC_MINIMAL_DAMAGE) { dmgMin = NPC_MINIMAL_DAMAGE; };

		// Check whether to use minimum damage
		if (dmgMin < dmgAfter)	{ return dmgAfter; }
		else					{ return dmgMin; };
	};
};

func int DMG_Check_Spell_Block(var c_npc vic, var int spellID) {
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
					|| (spellID == SPL_Firerain)
					|| (spellID == SPL_Firestorm)
					|| (spellID == SPL_Geyser)
					|| (spellID == SPL_IceWave)
					|| (spellID == SPL_LightningFlash)
					|| (spellID == SPL_MassDeath)
					|| (spellID == SPL_Pyrokinesis)
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

func int DMG_Calculate_Melee(var c_npc att, var c_npc vic, var c_item wpn, var int bHasHit) {
	// Get base weapon damage + stat
	var int dmg; dmg = wpn.damageTotal + att.attribute[ATR_STRENGTH];
	
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

	// Get protection (when attacked with a weapon humans always use PROT_POINT / weapon protection and non-humans go according to weapon damage type)
	var int prot;
	if 		vic.guild < GIL_SEPERATOR_HUM	{ prot = vic.protection[PROT_POINT]; }
	else if wpn.damagetype == DAM_BLUNT		{ prot = vic.protection[PROT_BLUNT]; }
	else if wpn.damagetype == DAM_EDGE		{ prot = vic.protection[PROT_EDGE]; }
	else /*if wpn.damagetype == DAM_POINT*/	{ prot = vic.protection[PROT_POINT]; };

	// Check immunity
	if (prot == IMMUNE) 	{ return 0; };

	// Handle water protection
	if (C_BodyStateContains(vic, BS_SWIM)) || (C_BodyStateContains(vic, BS_DIVE)) { prot *= 2; };

var string pristr; pristr = IntToString(dmg);

	// Handle protection and minimum damage
	dmg = DMG_Apply_Damage(att, vic, dmg, dmg - prot);

pristr = ConcatStrings(pristr, ConcatStrings(" -> ", IntToString(dmg)));

	// Handle combo (10% + 10%/cc)
	if (Npc_IsPlayer(att))
	{
		var oCNpc oCHer; oCHer = Hlp_GetNpc(hero);
		var oCAniCtrl_Human modelState; modelState = _^(oCHer.anictrl);
		dmg = dmg * (2 + modelState.combonr) / 10; // divide by 5*2 for combo counter and crit
	} else {
		dmg = dmg / 2; // divide by 2 for crit
	};

pristr = ConcatStrings(pristr, ConcatStrings(" -> ", IntToString(dmg)));

	// Check for crit
	if (bHasHit) { dmg *= 2; }; // crit doubles damage

Print(ConcatStrings(pristr, ConcatStrings(" -> ", IntToString(dmg))));
	return dmg;
};

func int DMG_Calculate_Fist(var c_npc att, var c_npc vic) {
	// Get damage and protection
	var int dmg; dmg = att.attribute[ATR_STRENGTH];
	var int prot;
	if		(att.damage[DAM_INDEX_FIRE] > 0) ||
			(att.damagetype & DAM_FIRE)		{ prot = vic.protection[PROT_FIRE]; }
	else if	(att.damagetype & DAM_EDGE)		{ prot = vic.protection[PROT_EDGE]; }
	else if	(att.damagetype & DAM_BLUNT)	{ prot = vic.protection[PROT_BLUNT]; }
	else if	(att.damagetype & DAM_POINT)	{ prot = vic.protection[PROT_POINT]; }
	else if	(att.damagetype & DAM_MAGIC)	{ prot = vic.protection[PROT_MAGIC]; }
	else									{ prot = vic.protection[PROT_BLUNT]; }; // failsafe

var string pristr; pristr = IntToString(dmg);

	// Handle protection and minimum damage
	DMG_Apply_Damage(att, vic, dmg, dmg - prot);

Print(ConcatStrings(pristr, ConcatStrings(" -> ", IntToString(dmg))));

	// Bloodfly / Swampdrone venom
	if (att.aivar[AIV_MM_REAL_ID] == ID_BLOODFLY || att.aivar[AIV_MM_REAL_ID] == ID_SWAMPDRONE)
	{
		dot_venom_apply(vic, att.damage[DAM_INDEX_EDGE], att);
	};
	// Fire lizard / dragon breath
	if (dmg > 0 && (att.aivar[AIV_MM_REAL_ID] == ID_FIREWARAN || att.guild == GIL_DRAGON))
	{
		var int fireDot; fireDot = dmg;
		dot_burn_apply(vic, fireDot, 4, att);
	};

	return dmg;
};

func int DMG_Calculate_Magic(var c_npc att, var c_npc vic, var int spellID, var int dmg) {
var string pristr; pristr = IntToString(dmg);

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
	{
		// Check fire staff bonus
		if (Hlp_IsValidItem(wpn))
		{
			if (!Buff_Has(vic, dot_burn)) {
				dmg = dmg * (100 + Bonus_Stab01) / 100;
			};
		};

		// Handle protection
		if		(C_NpcIsWeakToFire(vic))	{ dmg -= prot / 2; }
		else if	(C_NpcIsFireBase(vic))		{ dmg -= prot * 2; }
		else								{ dmg -= prot; };

		// Figure out burn dot
		var int fireDot; fireDot = dmg / 2; dmg -= fireDot;

		// Play burn FX on corpses for flavor in any case
		if (dmg >= vic.attribute[ATR_HITPOINTS])
		{
			Wld_StopEffect_Ext("VOB_BURN", vic, vic, FALSE);
			Wld_PlayEffect ("VOB_BURN", vic, vic, 0, 0, 0, FALSE);
		}
		// Create dot debuff
		else if (fireDot > 0)
		{
			dot_burn_apply(vic, fireDot, BURN_DOT_VFX_DURATION_SEC, att);
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
	{
		// Handle protection
		if		(C_NpcIsWeakToLightning(vic))	{ dmg -= prot / 2; }
		else									{ dmg -= prot; };
	}
	// WATER SPELLS ---------------------------------------------------------------------------
	else if	(spellID == SPL_Geyser)
		||	(spellID == SPL_WaterFist)
	{
		// Handle protection
		if		(C_NpcIsWeakToWater(vic)) 	{ dmg -= prot / 2; }
		else								{ dmg -= prot; };
	}
	// DESTROY UNDEAD -----------------------------------------------------------------------
	else if	(spellID == SPL_DestroyUndead)
	{
		if (dmg < vic.attribute[ATR_HITPOINTS] + prot)
		{ dmg /= 2; };
		dmg -= prot;
	}
	// HOLY ARROW -----------------------------------------------------------------------
	else if	(spellID == SPL_PalHolyBolt)
	{
		if (C_NpcIsEvil(vic))
		{	dmg = att.attribute[ATR_MANA_MAX]     - prot;	}
		else
		{	dmg = att.attribute[ATR_MANA_MAX] / 2 - prot;	};
	}
	// HARM EVIL -----------------------------------------------------------------------
	else if	(spellID == SPL_PalRepelEvil)
	{
		if (self.attribute[ATR_HITPOINTS] >= self.attribute[ATR_HITPOINTS_MAX])
		{	dmg = att.attribute[ATR_MANA_MAX] * 2 - prot;	}
		else
		{	dmg = att.attribute[ATR_MANA_MAX]     - prot;	};
	}
	// DESTROY EVIL -----------------------------------------------------------------------
	else if	(spellID == SPL_PalDestroyEvil)
	{
		if (self.attribute[ATR_HITPOINTS] + self.protection[PROT_MAGIC] <= other.attribute[ATR_MANA_MAX]*4)
		{	dmg = att.attribute[ATR_MANA_MAX] * 4 - prot;	}
		else
		{	dmg = att.attribute[ATR_MANA_MAX] * 2 - prot;	};
	}
	// OTHER SPELLS -----------------------------------------------------------------------
	else
	{
		dmg -= prot;
	};

Print(ConcatStrings(pristr, ConcatStrings(" -> ", IntToString(dmg))));
	return dmg;
};

func int DMG_Calculate(var c_npc att, var c_npc vic, var oSDamageDescriptor dmgDesc, var int bHasHit) {
	/** Weapon modes:
		None (0x01, for spells check spellId instead)
		Fist (0x01)
		Melee (0x02)
		Ranged (0x04)
	*/
	if (dmgDesc.spellId > 0) {
		if (DMG_Check_Spell_Block(vic, dmgDesc.spellID))
		{
			Wld_PlayEffect("spellFX_Block_Suck",vic,vic,0,0,0,FALSE);
			return 0;
		};
		return DMG_Calculate_Magic(att, vic, dmgDesc.spellId, dmgDesc.dmgArray[DAM_INDEX_BARRIER] + dmgDesc.dmgArray[DAM_INDEX_FLY] + dmgDesc.dmgArray[DAM_INDEX_MAGIC]);
	}
	else if (dmgDesc.weaponMode == 1) {
		return DMG_Calculate_Fist(att, vic);
	}
	else if (dmgDesc.weaponMode == 2) {
		if (Hlp_Is_oCItem(dmgDesc.itemWeapon)) {
			var c_item wpn; wpn = _^(dmgDesc.itemWeapon);
			return DMG_Calculate_Melee(att, vic, wpn, bHasHit);
		} else {
			Print("ERROR: Could not find weapon for melee attack!");
			return 0;
		};
	};
	/* else if (dmgDesc.weaponMode == 4) {
		if (Hlp_Is_oCItem(dmgDesc.itemWeapon)) {
			var c_item projectile; projectile = _^(dmgDesc.itemWeapon);
			if (Npc_HasReadiedRangedWeapon(att))		{ DMG_Calculate_Ranged(att, vic, Npc_GetReadiedWeapon(att)); }
			else if (Npc_HasEquippedRangedWeapon(att))	{ DMG_Calculate_Ranged(att, vic, Npc_GetEquippedRangedWeapon(att)); }
			else										{ Print("ERROR: Could not find weapon for ranged attack!"); };
		};
	}; */

	Print("ERROR: Unknown damage calculation!");
	return 0;
};

func int DMG_OnDmg(var int victimPtr, var int attackerPtr, var int dmg, var int dmgDescriptorPtr, var int bHasHit) {
	if (!victimPtr) { return dmg; };
	var oSDamageDescriptor dmgDesc; dmgDesc = _^(dmgDescriptorPtr);
	if (dmgDesc.dmgMode == DAM_FALL) { return dmg; };

	//Print (ConcatStrings ("weaponMode is: ", IntToString (dmgDesc.weaponMode)));
	//Print (ConcatStrings ("damageMode is: ", IntToString (dmgDesc.dmgMode)));
	//Print (ConcatStrings ("itemWeapon is: ", IntToString (dmgDesc.itemWeapon)));

	// Check if damage came from a PFX
	const int dmgIsPFX = FALSE;
	if (dmgDesc.hitPfx && dmgDesc.spellId <= 0) {
		Print("Heyo");
		var oCVisualFX visFx; visFx = _^(dmgDesc.hitPfx);

		// If we still have no attacker, try to take him from PFX inflictor (e.g. AoE spells)
		if (!attackerPtr) {
			Print("Heyo 2");
			attackerPtr = visFx.inflictor;
		};

		dmgIsPFX = TRUE;
	};

	if (attackerPtr) {
		var c_npc att; att = _^(attackerPtr);
		var c_npc vic; vic = _^(victimPtr);

		// Invoke custom damage calculation if not PFX
		if (!dmgIsPFX) {
			dmg = DMG_Calculate(att, vic, dmgDesc, bHasHit);
		};
	};

	return dmg;
};

func void _DMG_OnDmg_Post() {
	const int dmgDesc = 0;	dmgDesc = MEM_ReadInt((ESP + 640) + 4 /* &oSDamageDescriptor */); // oCNpc :: OnDamage_Hit ( oSDamageDescriptor& descDamage )
	const int bHasHit = 0;	bHasHit = MEM_ReadInt((ESP + 640) - 356 /* zBOOL bHasHit */);
	EDI = DMG_OnDmg(EBP, MEM_ReadInt(dmgDesc+8), EDI, dmgDesc, bHasHit);
};
func void InitCustomDamageHook() {
	HookEngineF(6736583/*0x66CAC7*/, 5, _DMG_OnDmg_Post);
};
