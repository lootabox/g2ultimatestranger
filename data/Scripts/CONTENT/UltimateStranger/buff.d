

//######################################################
// Buff talents
//######################################################

var int TAL_DOT_VENOM_TOTAL;    // Percentage
var int TAL_DOT_VENOM_SPEED;    // Percentage per second
var int TAL_DOT_BURN_TOTAL;     // Damage
var int TAL_DOT_BURN_TICK;      // Tick number
func void InitBuffTalents() {
    if (!TAL_DOT_VENOM_TOTAL) {
        TAL_DOT_VENOM_TOTAL = TAL_CreateTalent();
        TAL_DOT_VENOM_SPEED = TAL_CreateTalent();
        TAL_DOT_BURN_TOTAL = TAL_CreateTalent();
        TAL_DOT_BURN_TICK = TAL_CreateTalent();
    };
};

//######################################################
// Buff constants
//######################################################

const int BURN_DOT_VFX_DURATION_SEC = 4;
const int VENOM_DEFAULT_SPEED_PERCENTAGE = 4;

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

//######################################################
// DOT tick methods
//######################################################

func void dot_venom_tick(var int bh) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    var lCBuff b; b = get(bh);

    // Check whether envenomed
    var int venom_total; venom_total = TAL_GetValue(n, TAL_DOT_VENOM_TOTAL);
    if (n.attribute[ATR_HITPOINTS] > 0) && (venom_total > 0) {
        // Get speed
        var int speed; speed = TAL_GetValue(n, TAL_DOT_VENOM_SPEED);
        if      (speed > venom_total) { speed = venom_total; }
        else if (speed <= 0) { speed = VENOM_DEFAULT_SPEED_PERCENTAGE; };
        TAL_ModValue(n, TAL_DOT_VENOM_TOTAL, -speed);

        // Deal damage and check for murder
        var int dot; dot = n.attribute[ATR_HITPOINTS_MAX] * speed / 100;
        ptr = Buff_GetNpcOrigin(bh);
        if (!ptr) { Npc_ChangeAttribute (n, ATR_HITPOINTS, -dot); }
        else {
            var c_npc o; o = _^(ptr);
            B_MagicHurtNpc(o, n, dot);
            if (n.attribute[ATR_HITPOINTS] <= 0) {
                Npc_SendPassivePerc (o, PERC_ASSESSMURDER, o, o);
            };
        };
    } else {
        TAL_SetValue(n, TAL_DOT_VENOM_TOTAL, 0);
        Buff_Remove(bh);
    };
};

func void dot_burn_tick(var int bh) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    var lCBuff b; b = get(bh);

    // Calculate dot
    var int burn_total; burn_total = TAL_GetValue(n, TAL_DOT_BURN_TOTAL);
    if (n.attribute[ATR_HITPOINTS] > 0) && (burn_total) > 0 {
        var int burn_tick; burn_tick = TAL_GetValue(n, TAL_DOT_BURN_TICK);
        var int dot; dot = burn_total / (BURN_DOT_VFX_DURATION_SEC - burn_tick);
        TAL_ModValue(n, TAL_DOT_BURN_TOTAL, -dot);
        TAL_ModValue(n, TAL_DOT_BURN_TICK, 1);

        // Deal damage and check for murder
        ptr = Buff_GetNpcOrigin(bh);
        if (!ptr) { Npc_ChangeAttribute (n, ATR_HITPOINTS, -dot); }
        else {
            var c_npc o; o = _^(ptr);
            B_MagicHurtNpc(o, n, dot);
            if (n.attribute[ATR_HITPOINTS] <= 0) {
                Npc_SendPassivePerc (o, PERC_ASSESSMURDER, o, o);
            };
        };
    } else {
        TAL_SetValue(n, TAL_DOT_BURN_TOTAL, 0);
        TAL_SetValue(n, TAL_DOT_BURN_TICK, 0);
        Buff_Remove(bh);
    };
};

//######################################################
// DOT lCBuff's
//######################################################

instance dot_venom(lCBuff) {
    durationMS = 86400000;
    tickMS = 1000;
    OnTick = SAVE_GetFuncID(dot_venom_tick);
};

instance dot_burn(lCBuff) {
    durationMS = 86400000;
    tickMS = 1000;
    OnTick = SAVE_GetFuncID(dot_burn_tick);
};

//######################################################
// DOT apply / remove methods
//######################################################

// Venom is applied and removed in "counts"
func void dot_venom_apply(var c_npc npc, var int percentage, var c_npc origin) {
    Buff_RemoveAll(npc, dot_venom);
    TAL_ModValue(npc, TAL_DOT_VENOM_TOTAL, percentage);
    Buff_Apply(npc, dot_venom, origin);
};
func void dot_venom_remove(var c_npc npc, var int percentage) {
    TAL_ModValue(npc, TAL_DOT_VENOM_TOTAL, -percentage);
    if (TAL_GetValue(npc, TAL_DOT_VENOM_TOTAL) <= 0) {
        Buff_RemoveAll(npc, dot_venom);
        TAL_SetValue(npc, TAL_DOT_VENOM_TOTAL, 0);
    };
};

// Burn is applied by damage and can only be removed fully
func void dot_burn_apply(var c_npc npc, var int damage, var c_npc origin) {
    Buff_RemoveAll(npc, dot_burn);
    TAL_ModValue(npc, TAL_DOT_BURN_TOTAL, damage);
    TAL_SetValue(npc, TAL_DOT_BURN_TICK, 0);
    Buff_Apply(npc, dot_burn, origin);
    Wld_StopEffect_Ext("VOB_BURN", npc, npc, FALSE);
    Wld_PlayEffect ("VOB_BURN", npc, npc, 0, 0, 0, FALSE);
};
func void dot_burn_remove(var c_npc npc) {
    Buff_RemoveAll(npc, dot_venom);
    TAL_SetValue(npc, TAL_DOT_BURN_TOTAL, 0);
    TAL_SetValue(npc, TAL_DOT_BURN_TICK, 0);
    Wld_StopEffect_Ext("VOB_BURN", npc, npc, FALSE);
};

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
