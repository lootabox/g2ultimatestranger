

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

func void dot_apply(var int bh, var int total_damage) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    TAL_ModValue(n, TAL_DOT_TOTAL_DAMAGE, total_damage);
};

func void dot_tick(var int bh) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    var lCBuff b; b = get(bh);
    if (!Npc_IsInState(n, ZS_DEAD) && TAL_GetValue(n, TAL_DOT_TOTAL_DAMAGE) > 0)
    {
        if (n.attribute[ATR_HITPOINTS] > 1)
        {
            Npc_ChangeAttribute(n, ATR_HITPOINTS, -1);
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

func void venom_small_bloodfly_apply(var int bh) { dot_apply(bh, VENOM_SMALL_BLOODFLY_TOTAL_DAMAGE); };
func void venom_bloodfly_apply(var int bh) { dot_apply(bh, VENOM_BLOODFLY_TOTAL_DAMAGE); };
func void venom_swampdrone_explosion_apply(var int bh) { dot_apply(bh, VENOM_SWAMPDRONE_EXPLOSION_TOTAL_DAMAGE); };

instance venom_small_bloodfly(dot_prototype) {
    durationMS = 1000 * VENOM_SMALL_BLOODFLY_DURATION_SEC;
    tickMS = 1000 * VENOM_SMALL_BLOODFLY_DURATION_SEC / VENOM_SMALL_BLOODFLY_TOTAL_DAMAGE;
    OnApply = SAVE_GetFuncID(venom_small_bloodfly_apply);
};
instance venom_bloodfly(dot_prototype) {
    durationMS = 1000 * VENOM_BLOODFLY_DURATION_SEC;
    tickMS = 1000 * VENOM_BLOODFLY_DURATION_SEC / VENOM_BLOODFLY_TOTAL_DAMAGE;
    OnApply = SAVE_GetFuncID(venom_bloodfly_apply);
};
instance venom_swampdrone_explosion(dot_prototype) {
    durationMS = 1000 * VENOM_SWAMPDRONE_EXPLOSION_DURATION_SEC;
    tickMS = 1000 * VENOM_SWAMPDRONE_EXPLOSION_DURATION_SEC / VENOM_SWAMPDRONE_EXPLOSION_TOTAL_DAMAGE;
    OnApply = SAVE_GetFuncID(venom_swampdrone_explosion_apply);
};

//######################################################
// For smooth icecube dot
//######################################################

func void icecube_dot_1_apply(var int bh) { dot_apply(bh, 1 * SPL_FREEZE_DAMAGE); };
func void icecube_dot_2_apply(var int bh) { dot_apply(bh, 2 * SPL_FREEZE_DAMAGE); };
func void icecube_dot_3_apply(var int bh) { dot_apply(bh, 3 * SPL_FREEZE_DAMAGE); };
func void icecube_dot_4_apply(var int bh) { dot_apply(bh, 4 * SPL_FREEZE_DAMAGE); };
func void icecube_dot_5_apply(var int bh) { dot_apply(bh, 5 * SPL_FREEZE_DAMAGE); };
func void icecube_dot_6_apply(var int bh) { dot_apply(bh, 6 * SPL_FREEZE_DAMAGE); };
func void icecube_dot_7_apply(var int bh) { dot_apply(bh, 7 * SPL_FREEZE_DAMAGE); };
func void icecube_dot_8_apply(var int bh) { dot_apply(bh, 8 * SPL_FREEZE_DAMAGE); };
func void icecube_dot_9_apply(var int bh) { dot_apply(bh, 9 * SPL_FREEZE_DAMAGE); };
func void icecube_dot_10_apply(var int bh) { dot_apply(bh, 10 * SPL_FREEZE_DAMAGE); };
instance icecube_1_dot(dot_prototype) { durationMS = 1 * 1000; tickMS = 1000 / SPL_FREEZE_DAMAGE; OnApply = SAVE_GetFuncID(icecube_dot_1_apply); };
instance icecube_2_dot(dot_prototype) { durationMS = 2 * 1000; tickMS = 1000 / SPL_FREEZE_DAMAGE; OnApply = SAVE_GetFuncID(icecube_dot_2_apply); };
instance icecube_3_dot(dot_prototype) { durationMS = 3 * 1000; tickMS = 1000 / SPL_FREEZE_DAMAGE; OnApply = SAVE_GetFuncID(icecube_dot_3_apply); };
instance icecube_4_dot(dot_prototype) { durationMS = 4 * 1000; tickMS = 1000 / SPL_FREEZE_DAMAGE; OnApply = SAVE_GetFuncID(icecube_dot_4_apply); };
instance icecube_5_dot(dot_prototype) { durationMS = 5 * 1000; tickMS = 1000 / SPL_FREEZE_DAMAGE; OnApply = SAVE_GetFuncID(icecube_dot_5_apply); };
instance icecube_6_dot(dot_prototype) { durationMS = 6 * 1000; tickMS = 1000 / SPL_FREEZE_DAMAGE; OnApply = SAVE_GetFuncID(icecube_dot_6_apply); };
instance icecube_7_dot(dot_prototype) { durationMS = 7 * 1000; tickMS = 1000 / SPL_FREEZE_DAMAGE; OnApply = SAVE_GetFuncID(icecube_dot_7_apply); };
instance icecube_8_dot(dot_prototype) { durationMS = 8 * 1000; tickMS = 1000 / SPL_FREEZE_DAMAGE; OnApply = SAVE_GetFuncID(icecube_dot_8_apply); };
instance icecube_9_dot(dot_prototype) { durationMS = 9 * 1000; tickMS = 1000 / SPL_FREEZE_DAMAGE; OnApply = SAVE_GetFuncID(icecube_dot_9_apply); };
instance icecube_10_dot(dot_prototype) { durationMS = 10 * 1000; tickMS = 1000 / SPL_FREEZE_DAMAGE; OnApply = SAVE_GetFuncID(icecube_dot_10_apply); };

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
