

//************************************************
// Transfer NPC inventory to a mob
// https://forum.worldofplayers.de/forum/threads/1337194-Gothic-2-Script-that-transfers-NPCs-inventory-to-hero?p=22540061&viewfull=1#post22540061
//************************************************

FUNC void B_TransferInventoryToMob(var C_Npc npc, var string mobName)
{
    var int itemInstance;
    var int slotNr;
    var int count;

    repeat(itemCategory, INV_CAT_MAX); var int itemCategory;
        slotNr = 0;
        count = Npc_GetInvItemBySlot(npc, itemCategory, slotNr);

        while(count > 0);
            itemInstance = Hlp_GetInstanceID(item);
            // slotNr += 1;
            Mob_CreateItems(mobName, itemInstance, count);
            NPC_RemoveInvItems(npc, itemInstance, count);

            // Get next item and count
            count = Npc_GetInvItemBySlot(npc, itemCategory, slotNr);
        end;
    end;
};

//************************************************
// Change level hook
// 
//************************************************

func void HookChangeLevel_Init() {
    HookEngineF(oCGame__ChangeLevel, 7, ChangeLevelHook);
};

func void ChangeLevelHook() {
    var string str1; str1 = MEM_ReadString(MEM_ReadInt(ESP + 4));
    var string str2; str2 = MEM_ReadString(MEM_ReadInt(ESP + 8));
    Print(ConcatStrings(ConcatStrings(str1, " -> "), str2));

    if (CurrentLevel == NEWWORLD_ZEN) && (Hlp_StrCmp(str1, "ADDON\ADDONWORLD.ZEN"))
    {
        B_TransferInventoryToMob(hero, "NEWWORLD_TO_ADDON_STORAGE");
    }
    else if (CurrentLevel == ADDONWORLD_ZEN) && (Hlp_StrCmp(str1, "NEWWORLD\NEWWORLD.ZEN"))
    {
        B_TransferInventoryToMob(hero, "ADDON_TO_NEWWORLD_STORAGE");
    };
};

//************************************************
// Method for getting walkmode
// https://forum.worldofplayers.de/forum/threads/1536360-S%C3%A4mtliche-schlafende-NPCs-und-Monster-ignorieren-den-Spieler-trotz-BS_RUN?p=26545844&viewfull=1#post26545844
//************************************************

FUNC int Npc_GetWalkMode (VAR C_NPC slf)
{
    var oCNpc oCNpc_slf;
    oCNpc_slf = Hlp_GetNpc(slf);

    var int wmode;
    const int oCAniCtrl_Human_walkmode_offset            = 352; //0x0160
    return MEM_ReadInt(oCNpc_slf.anictrl+oCAniCtrl_Human_walkmode_offset);
};

//************************************************
// Send quiet sound perceptions for strafing/jumping/backing up
// https://forum.worldofplayers.de/forum/threads/1536360-S%C3%A4mtliche-schlafende-NPCs-und-Monster-ignorieren-den-Spieler-trotz-BS_RUN/page2?p=26557935&viewfull=1#post26557935
//************************************************

var int hero_strafing;
var int hero_jumping;
var int hero_gobackward;

func void StrafePerception_Init() {
    const int oCNpc__EV_STRAFE_player_G1 = 7662588; //0x74EBFC
    const int oCNpc__EV_STRAFE_player_G2 = 6834660; //0x6849E4
    HookEngineF(MEMINT_SwitchG1G2(oCNpc__EV_STRAFE_player_G1, oCNpc__EV_STRAFE_player_G2), 7, StrafePerception);
};
func void StrafePerception() {
    // exit function if player is in sneak mode
    if (Npc_GetWalkMode(hero) == NPC_SNEAK)
    {
        return;
    };

    const int PERC_INVERVAL = 1000; // As in oCAIHuman::CreateFootStepSound
    var int percTimer; percTimer += MEM_Timer.frameTime;
    if (percTimer >= PERC_INVERVAL) {
        percTimer -= PERC_INVERVAL;
        hero_strafing = TRUE;
        Npc_SendPassivePerc(hero, PERC_ASSESSQUIETSOUND, hero, hero);
        hero_strafing = FALSE;
    };
};

func void JumpPerception_Init() {
    const int oCAniCtrl_Human__PC_JumpForward_G2 = 7020032; //0x6B1E00
    HookEngineF(oCAniCtrl_Human__PC_JumpForward_G2, 5, JumpPerception);
};
func void JumpPerception() {
    hero_jumping = TRUE;
    Npc_SendPassivePerc(hero, PERC_ASSESSQUIETSOUND, hero, hero);
    hero_jumping = FALSE;
};

func void GoBackwardPerception_Init() {
    // thanks to mud-freak and Kirides:
    // https://forum.worldofplayers.de/forum/threads/1536360-S%C3%A4mtliche-schlafende-NPCs-und-Monster-ignorieren-den-Spieler-trotz-BS_RUN?p=26545171&viewfull=1#post26545171
    
    // hooks in oCAniCtrl_Human::PC_GoBackward_G2
    //const int oCAniCtrl_Human__PC_GoBackward_G2 = 7019968; //0x6B1DC0
    //HookEngineF(oCAniCtrl_Human__PC_GoBackward_G2, 5, GoBackwardPerception); // causes bugs in collision with inclines
    HookEngineF(7044586, 6, hook__backward); // ANI_WALKMODE_RUN
    HookEngineF(7044556, 6, hook__backward); // ANI_WALKMODE_WALK
    //HookEngineF(7044526, 6, GoBackwardPerception); // ANI_WALKMODE_SNEAK

    // hooks in oCAIHuman::FightMelee
    HookEngineF(6911940 /* 006977c4 */, 5, GoBackwardPerception); // Gothic 1 Control (?)
    HookEngineF(6914029 /* 00697fed */, 5, GoBackwardPerception); // (?)
    HookEngineF(6914536 /* 006981e8 */, 6, GoBackwardPerception); // Gothic 2 Control (?)
};
func void GoBackwardPerception() {
    // exit function if player is in sneak mode
    if Npc_GetWalkMode(hero) == NPC_SNEAK
    {
        return;
    };
    hero_gobackward = TRUE;
    Npc_SendPassivePerc(hero, PERC_ASSESSQUIETSOUND, hero, hero);
    hero_gobackward = FALSE;
};
func void hook__backward() {
    const int npcPtr_offset = 300;
    var int npcPtr; npcPtr = MEM_ReadInt(ESI + npcPtr_offset);
    var c_npc npc; npc = _^(npcPtr);
    if (Npc_IsPlayer(npc))
    {
        GoBackwardPerception();
    };
};


//************************************************
// Spawning light spells above hero
// https://forum.worldofplayers.de/forum/threads/1559829-Licht-Zauber-nach-Laden-richtig-ausrichten?p=26475944&viewfull=1#post26475944
//************************************************

func void makeVobInvisible(var zCVob myVob)
{
    myVob.bitfield[0] = myVob.bitfield[0] & ~zCVob_bitfield0_castDynShadow; // schatten ausstellen
    myVob.bitfield[0] = myVob.bitfield[0] & ~zCVob_bitfield0_showVisual; // visual ausstellen
    myVob.bitfield[0] = myVob.bitfield[0] & ~zCVob_bitfield0_collDetectionDynamic; // dyn collision ausstellen
};

func void spawnLightAboveHero(var string fx) {
    if (!Hlp_IsValidNpc(hero)) {
        MEM_Info("spawnLightAboveHero: hero is invalid");
        return;
    };

    var int heroPtr; heroPtr = _@(hero);
    var zCVob vob; vob = _^(heroPtr);
    var int pos[3]; 
    var int dir[3]; 

    pos[0] = vob.trafoObjToWorld[ 3]; dir[0] = vob.trafoObjToWorld[ 2];
    pos[1] = vob.trafoObjToWorld[ 7]; dir[1] = vob.trafoObjToWorld[ 6];
    pos[2] = vob.trafoObjToWorld[11]; dir[2] = vob.trafoObjToWorld[10];

    var int LightParentPtr; LightParentPtr= MEM_SearchVobByName("LIGHTPARENT");
    if (!LightParentPtr) {
        LightParentPtr = InsertVobAsChildPos("LIGHTPARENT", "ItMi_DarkPearl.3ds", _@(pos), _@(dir), _@(hero));
    } else {
        AlignVobAt(LightParentPtr, _@(vob.trafoObjToWorld));
    };

    var zCVob Light_Vob; Light_Vob = _^(LightParentPtr);
    makeVobInvisible(Light_Vob);

    // Insert Light
    Wld_PlayEffect(fx, Light_Vob, Light_Vob, 0, 0, 0, FALSE);

    // Update position
    Light_Vob.trafoObjToWorld[7] = addf(Light_Vob.trafoObjToWorld[ 7], mkf(175)); // Set light-vob position
    AlignVobAt(LightParentPtr, _@(Light_Vob.trafoObjToWorld)); // update light-vob position
};

//************************************************
// Broadcasting methods
// https://forum.worldofplayers.de/forum/threads/775333-Script-Broadcasts?p=25881558&viewfull=1#post25881558
//************************************************

//************************************************
//   The Core: Iterating through Lists.
//************************************************

func void _BC_ForAll(var int funcID, var int sphereOnly) {
    MEM_InitAll(); //safety, don't know if user did it.

    var int busy;
    if (busy) {
        MEM_Error("Broadcast-System: Nesting is not allowed!");
        return;
    };
    
    busy = true;
    
    var C_NPC slfBak; slfBak = Hlp_GetNpc(self);
    var C_NPC othBak; othBak = Hlp_GetNpc(other);
    
    if (sphereOnly) {
        /* to speed things up (and do the filtering)
         * we only search the (small) active Vob List */
        var int i;    i    = 0;
        var int loop; loop = MEM_StackPos.position;
        
        if (i < MEM_World.activeVobList_numInArray) {
            var int vob;
            vob = MEM_ReadIntArray(MEM_World.activeVobList_array, i);
            
            if (Hlp_Is_oCNpc(vob)) {
                var C_NPC npc;
                npc = MEM_PtrToInst(vob);
                MEM_PushInstParam(npc);
                MEM_CallByID(funcID);
            };
            
            i += 1;
            MEM_StackPos.position = loop;
        };
    } else {
        /* walk through the entire Npc List (possibly large). */
        var int listPtr; listPtr = MEM_World.voblist_npcs;
        loop = MEM_StackPos.position;
        
        if (listPtr) {
            vob = MEM_ReadInt(listPtr + 4);
            
            if (Hlp_Is_oCNpc(vob)) {
                npc = MEM_PtrToInst(vob);
                MEM_PushInstParam(npc);
                MEM_CallByID(funcID);
            };
            
            listPtr = MEM_ReadInt(listPtr + 8);
            MEM_StackPos.position = loop;
        };
    };
    
    self  = Hlp_GetNpc(slfbak);
    other = Hlp_GetNpc(othbak);
    
    busy = false;
};

func void DoForAll    (var func _) {
    var MEMINT_HelperClass symb;
    var int theHandlerInt;
    theHandlerInt = MEM_ReadInt(MEM_ReadIntArray(contentSymbolTableAddress, symb - 1) + zCParSymbol_content_offset);

    _BC_ForAll(theHandlerInt, 0);
};

func void DoForSphere(var func _) {
    var MEMINT_HelperClass symb;
    var int theHandlerInt;
    theHandlerInt = MEM_ReadInt(MEM_ReadIntArray(contentSymbolTableAddress, symb - 1) + zCParSymbol_content_offset);
    
    _BC_ForAll(theHandlerInt, 1);
};

//************************************************
//   Building on that: The Broadcast
//************************************************

var int   _BC_funcID;
var int   _BC_CasterPtr;
var C_NPC _BC_Caster;
var int   _BC_ExcludeCaster;
var int   _BC_SendToDead;

func void _BC_CallAssessFunc(var C_NPC slf) {
    //ignore dead, unless they are explicitly included
    if (!slf.attribute[ATR_HITPOINTS] && !_BC_SendToDead) {
        return;
    };
    
    //ignore caster if this is wanted
    if (_BC_ExcludeCaster) {
        if (_BC_CasterPtr == MEM_InstToPtr(slf)) {
            return;
        };
    };
    
    MEM_PushInstParam(slf);
    MEM_PushInstParam(_BC_Caster);
    MEM_CallByID(_BC_funcID);
};

func void _BC_Broadcast(var C_NPC caster, var int funcID, var int excludeCaster, var int includeDead, var int includeShrinked) {
    _BC_ExcludeCaster = excludeCaster;
    _BC_Caster        = Hlp_GetNpc(caster);
    _BC_CasterPtr     = MEM_InstToPtr(caster);
    _BC_SendToDead    = includeDead;
    _BC_funcID        = funcID;
    
    if (includeShrinked) {
        DoForAll(_BC_CallAssessFunc);
    } else {
        DoForSphere(_BC_CallAssessFunc);
    };
};

func void Broadcast  (var C_NPC caster, var func _) {
    var MEMINT_HelperClass symb;
    var int reactionFuncID;
    reactionFuncID = MEM_ReadInt(MEM_ReadIntArray(contentSymbolTableAddress, symb - 1) + zCParSymbol_content_offset);
    
    _BC_Broadcast(caster, reactionFuncID, 0, 0, 0);
};

func void BroadcastEx(var C_NPC caster, var func _, var int excludeCaster, var int includeDead, var int includeShrinked) {
    var MEMINT_HelperClass symb;
    var int reactionFuncID;
    reactionFuncID = MEM_ReadInt(MEM_ReadIntArray(contentSymbolTableAddress, symb - 4) + zCParSymbol_content_offset);
    
    _BC_Broadcast(caster, reactionFuncID, excludeCaster, includeDead, includeShrinked);
};

//************************************************
// Methods for fetching dialog info, used to block dialog when npc's have nothing to say.
// https://forum.worldofplayers.de/forum/threads/1299679-Skriptpaket-Ikarus-4/page23?p=26035301&viewfull=1#post26035301
//************************************************

func int oCInfoManager_GetInfoCount (var int npcInstance, var int herInstance) //oCInfo *
{
    //00664A30  .text     Debug data           ?GetInfoCount@oCInfoManager@@QAEHPAVoCNpc@@0@Z
    const int oCInfoManager__GetInfoCount_G1 = 6703664;

    //0x00702940 public: int __thiscall oCInfoManager::GetInfoCount(class oCNpc *,class oCNpc *)
    const int oCInfoManager__GetInfoCount_G2 = 7350592;

    var int oCInfoManager__GetInfo;
    oCInfoManager__GetInfo = MEMINT_SwitchG1G2(oCInfoManager__GetInfoCount_G1, oCInfoManager__GetInfoCount_G2);
    
    var oCNpc slf;    slf = Hlp_GetNpc (npcInstance);
    var oCNpc her;    Her = Hlp_GetNpc (herInstance);
    
    CALL_PtrParam (MEM_InstToPtr (slf));
    CALL_PtrParam (MEM_InstToPtr (Her));
    CALL__thiscall (MEM_Game.infoman, oCInfoManager__GetInfo);
    
    return CALL_RetValAsPtr();
};

func int oCInfoManager_GetInfo (var int npcInstance, var int herInstance, var int index) //oCInfo *
{
    //00664E50  .text     Debug data           ?GetInfo@oCInfoManager@@QAEPAVoCInfo@@PAVoCNpc@@0H@Z
    const int oCInfoManager__GetInfo_G1 = 6704720;

    //0x00702D60 public: class oCInfo * __thiscall oCInfoManager::GetInfo(class oCNpc *,class oCNpc *,int)
    const int oCInfoManager__GetInfo_G2 = 7351648;
    
    var int oCInfoManager__GetInfo;
    oCInfoManager__GetInfo = MEMINT_SwitchG1G2(oCInfoManager__GetInfo_G1, oCInfoManager__GetInfo_G2);
    
    var oCNpc slf;    slf = Hlp_GetNpc (npcInstance);
    var oCNpc her;    Her = Hlp_GetNpc (herInstance);
    
    CALL_IntParam (index);
    CALL_PtrParam (MEM_InstToPtr (slf));
    CALL_PtrParam (MEM_InstToPtr (Her));
    CALL__thiscall (MEM_Game.infoman, oCInfoManager__GetInfo);
    
    return CALL_RetValAsPtr();
};

//************************************************
//  Hook for looting items
// https://forum.worldofplayers.de/forum/threads/1537258-Gothic1-Taschendiebstahl-Genauere-Analyse-und-Verbesserungspotential?p=26129042
//************************************************

func void HookLootItems_Init() {
    const int oCItemContainer__RemoveItem_G2 = 7378144; // 0x7094E0
    const int oCNpc__DoTakeVob_G2 = 7621056; // 0x7449C0
    HookEngineF(oCItemContainer__RemoveItem_G2, 6, _HookRemoveItem);
    HookEngineF(oCNpc__DoTakeVob_G2, 6, _HookDoTakeVob);
};

func void _HookRemoveItem()
{
    // Check for looting NPCs
    var oCNpc her; her = Hlp_GetNpc(hero);
    if(Hlp_Is_oCNpc(her.focus_vob)) {
        const int oCNpcInventory_inventory2_owner_offset_G2 = 160; // 0x0704 - 0x0668
        var C_NPC npc; npc = _^(MEM_ReadInt(ECX + oCNpcInventory_inventory2_owner_offset_G2));
        Print(ConcatStrings("Took item from ", npc.name));

        // check for steal
    } else {
        Print("Took item from container");
    };

    // Check for looted item(s)
    var C_ITEM itm; itm = _^(MEM_ReadInt (ESP + 4));
    Print(ConcatStrings("Item: ", itm.name));

    B_PlayerLootedItem(itm);

    // Close inventory (crashes)
    //CALL__thiscall(_@(npc), oCNpc__CloseInventory);
};

func void _HookDoTakeVob()
{
    // Check for looted item(s)
    var C_ITEM itm; itm = _^(MEM_ReadInt (ESP + 4));
    Print(ConcatStrings("Picked up ", itm.name));
    B_PlayerLootedItem(itm);
};


//************************************************
//   Prevent NPCs (mainly traders) from equipping "best" weapon if they already have a weapon equipped
// https://forum.worldofplayers.de/forum/threads/?p=25954713
//************************************************

func void FixEquipBestWeapons_Init() {
    const int once = 0;
    if (!once) {
        MEM_InitAll();

        const int oCNpc__Enable_equipBestWeapons_G1 = 6955616; //0x6A2260
        const int oCNpc__Enable_equipBestWeapons_G2 = 7626662; //0x745FA6
        var int addr; addr = MEMINT_SwitchG1G2(oCNpc__Enable_equipBestWeapons_G1, oCNpc__Enable_equipBestWeapons_G2);

        // Remove default equipping of best melee and ranged weapon to add more conditions
        const int nop20Bytes[5] = { -1869574000, -1869574000, -1869574000, -1869574000, -1869574000 }; //0x90 * 20
        MemoryProtectionOverride(addr, 18);
        MEM_CopyBytes(_@(nop20Bytes), addr, 18);

        HookEngineF(addr, 5, _FixEquipBestWeapons);

        once = 1;
    };
};

func void NpcEquipBestWeaponByType(var C_Npc npc, var int type) {
    const int oCNpc__EquipBestWeapon_G1 = 6988320; //0x6AA220
    const int oCNpc__EquipBestWeapon_G2 = 7663408; //0x74EF30
    var int npcPtr; npcPtr = _@(npc);
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(type));
        CALL__thiscall(_@(npcPtr), MEMINT_SwitchG1G2(oCNpc__EquipBestWeapon_G1, oCNpc__EquipBestWeapon_G2));
        call = CALL_End();
    };
};

func void _FixEquipBestWeapons() {
    var C_Npc npc; npc = _^(ESI);

    if (!Npc_HasEquippedMeleeWeapon(npc))
    && (!Npc_HasReadiedMeleeWeapon(npc)) {
        NpcEquipBestWeaponByType(npc, ITEM_KAT_NF);
    };

    if (!Npc_HasEquippedRangedWeapon(npc))
    && (!Npc_HasReadiedRangedWeapon(npc)) {
        NpcEquipBestWeaponByType(npc, ITEM_KAT_FF);
    };
};

//************************************************
//   Update status menu when opened
// https://forum.worldofplayers.de/forum/threads/1126551-Skriptpaket-LeGo-2/page11?p=20906914&viewfull=1#post20906914
//************************************************

func void Update_Menu_Item(var string name, var string val) {
    var int itPtr;
    itPtr = MEM_GetMenuItemByString(name);
    
    if (!itPtr) {
        MEM_Error(ConcatStrings("Update_Menu_Item: Invalid Menu Item: ", name));
        return;
    };
    
    //void __thiscall zCMenuItem::SetText(val = val, line = 0, drawNow = true)
    const int SetText = 5114800;
    
    CALL_IntParam(true);
    CALL_IntParam(0);
    CALL_zStringPtrParam(val);
    CALL__thiscall(itPtr, SetText);
};

func void Install_Character_Menu_Hook() {
    //at oCMenu_Status::SetLearnPoints
    const int done = false;
    if(!done) {
        HookEngineF(4707920, 6, Update_Character_Menu);
        done = true;
    };
};

// Returns "boosted/max (trained)" or "boosted (trained)" for given values
func string getAttributeString(var int boosted, var int max, var int trained)
{
    var string s; s = IntToString(boosted);
    if (max >= 0)
    {
        s = ConcatStrings(s, "/");
        s = ConcatStrings(s, IntToString(max));
    };
    if (trained > 0)
    {
        s = ConcatStrings(s, " (");
        s = ConcatStrings(s, IntToString(trained));
        s = ConcatStrings(s, ")");
    };
    return s;
};

func void Update_Character_Menu() {

    // Magic description
    if (hero.guild == GIL_PAL)
    {
        Update_Menu_Item("MENU_ITEM_TALENT_7_CIRCLE", "Paladin");
    }
    else if (hero.guild != GIL_KDF)
    {
        Update_Menu_Item("MENU_ITEM_TALENT_7_CIRCLE", "Scrolls");
    };

    // Replace Strength, Dexterity and Mana values
    Update_Menu_Item("MENU_ITEM_ATTRIBUTE_1_SCRIPTED", GetAttributeString(hero.attribute[ATR_STRENGTH], -1, hero.aivar[REAL_STRENGTH]));
    Update_Menu_Item("MENU_ITEM_ATTRIBUTE_2_SCRIPTED", GetAttributeString(hero.attribute[ATR_DEXTERITY], -1, hero.aivar[REAL_DEXTERITY]));
    Update_Menu_Item("MENU_ITEM_ATTRIBUTE_3_SCRIPTED", GetAttributeString(hero.attribute[ATR_MANA], hero.attribute[ATR_MANA_MAX], hero.aivar[REAL_MANA_MAX]));
};

//************************************************
//   Check whether creature is standing in water
// https://forum.worldofplayers.de/forum/threads/994505-Abfrage-Ob-Held-im-Wasser-steht?p=16075800&viewfull=1#post16075800
//************************************************
const int WATERLEVEL_NONE = 0; //Npc can run normally
const int WATERLEVEL_WADE = 1; //Npc must wade
const int WATERLEVEL_SWIM = 2; //Npc must swim
func int GetWaterLevel(var C_NPC slf) {
    var oCNpc ocslf;
    ocslf = Hlp_GetNpc(slf);
    var zCAIPlayer aip;
    aip = MEM_PtrToInst(ocslf.anictrl);
    return aip.waterLevel;
};


//************************************************
//   Initialize game settings for new game
//************************************************

func void InitUltimateStrangerSettings()
{
    var string optionsTopic; optionsTopic = "Game Options";
    var string optionValue;
    Log_CreateTopic(optionsTopic, LOG_NOTE);
    Log_AddEntry(optionsTopic, "This note is created for game options that cannot be changed during a game.");

    MEM_InitAll();
    MEM_Info("Initializing Ultimate Stranger game settings for new game.");

    // ---- hitpointGainPerLevel ----
    if (!MEM_GothOptExists("ULTIMATESTRANGER", "hitpointGainPerLevel")) {
        MEM_SetGothOpt("ULTIMATESTRANGER", "hitpointGainPerLevel", "0");
    };
    hitpointGainPerLevel = STR_ToInt (MEM_GetModOpt("ULTIMATESTRANGER", "hitpointGainPerLevel"));
    if      (hitpointGainPerLevel < 0) { hitpointGainPerLevel = 0; }
    else if (hitpointGainPerLevel > 4) { hitpointGainPerLevel = 4; };
    if      (hitpointGainPerLevel == 0) { optionValue = "default"; }
    else if (hitpointGainPerLevel == 1) { optionValue = "75%"; }
    else if (hitpointGainPerLevel == 2) { optionValue = "50%"; }
    else if (hitpointGainPerLevel == 3) { optionValue = "25%"; }
    else if (hitpointGainPerLevel == 4) { optionValue = "none"; };
    Log_AddEntry(optionsTopic, ConcatStrings("Hitpoint gain per level: ", optionValue));
};

//************************************************
//   Stop all sounds
// https://forum.worldofplayers.de/forum/threads/1299679-Skriptpaket-Ikarus-4/page18?p=25562544&viewfull=1#post25562544
//************************************************

func void stopAllSounds() {
    MEM_InitAll();

    const int zsound_G1 =  9236044; //0x8CEE4C 
    const int zsound_G2 = 10072124; //0x99B03C
    const int zCSndSys_MSS__RemoveAllActiveSounds_G1 = 5112224; //0x4E01A0 
    const int zCSndSys_MSS__RemoveAllActiveSounds_G2 = 5167008; //0x4ED7A0

    var int zsoundPtr; zsoundPtr = MEMINT_SwitchG1G2(MEM_ReadInt(zsound_G1), MEM_ReadInt(zsound_G2));
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL__thiscall(_@(zsoundPtr), MEMINT_SwitchG1G2(zCSndSys_MSS__RemoveAllActiveSounds_G1,
                                                        zCSndSys_MSS__RemoveAllActiveSounds_G2));
        call = CALL_End();
    };
};

//************************************************
//   Alpha-Vob Fix
// https://forum.worldofplayers.de/forum/threads/1039918-Skript-Mehr-Alpha-Vobs-und-Alpha-Polys-in-Gothic-2
//************************************************

func void MoreAlphaVobs(var int newCount) {
    MEM_InitAll();

    /* This is an alpha vob:
    
    class zCRndAlphaSortObject_Vob {
        var int _vtbl;
        var int nextSortObject; //zCRndAlphaSortObject_Vob*
        var int zvalue;         //zREAL
        var int vob;            //zCVob*
        var int alpha;          //zREAL
    };
    
    */
    const int sizeOf_zCRndAlphaSortObject_Vob = 20;
    const int zCRndAlphaSortObject_Vob__vtbl = 8592292; //0x831BA4
    
    const int newAlphaVobPool = 0; //wird jedes Laden zurückgesetzt
    
    //nur fixen wenn noch nicht gefixt.
    if (!newAlphaVobPool) {
        //neuer Pool der angegebenen Größe
        newAlphaVobPool = MEM_Alloc(sizeOf_zCRndAlphaSortObject_Vob * newCount);
        
        //Neue Liste bauen, dabei _vtbl und vob initialsieren.
        var int i; i = 0;
        var int loop; loop = MEM_StackPos.position;
        if (i < newCount) {
            var int theSortObj; theSortObj = newAlphaVobPool + i * sizeOf_zCRndAlphaSortObject_Vob;
            MEM_WriteInt(theSortObj +  0, zCRndAlphaSortObject_Vob__vtbl);
            MEM_WriteInt(theSortObj + 12, 0);
            i += 1;
            MEM_StackPos.position = loop;
        };
        
        //Vergleichsinstruktion:
        var int ptr; ptr = 5427853; //0x52D28D
        MemoryProtectionOverride(ptr, 4);
        MEM_WriteInt(ptr, newCount);
        
        //Der Indexzugriff
        ptr = 5427979; //0x52D30B
        MemoryProtectionOverride(ptr, 4);
        MEM_WriteInt(ptr, newAlphaVobPool);
        
        //Verschobener Indexzugriff
        ptr = 5427972; //0x52D304
        MemoryProtectionOverride(ptr, 4);
        MEM_WriteInt(ptr, newAlphaVobPool + 12);
    };
};

//************************************************
//   Alpha-Poly Fix
// https://forum.worldofplayers.de/forum/threads/1039918-Skript-Mehr-Alpha-Vobs-und-Alpha-Polys-in-Gothic-2
//************************************************

func void MoreAlphaPolys(var int newCount) {
    MEM_InitAll();

    const int sizeOf_zD3D_alphaPoly = 260; //die Teile sind recht groß! Man kriegt nur 4000 pro MB
    const int zD3D_alphaPoly__vtbl = 8631300; //0x83B404
    
    //nur anlegen wenn noch nicht geschehen.
    const int newAlphaPolyPool = 0;
    if (!newAlphaPolyPool) {
        newAlphaPolyPool = MEM_Alloc(sizeOf_zD3D_alphaPoly * newCount);
        
        //Neue Liste bauen (vtbl initialisieren).
        var int i; i = 0;
        var int loop; loop = MEM_StackPos.position;
        if (i < newCount) {
            MEM_WriteInt(newAlphaPolyPool + i * sizeOf_zD3D_alphaPoly, zD3D_alphaPoly__vtbl);
            i += 1;
            MEM_StackPos.position = loop;
        };
        
        //Den Vergleich fixen:
        var int ptr; ptr = 6605188; //0x64C984
        MemoryProtectionOverride(ptr, 4);
        MEM_WriteInt(ptr, newCount - 300); //warning-level (ab hier werden keine neuen Vobs angenommen).
        
        //Noch ein Vergleich
        ptr = 6605201; //0x64C991
        MemoryProtectionOverride(ptr, 4);
        MEM_WriteInt(ptr, newCount); //limit (ab hier: Fehlermeldung)
        
        //Fix XD3D_AlphaBlendPoly
        ptr = 6605403; //0x064CA5B
        
        //lea ebx, [ebx + newAlphaPolyPool]
        MemoryProtectionOverride(ptr, 7);
        MEM_WriteByte(ptr, 141); ptr += 1; //0x8D
        MEM_WriteByte(ptr, 155); ptr += 1; //0x9B
        MEM_WriteInt(ptr, newAlphaPolyPool); ptr += 4;
        MEM_WriteByte(ptr, 144); //0x90 = nop
        
        //Fix AddAlphaPoly
        ptr = 6607092; //0x064D0F4
        //lea ebx, [edx+newAlphaPolyPool
        MemoryProtectionOverride(ptr, 7);
        MEM_WriteByte(ptr, 141); ptr += 1; //0x8D
        MEM_WriteByte(ptr, 154); ptr += 1; //0x9A
        MEM_WriteInt(ptr, newAlphaPolyPool); ptr += 4;
        MEM_WriteByte(ptr, 144); //0x90 = nop
    };
};
