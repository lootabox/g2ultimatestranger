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

func int DMG_OnDmg(var int victimPtr, var int attackerPtr, var int dmg, var int dmgDescriptorPtr) {
	Var c_npc vic; vic = _^(victimPtr);
	Var oSDamageDescriptor dmgDesc; dmgDesc = _^(dmgDescriptorPtr);
var string pristr; 
	// Damage calculations
	if (attackerptr) {
		Var c_npc att; att = _^(attackerptr);
		Var c_item wpn;
		var int prot;

		// Weapon was associated with attack -> was melee/ranged attack
		if (dmgDesc.itemWeapon)
		{
			// If melee weapon is readied use that, otherwise use equipped ranged weapon
			if (Npc_HasReadiedMeleeWeapon(att)) { wpn = Npc_GetReadiedWeapon(att); }
			else { wpn = Npc_GetEquippedRangedWeapon(att); };
			
			// Get base weapon damage
			dmg = wpn.damageTotal;
			
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
			} else if ( wpn.weight == Value_WolfSword_Weapon_ID && (vic.guild == GIL_WOLF || vic.guild == GIL_SUMMONED_WOLF)) {
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
pristr = IntToString(dmg);

			// Handle protection
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
		}
		// Fist responsibly
		else if (Npc_IsInFightMode(att, FMODE_FIST))
		{
			dmg = att.attribute[ATR_STRENGTH] - vic.protection[PROT_BLUNT];
pristr = IntToString(dmg);
		}
		// Magic
		else if (dmgDesc.spellID >= 0)
		{
			// Get base magic damage and prot
			dmg = dmgDesc.dmgArray[DAM_INDEX_MAGIC];
			if (isSpellWind) 				{ dmg = dmgDesc.dmgArray[DAM_INDEX_FLY]; };
			if (att.guild == GIL_DRAGON)	{ prot = vic.protection[PROT_FIRE]; }
				else						{ prot = vic.protection[PROT_MAGIC]; };
			if (prot == IMMUNE)				{ return 0; };
pristr = IntToString(dmg);

			// Get equipped staff
			wpn = Npc_GetEquippedMeleeWeapon(att);
			if (Hlp_IsValidItem(wpn))
			{
				// Get base type for spell
				var int isSpellIce; isSpellIce = (
						(dmgDesc.spellID == SPL_Icebolt)
					||	(dmgDesc.spellID == SPL_IceLance)
					||	(dmgDesc.spellID == SPL_IceCube)
					||	(dmgDesc.spellID == SPL_IceWave)
					||	(dmgDesc.spellID == SPL_Geyser)
					||	(dmgDesc.spellID == SPL_WaterFist)
					||	(dmgDesc.spellID == SPL_Thunderstorm)
				);
				var int isSpellFire; isSpellFire = (
						(dmgDesc.spellID == SPL_Firebolt)
					||	(dmgDesc.spellID == SPL_InstantFireball)
					||	(dmgDesc.spellID == SPL_Firestorm)
					||	(dmgDesc.spellID == SPL_ChargeFireball)
					||	(dmgDesc.spellID == SPL_Pyrokinesis)
					||	(dmgDesc.spellID == SPL_Firerain)
					||	(dmgDesc.spellID == SPL_Explosion)
				);
				var int isSpellLightning; isSpellLightning = (
						(dmgDesc.spellID == SPL_Zap)
					||	(dmgDesc.spellID == SPL_ChargeZap)
					||	(dmgDesc.spellID == SPL_LightningFlash)
					||	(dmgDesc.spellID == SPL_Thunderstorm)
					||	(dmgDesc.spellID == SPL_AdanosBall)
				);
				var int isSpellWind; isSpellWind = (
						(dmgDesc.spellID == SPL_WindFist)
				);
				var int isSpellDot; isSpellDot = (
						(dmgDesc.spellID == SPL_Whirlwind)
					||	(dmgDesc.spellID == SPL_Thunderstorm)
					||	(dmgDesc.spellID == SPL_Firerain)
					||	(dmgDesc.spellID == SPL_GreenTentacle)
					||	(dmgDesc.spellID == SPL_SuckEnergy)
					||	(dmgDesc.spellID == SPL_Swarm)
					||	(dmgDesc.spellID == SPL_Acid)
				);

				// Handle staff bonus
				if (isSpellFire)
				{
					// Fire: Damage Bonus (+10)
					if (Hlp_GetInstanceID(wpn) == ItMW_Addon_Stab01)
					|| (Hlp_GetInstanceID(wpn) == ItMW_Addon_Stab01)
					{
						dmg += 10;
						// Fire: Burning (+20%)
						if (Hlp_GetInstanceID(wpn) == ItMW_Addon_Stab01)
						{
							// temp for calculation
							var int fire_dot; fire_dot = dmg * 10000 / 8333 - dmg;
							if (dmg < prot) { fire_dot -= (dmg - prot); };
							if (fire_dot > 0)
							{
								if		(fire_dot >= 60)	{ Buff_Apply(vic, fire_spell_dot_60, att); }
								else if	(fire_dot >= 56)	{ Buff_Apply(vic, fire_spell_dot_56, att); }
								else if	(fire_dot >= 52)	{ Buff_Apply(vic, fire_spell_dot_52, att); }
								else if	(fire_dot >= 48)	{ Buff_Apply(vic, fire_spell_dot_48, att); }
								else if	(fire_dot >= 44)	{ Buff_Apply(vic, fire_spell_dot_44, att); }
								else if	(fire_dot >= 40)	{ Buff_Apply(vic, fire_spell_dot_40, att); }
								else if	(fire_dot >= 36)	{ Buff_Apply(vic, fire_spell_dot_36, att); }
								else if	(fire_dot >= 32)	{ Buff_Apply(vic, fire_spell_dot_32, att); }
								else if	(fire_dot >= 28)	{ Buff_Apply(vic, fire_spell_dot_28, att); }
								else if	(fire_dot >= 24)	{ Buff_Apply(vic, fire_spell_dot_24, att); }
								else if	(fire_dot >= 20)	{ Buff_Apply(vic, fire_spell_dot_20, att); }
								else if	(fire_dot >= 16)	{ Buff_Apply(vic, fire_spell_dot_16, att); }
								else if	(fire_dot >= 12)	{ Buff_Apply(vic, fire_spell_dot_12, att); }
								else if	(fire_dot >= 8)		{ Buff_Apply(vic, fire_spell_dot_8, att); }
								else if	(fire_dot >= 4)		{ Buff_Apply(vic, fire_spell_dot_4, att); };

								if (fire_dot >= 4) { Wld_PlayEffect ("VOB_MAGICBURN", vic, vic, 0, 0, 0, FALSE); };
								dmg += (4 - fire_dot / 4); // add remainder
							};
						};
					}
					else if (dmg - prot >= vic.attribute[ATR_HITPOINTS])
					{
						// Play burn FX on corpses for flavor
						Wld_PlayEffect ("VOB_MAGICBURN", vic, vic, 0, 0, 0, FALSE);
					};
				}
				else if (isSpellIce)
				{
					// Ice: Debuff
					if (Hlp_GetInstanceID(wpn) == ItMW_Addon_Stab03)
					|| (Hlp_GetInstanceID(wpn) == ItMW_Addon_Stab03)
					{
						Print ( "ICE DEBUFF 1" );
						if (Hlp_GetInstanceID(wpn) == ItMW_Addon_Stab03)
						{
							Print ( "ICE DEBUFF 2" );
						};
					};
				}
				else if (isSpellLightning)
				{
					// Lightning/Force: Ignore protection
					if (Hlp_GetInstanceID(wpn) == ItMW_Addon_Stab02)
					|| (Hlp_GetInstanceID(wpn) == ItMW_Addon_Stab02)
					{
						if (prot < 15)
						{ dmg += prot; }
						else
						{ dmg += 15; };
						
						// Lightning/Force: ???
						if (Hlp_GetInstanceID(wpn) == ItMW_Addon_Stab02)
						{
							Print ( "LIGHTNING/FORCE ???" );
						};
					};
				}
				else if (isSpellDot)
				{
					// Dot: Increase dot
					if (Hlp_GetInstanceID(wpn) == ItMW_Addon_Stab04)
					{
						dmg += dmg * 33 / 100;
					};
				};
			};

			// Handle protection
			dmg -= prot;

			// Apply ice cube dot, add remainder to main damage
			if ((Npc_GetLastHitSpellID(vic) == SPL_IceCube)
			|| (Npc_GetLastHitSpellID(vic) == SPL_IceWave))
			&& (!C_NpcIsFireBase(vic)) // firebase immune to freeze
			&& (!C_NpcIsIceBase(vic)) // icebase immune to freeze
			{
				dmg += (SPL_FREEZE_DAMAGE * SPL_TIME_FREEZE);
				if (dmg >= SPL_FREEZE_DAMAGE)
				{
					if		(dmg >= 10 * SPL_FREEZE_DAMAGE)	{ Buff_RemoveAll(vic, icecube_dot_40); Buff_Apply(vic, icecube_dot_40, att); }
					else if	(dmg >= 9 * SPL_FREEZE_DAMAGE)	{ Buff_RemoveAll(vic, icecube_dot_36); Buff_Apply(vic, icecube_dot_36, att); }
					else if	(dmg >= 8 * SPL_FREEZE_DAMAGE)	{ Buff_RemoveAll(vic, icecube_dot_32); Buff_Apply(vic, icecube_dot_32, att); }
					else if	(dmg >= 7 * SPL_FREEZE_DAMAGE)	{ Buff_RemoveAll(vic, icecube_dot_28); Buff_Apply(vic, icecube_dot_28, att); }
					else if	(dmg >= 6 * SPL_FREEZE_DAMAGE)	{ Buff_RemoveAll(vic, icecube_dot_24); Buff_Apply(vic, icecube_dot_24, att); }
					else if	(dmg >= 5 * SPL_FREEZE_DAMAGE)	{ Buff_RemoveAll(vic, icecube_dot_20); Buff_Apply(vic, icecube_dot_20, att); }
					else if	(dmg >= 4 * SPL_FREEZE_DAMAGE)	{ Buff_RemoveAll(vic, icecube_dot_16); Buff_Apply(vic, icecube_dot_16, att); }
					else if	(dmg >= 3 * SPL_FREEZE_DAMAGE)	{ Buff_RemoveAll(vic, icecube_dot_12); Buff_Apply(vic, icecube_dot_12, att); }
					else if	(dmg >= 2 * SPL_FREEZE_DAMAGE)	{ Buff_RemoveAll(vic, icecube_dot_8); Buff_Apply(vic, icecube_dot_8, att); }
					else if	(dmg >= 1 * SPL_FREEZE_DAMAGE)	{ Buff_RemoveAll(vic, icecube_dot_4); Buff_Apply(vic, icecube_dot_4, att); };
				};
				dmg -= (SPL_FREEZE_DAMAGE * SPL_TIME_FREEZE);
			};
		};

		// Apply minimum damage of 5 only for NPCs
		if (!Npc_IsPlayer(att) && dmg < 5)	{ dmg = 5; }
		else if (dmg < 0)					{ dmg = 0; };
Print(ConcatStrings(pristr, ConcatStrings(" -> ", IntToString(dmg))));
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
