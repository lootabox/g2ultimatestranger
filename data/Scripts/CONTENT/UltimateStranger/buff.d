

//######################################################
// TALENTS
//######################################################

var int TAL_VENOM_TOTAL_DAMAGE;
func void InitBuffTalents() {
    if (!TAL_VENOM_TOTAL_DAMAGE) {
        TAL_VENOM_TOTAL_DAMAGE = TAL_CreateTalent();
    };
};

//######################################################
// Constants
//######################################################

const int VENOM_SMALL_BLOODFLY_TOTAL_DAMAGE = 10;
const int VENOM_SMALL_BLOODFLY_DURATION_SEC = 10;

const int VENOM_BLOODFLY_TOTAL_DAMAGE = 20;
const int VENOM_BLOODFLY_DURATION_SEC = 20;

const int VENOM_SWAMPDRONE_EXPLOSION_TOTAL_DAMAGE = 50;
const int VENOM_SWAMPDRONE_EXPLOSION_DURATION_SEC = 10;

//######################################################
// Venom general methods
//######################################################

func void TAL_ModValue(var c_npc n, var int talent, var int value) {
    var int next; next = TAL_GetValue(n, talent) + value;
    if (next < 0) {
        TAL_SetValue(n, talent, 0);
    } else {
        TAL_SetValue(n, talent, next);
    };
};

func void venom_apply(var int bh, var int total_damage) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    TAL_ModValue(n, TAL_VENOM_TOTAL_DAMAGE, total_damage);
};

func void venom_tick(var int bh) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    if (!Npc_IsInState(n, ZS_DEAD) && TAL_GetValue(n, TAL_VENOM_TOTAL_DAMAGE) > 0)
    {
        if (n.attribute[ATR_HITPOINTS] > 1)
        {
            Npc_ChangeAttribute(n, ATR_HITPOINTS, -1);
        };
        TAL_ModValue(n, TAL_VENOM_TOTAL_DAMAGE, -1);
    } else {
        TAL_SetValue(n, TAL_VENOM_TOTAL_DAMAGE, 0);
        Buff_Remove(bh); 
    };
};

func void venom_remove(var int bh) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
};

//######################################################
// Bloodfly / Swampgas drone venom
//######################################################

func void venom_small_bloodfly_apply(var int bh) { venom_apply(bh, VENOM_SMALL_BLOODFLY_TOTAL_DAMAGE); };
func void venom_bloodfly_apply(var int bh) { venom_apply(bh, VENOM_BLOODFLY_TOTAL_DAMAGE); };
func void venom_swampdrone_explosion_apply(var int bh) { venom_apply(bh, VENOM_SWAMPDRONE_EXPLOSION_TOTAL_DAMAGE); };

instance venom_small_bloodfly(lCBuff) {
    name = "";
    bufftype = BUFF_BAD;
    durationMS = 1000 * VENOM_SMALL_BLOODFLY_DURATION_SEC;
    tickMS = 1000 * VENOM_SMALL_BLOODFLY_DURATION_SEC / VENOM_SMALL_BLOODFLY_TOTAL_DAMAGE;
    OnApply = SAVE_GetFuncID(venom_small_bloodfly_apply);
    OnTick = SAVE_GetFuncID(venom_tick);
    OnRemoved = SAVE_GetFuncID(venom_remove);
};
instance venom_bloodfly(lCBuff) {
    name = "";
    bufftype = BUFF_BAD;
    durationMS = 1000 * VENOM_BLOODFLY_DURATION_SEC;
    tickMS = 1000 * VENOM_BLOODFLY_DURATION_SEC / VENOM_BLOODFLY_TOTAL_DAMAGE;
    OnApply = SAVE_GetFuncID(venom_bloodfly_apply);
    OnTick = SAVE_GetFuncID(venom_tick);
    OnRemoved = SAVE_GetFuncID(venom_remove);
};
instance venom_swampdrone_explosion(lCBuff) {
    name = "";
    bufftype = BUFF_BAD;
    durationMS = 1000 * VENOM_SWAMPDRONE_EXPLOSION_DURATION_SEC;
    tickMS = 1000 * VENOM_SWAMPDRONE_EXPLOSION_DURATION_SEC / VENOM_SWAMPDRONE_EXPLOSION_TOTAL_DAMAGE;
    OnApply = SAVE_GetFuncID(venom_swampdrone_explosion_apply);
    OnTick = SAVE_GetFuncID(venom_tick);
    OnRemoved = SAVE_GetFuncID(venom_remove);
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
