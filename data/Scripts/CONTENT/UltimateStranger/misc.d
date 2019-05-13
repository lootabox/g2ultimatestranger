

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
//   Displaying blunt protection in status screen
// https://forum.worldofplayers.de/forum/threads/1424424-Hooking-status-screen
// https://forum.worldofplayers.de/forum/threads/1449798-Wasting-time-in-a-function
//************************************************
const int oCNpc__OpenScreen_Status = 7592320; //0x73D980
const int oCNpc__CloseScreen_Status = 4714092; //0x47EE6

func void StatusScreen()
{
    if (!Hlp_IsValidNpc(hero)) { return; };
    var int prot; prot = hero.protection[PROT_EDGE];
    if (prot > 200) { prot = 201; }; // 201+1 = "200+"
    Npc_SetTalentSkill(hero, NPC_TALENT_C, prot+1);
};

func void InitStatusScreenHook()
{
    HookEngineF(oCNpc__OpenScreen_Status, 7, StatusScreen);
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
//   Equip/unequip weapon
// https://themodders.org/index.php?topic=21691.0
//************************************************

func void Equip_Item (var C_NPC slf, var int item)
{
    if (! Npc_HasItems (slf, item))
    {
        CreateInvItems (slf, item, 1);
    };

    CALL_PtrParam (MEM_InstToPtr (item));
    CALL__thiscall (MEM_InstToPtr (slf), 7545792);
};

func void Unequip_Item (var C_NPC slf, var int item)
{
    CALL_PtrParam (MEM_InstToPtr (item));
    CALL__thiscall (MEM_InstToPtr (slf), 7546560);
};

//************************************************
//   Stop all sounds
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