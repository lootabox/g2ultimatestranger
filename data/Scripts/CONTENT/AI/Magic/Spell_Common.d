
func int Spell_Logic_Basic (var c_npc slf, var int manaCost)
{
	if (Npc_GetActiveSpellIsScroll(slf) && (slf.attribute[ATR_MANA] >= C_GetScrollCost(manaCost)))
	{
		return SPL_SENDCAST;
	};

	// Check for Ulthar's
	var c_item wpn; wpn = Npc_GetEquippedMeleeWeapon(self);
	if (Hlp_IsValidItem(wpn))
	{
		if (Hlp_IsItem(wpn, ItMW_Addon_Stab04) || Hlp_IsItem(wpn, ItMW_Addon_Stab04_Infused)) { manaCost -= 5; };
	};

	if (slf.attribute[ATR_MANA] >= manaCost)
	{	
		return SPL_SENDCAST;
	}
	else
	{
		return SPL_SENDSTOP;
	};
};

func void Spell_Cast_Basic (var c_npc slf, var int manaCost)
{
	if (Npc_GetActiveSpellIsScroll(slf))
	{
		slf.attribute[ATR_MANA] -= C_GetScrollCost(manaCost);
	}
	else
	{
		// Check for Ulthar's
		var c_item wpn; wpn = Npc_GetEquippedMeleeWeapon(self);
		if (Hlp_IsValidItem(wpn))
		{
			if (Hlp_IsItem(wpn, ItMW_Addon_Stab04) || Hlp_IsItem(wpn, ItMW_Addon_Stab04_Infused)) { manaCost -= 5; };
		};

		slf.attribute[ATR_MANA] -= manaCost;
	};
	slf.aivar[AIV_SelectSpell] += 1;
};

func int Spell_Logic_Invest(var C_NPC slf, var int manaInvested, var int STEP_size, var int maxLevel, var int firstTierNoManaCost)
{
	var int STEP_cost; STEP_cost = STEP_size;
	if (Npc_GetActiveSpellIsScroll(slf)) {STEP_cost = C_GetScrollCost(STEP_cost);}
	else
	{
		// Check for Ulthar's
		var c_item wpn; wpn = Npc_GetEquippedMeleeWeapon(self);
		if (Hlp_IsValidItem(wpn))
		{
			if (Hlp_IsItem(wpn, ItMW_Addon_Stab04) || Hlp_IsItem(wpn, ItMW_Addon_Stab04_Infused))
			{
				STEP_cost -= 5;
				if (Hlp_IsItem(wpn, ItMW_Addon_Stab04_Infused))
				{
					STEP_size = STEP_size * 7 / 10;
				};
			};
		};
	};

	if (manaInvested == 0) {
		if (slf.attribute[ATR_MANA] < STEP_cost) { return SPL_SENDSTOP; }; // plays special animation at manaInvested 0
		if (firstTierNoManaCost == FALSE) { slf.attribute[ATR_MANA] -= STEP_cost; };
		slf.aivar[AIV_SpellLevel] = 0; // make sure to start at 0
	};

	var int tier; tier = manaInvested / STEP_size;
	if (slf.aivar[AIV_SpellLevel] < tier)
	{
		if (tier == maxLevel)
		{
			return SPL_SENDCAST; // fire latest at max level
		};
		if (slf.attribute[ATR_MANA] < STEP_cost) { return SPL_SENDCAST; }; // fire instead of advancing if not enough mana
		slf.attribute[ATR_MANA] -= STEP_cost;
		slf.aivar[AIV_SpellLevel] = tier;
		return SPL_NEXTLEVEL; // advance tier
	};
	return SPL_STATUS_CANINVEST_NO_MANADEC; // can invest, cannot advance
};


// Addresses for blink / summon
const int zCWayNet__GetWaypoint					= 8061744; //0x7B0330
const int zCWayNet__InsertWaypoint				= 8048896; //0x7AD100
const int zCWaypoint___CreateNewInstance		= 8076144; //0x7B3B70
const int zCWaypoint__SetName					= 8059824; //0x7AFBB0
const int zCWaypoint__CorrectHeight				= 8061088; //0x7B00A0
const int zCWaypoint__CorrectHeight_maxDepth	= 8061133; //0x7B00CD

const string SPL_BLINK_WP						= "WP_SPL_BLINK"; // The name should be unique

func int Move_Blink_Waypoint(var C_NPC slf)
{
	// --- Check if spell failed ---

	// Retrieve position from aim vob
	var int vobPtr; vobPtr = GFA_SetupAimVob(0);
	if (!vobPtr) {
		// MEM_Error("Summon: Failed to retrieve destination (aim vob)"); // Don't break immersion
		AI_PlayAni(slf, "T_CASTFAIL"); // Much nicer
		Wld_PlayEffect("SPELLFX_FEAR_GROUND", slf, slf, 0, 0, 0, FALSE);
		MEM_Warn("Spell_Cast_Summon: Failed to retrieve destination (aim vob)");
		return FALSE;
	};
	var zCVob vob; vob = _^(vobPtr);
	var zCVob caster; caster = Hlp_GetNpc(slf);

	// Safety first: Line of sight to target location is obstructed, cancel to prevent traversing through walls
	if (!Npc_CanSeeItem(slf, vob)) {
		AI_PlayAni(slf, "T_CASTFAIL");
		MEM_Warn("Spell_Cast_Summon: Destination out of sight (aim vob)");
		return FALSE;
	};


	// --- Set up destination way point ---

	// Just for completeness (NPCs cannot use this spell with free aim)
	slf.aivar[AIV_SelectSpell] += 1;

	var int pos[6]; // Combined pos[3] and dir[3]
	pos[0] = vob.trafoObjToWorld[ 3];  pos[3] = caster.trafoObjToWorld[ 2];
	pos[1] = vob.trafoObjToWorld[ 7];  pos[4] = caster.trafoObjToWorld[ 6];
	pos[2] = vob.trafoObjToWorld[11];  pos[5] = caster.trafoObjToWorld[10];

	// Search for destination way point
	var int waynetPtr; waynetPtr = _@(MEM_Waynet);
	var int wpNamePtr; wpNamePtr = _@s(SPL_BLINK_WP);
	var int wpPtr;
	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(wpPtr));
		CALL__fastcall(_@(waynetPtr), _@(wpNamePtr), zCWayNet__GetWaypoint);
		call = CALL_End();
	};

	// Create way point if it does not exit yet
	if (!wpPtr) {
		MEM_Info("Spell_Cast_Summon: Creating destination way point."); // Should be printed only once for each world

		CALL__cdecl(zCWaypoint___CreateNewInstance); // This allocates the necessary memory
		wpPtr = CALL_RetValAsPtr();

		CALL_zStringPtrParam(SPL_BLINK_WP);
		CALL__thiscall(wpPtr, zCWaypoint__SetName);

		CALL_PtrParam(wpPtr);
		CALL__thiscall(_@(MEM_Waynet), zCWayNet__InsertWaypoint);
	};

	// Update way point position and direction
	var zCWaypoint wp; wp = _^(wpPtr);
	MEM_CopyWords(_@(pos), _@(wp.pos), 6); // Set zCWaypoint.pos[3] and zCWaypoint.dir[3]


	// --- Correct way point height ---
/* 
	// Set longer ground check trace ray in zCWaypoint::CorrectHeight
	MemoryProtectionOverride(zCWaypoint__CorrectHeight_maxDepth, 4);
	var int traceLengthBak; traceLengthBak = MEM_ReadInt(zCWaypoint__CorrectHeight_maxDepth);
	MEM_WriteInt(zCWaypoint__CorrectHeight_maxDepth, mkf(-2000)); // Enlarge trace ray length

	// Align way point to ground to prevent AI_Teleport to transition through walls on different stories/levels
	var int worldPtr; worldPtr = _@(MEM_World);
	const int call2 = 0;
	if (CALL_Begin(call2)) {
		CALL_PtrParam(_@(worldPtr));
		CALL__thiscall(_@(wpPtr), zCWaypoint__CorrectHeight);
		call2 = CALL_End();
	};

	// Revert trace ray length
	MEM_WriteInt(zCWaypoint__CorrectHeight_maxDepth, traceLengthBak);

	// Visualize the height correction for debugging purposes
	if (FALSE) {
		if (!Hlp_IsValidHandle(h)) {
			var int h; h = DrawLine(_@(wp.pos), _@(pos), zCOLOR_RED);
		} else {
			UpdateLine(h, _@(wp.pos), _@(pos));
		};
	}; */

	return TRUE;
};

func int Spell_Logic_Invest_Summon(var C_NPC slf, var int manaInvested, var int SPL_Cost)
{
	// Npcs cant handle charge summons...
	if (!Npc_IsPlayer(slf))
	{
		return Spell_Logic_Basic(slf, SPL_Cost);
	};

	if (!manaInvested) && (GFA_ACTIVE) {
		GFA_AimVobAttachFX("spellFX_Blink_Target"); // Technically this would work purely by spellFX, but it is unstable
	};

	var c_item wpn; wpn = Npc_GetEquippedMeleeWeapon(slf);
	if (Hlp_IsValidItem(wpn))
	{
		if (Hlp_IsItem(wpn, ItMW_Addon_Stab02_Infused))
		{
			return Spell_Logic_Invest(slf, manaInvested, SPL_Cost, 3, TRUE);
		};
	};
	return Spell_Logic_Invest(slf, manaInvested, SPL_Cost, 2, TRUE);
};

func void Spell_Cast_Summon(var C_NPC slf, var int spellLevel, var int npcSummonInstance, var int playerSummonInstance, var int playerSummonInstance2) {
	if (!Npc_IsPlayer(slf))
	{
		Wld_SpawnNpcRange	(slf,	npcSummonInstance,			1,	500);
		slf.aivar[AIV_SelectSpell] += 1;
		return;
	};

	// Remove FX from aim vob
	GFA_AimVobDetachFX();

	// Spell was aborted by caster before it started ("arming" the spell not finished)
	if (spellLevel < 2) {
		return;
	};

	if (!Move_Blink_Waypoint(slf)) { return; };

	if (spellLevel > 2)
	{
		Wld_InsertNpc(playerSummonInstance2, SPL_BLINK_WP);
	}
	else
	{
		Wld_InsertNpc(playerSummonInstance, SPL_BLINK_WP);
	};
	
};
