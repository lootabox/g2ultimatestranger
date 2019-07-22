

//######################################################
// Buff talents
//######################################################

var int TAL_DOT_TOTAL_DAMAGE;
func void InitBuffTalents() {
    if (!TAL_DOT_TOTAL_DAMAGE) {
        TAL_DOT_TOTAL_DAMAGE = TAL_CreateTalent();
    };
};

//######################################################
// Buff constants
//######################################################

const int VENOM_SMALL_BLOODFLY_TOTAL_DAMAGE = 10;
const int VENOM_SMALL_BLOODFLY_DURATION_SEC = 10;

const int VENOM_BLOODFLY_TOTAL_DAMAGE = 20;
const int VENOM_BLOODFLY_DURATION_SEC = 20;

const int VENOM_SWAMPDRONE_EXPLOSION_TOTAL_DAMAGE = 50;
const int VENOM_SWAMPDRONE_EXPLOSION_DURATION_SEC = 10;

const int FIRE_SPELL_DOT_VFX_DURATION = 4000;

//######################################################
// DOT general methods and dot prototype
//######################################################

func void TAL_ModValue(var c_npc n, var int talent, var int value) {
    var int next; next = TAL_GetValue(n, talent) + value;
    if (next < 0) {
        TAL_SetValue(n, talent, 0);
    } else {
        TAL_SetValue(n, talent, next);
    };
};


func void dot_tick(var int bh) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    var lCBuff b; b = get(bh);
    // add total dot value
    if (b.nextTickNr == 1)
    {
        TAL_ModValue(n, TAL_DOT_TOTAL_DAMAGE, b.durationMS / b.tickMS);
        Print( ConcatStrings(IntToString( b.durationMS / b.tickMS ), " dot"));
    };

    // If dead, do something else
    if (!Npc_IsInState(n, ZS_DEAD) && TAL_GetValue(n, TAL_DOT_TOTAL_DAMAGE) > 0)
    {
        if (n.attribute[ATR_HITPOINTS] > 0)
        {
            ptr = Buff_GetNpcOrigin(bh);
            if (!ptr)
            {
                B_MagicHurtNpc(n, n, 1);
            }
            else
            {
                var c_npc o; o = _^(ptr);
                B_MagicHurtNpc(o, n, 1);
                if (n.attribute[ATR_HITPOINTS] == 0)
                {
                    Npc_SendPassivePerc (o, PERC_ASSESSMURDER, o, o);
                };
            };
        };
        TAL_ModValue(n, TAL_DOT_TOTAL_DAMAGE, -1);
    } else {
        TAL_SetValue(n, TAL_DOT_TOTAL_DAMAGE, 0);
        Buff_Remove(bh);
    };
};

func void dot_remove(var int bh) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    var lCBuff b; b = get(bh);
    TAL_ModValue(n, TAL_DOT_TOTAL_DAMAGE, -(b.durationMS / b.tickMS - (b.nextTickNr - 1)));
};

prototype dot_prototype(lCBuff) {
    name = "";
    bufftype = BUFF_BAD;
    OnTick = SAVE_GetFuncID(dot_tick);
    OnRemoved = SAVE_GetFuncID(dot_remove);
};

//######################################################
// Bloodfly / Swampgas drone venom
//######################################################

instance venom_small_bloodfly(dot_prototype) {
    durationMS = 1000 * VENOM_SMALL_BLOODFLY_DURATION_SEC;
    tickMS = 1000 * VENOM_SMALL_BLOODFLY_DURATION_SEC / VENOM_SMALL_BLOODFLY_TOTAL_DAMAGE;
};
instance venom_bloodfly(dot_prototype) {
    durationMS = 1000 * VENOM_BLOODFLY_DURATION_SEC;
    tickMS = 1000 * VENOM_BLOODFLY_DURATION_SEC / VENOM_BLOODFLY_TOTAL_DAMAGE;
};
instance venom_swampdrone_explosion(dot_prototype) {
    durationMS = 1000 * VENOM_SWAMPDRONE_EXPLOSION_DURATION_SEC;
    tickMS = 1000 * VENOM_SWAMPDRONE_EXPLOSION_DURATION_SEC / VENOM_SWAMPDRONE_EXPLOSION_TOTAL_DAMAGE;
};

//######################################################
// For smooth icecube dot
//######################################################

instance icecube_dot_4(dot_prototype)  { durationMS = 1 * 1000;     tickMS = 1000 / SPL_FREEZE_DAMAGE; };
instance icecube_dot_8(dot_prototype)  { durationMS = 2 * 1000;     tickMS = 1000 / SPL_FREEZE_DAMAGE; };
instance icecube_dot_12(dot_prototype) { durationMS = 3 * 1000;     tickMS = 1000 / SPL_FREEZE_DAMAGE; };
instance icecube_dot_16(dot_prototype) { durationMS = 4 * 1000;     tickMS = 1000 / SPL_FREEZE_DAMAGE; };
instance icecube_dot_20(dot_prototype) { durationMS = 5 * 1000;     tickMS = 1000 / SPL_FREEZE_DAMAGE; };
instance icecube_dot_24(dot_prototype) { durationMS = 6 * 1000;     tickMS = 1000 / SPL_FREEZE_DAMAGE; };
instance icecube_dot_28(dot_prototype) { durationMS = 7 * 1000;     tickMS = 1000 / SPL_FREEZE_DAMAGE; };
instance icecube_dot_32(dot_prototype) { durationMS = 8 * 1000;     tickMS = 1000 / SPL_FREEZE_DAMAGE; };
instance icecube_dot_36(dot_prototype) { durationMS = 9 * 1000;     tickMS = 1000 / SPL_FREEZE_DAMAGE; };
instance icecube_dot_40(dot_prototype) { durationMS = 10 * 1000;    tickMS = 1000 / SPL_FREEZE_DAMAGE; };


//######################################################
// Fire spell burn
//######################################################

instance fire_spell_dot_4(dot_prototype)  { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 4;    durationMS = FIRE_SPELL_DOT_VFX_DURATION;};
instance fire_spell_dot_8(dot_prototype)  { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 8;    durationMS = FIRE_SPELL_DOT_VFX_DURATION;};
instance fire_spell_dot_12(dot_prototype) { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 12;   durationMS = FIRE_SPELL_DOT_VFX_DURATION;};
instance fire_spell_dot_16(dot_prototype) { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 16;   durationMS = FIRE_SPELL_DOT_VFX_DURATION;};
instance fire_spell_dot_20(dot_prototype) { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 20;   durationMS = FIRE_SPELL_DOT_VFX_DURATION;};
instance fire_spell_dot_24(dot_prototype) { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 24;   durationMS = FIRE_SPELL_DOT_VFX_DURATION;};
instance fire_spell_dot_28(dot_prototype) { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 28;   durationMS = FIRE_SPELL_DOT_VFX_DURATION;};
instance fire_spell_dot_32(dot_prototype) { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 32;   durationMS = FIRE_SPELL_DOT_VFX_DURATION;};
instance fire_spell_dot_36(dot_prototype) { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 36;   durationMS = FIRE_SPELL_DOT_VFX_DURATION;};
instance fire_spell_dot_40(dot_prototype) { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 40;   durationMS = FIRE_SPELL_DOT_VFX_DURATION;};
instance fire_spell_dot_44(dot_prototype) { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 44;   durationMS = FIRE_SPELL_DOT_VFX_DURATION;};
instance fire_spell_dot_48(dot_prototype) { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 48;   durationMS = FIRE_SPELL_DOT_VFX_DURATION;};
instance fire_spell_dot_52(dot_prototype) { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 52;   durationMS = FIRE_SPELL_DOT_VFX_DURATION;};
instance fire_spell_dot_56(dot_prototype) { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 56;   durationMS = FIRE_SPELL_DOT_VFX_DURATION;};
instance fire_spell_dot_60(dot_prototype) { tickMS = FIRE_SPELL_DOT_VFX_DURATION / 60;   durationMS = FIRE_SPELL_DOT_VFX_DURATION;};

//######################################################
// Special
//######################################################
/* 
func void well_rested_apply(var int bh) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    if (Npc_IsPlayer(n)) {
        disableSaving = false;
        EnforceSavingPolicy();
    };
};

func void well_rested_removed(var int bh) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    if (Npc_IsPlayer(n)) {
        disableSaving = true;
        EnforceSavingPolicy();
    };
};

instance well_rested(lCBuff) {
    name = "";
    bufftype = BUFF_GOOD;
    durationMS = 10*1000;
    OnApply = SAVE_GetFuncID(well_rested_apply);
    OnRemoved = SAVE_GetFuncID(well_rested_removed);
};
*/
