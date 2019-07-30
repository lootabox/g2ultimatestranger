

//######################################################
// Buff talents
//######################################################

var int TAL_DOT_VENOM;
var int TAL_DOT_BURN;
var int TAL_DOT_FREEZE;
func void InitBuffTalents() {
    if (!TAL_DOT_VENOM) {
        TAL_DOT_VENOM = TAL_CreateTalent();
        TAL_DOT_BURN = TAL_CreateTalent();
        TAL_DOT_FREEZE = TAL_CreateTalent();
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

const int FIRE_SPELL_DOT_VFX_DURATION_MS = 4000;

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
// Bloodfly / Swampgas drone venom
//######################################################

func void venom_dot_apply(var int bh, var int total_damage) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    TAL_ModValue(n, TAL_DOT_VENOM, total_damage);
};

func void venom_dot_tick(var int bh) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    var lCBuff b; b = get(bh);

    if (n.attribute[ATR_HITPOINTS] > 0 && TAL_GetValue(n, TAL_DOT_VENOM) > 0)
    {
        ptr = Buff_GetNpcOrigin(bh);
        if (!ptr)
        {
            Npc_ChangeAttribute (n, ATR_HITPOINTS, -1);
        }
        else
        {
            var c_npc o; o = _^(ptr);
            B_MagicHurtNpc(o, n, 1);
            if (n.attribute[ATR_HITPOINTS] <= 0)
            {
                Npc_SendPassivePerc (o, PERC_ASSESSMURDER, o, o);
            };
        };
        TAL_ModValue(n, TAL_DOT_VENOM, -1);
    } else {
        TAL_SetValue(n, TAL_DOT_VENOM, 0);
        Buff_Remove(bh);
    };
};

func void venom_dot_remove(var int bh) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    var lCBuff b; b = get(bh);
    TAL_ModValue(n, TAL_DOT_VENOM, -(b.durationMS / b.tickMS - (b.nextTickNr - 1)));
};

func void venom_small_bloodfly_apply(var int bh)        { venom_dot_apply(bh, VENOM_SMALL_BLOODFLY_TOTAL_DAMAGE); };
func void venom_bloodfly_apply(var int bh)              { venom_dot_apply(bh, VENOM_BLOODFLY_TOTAL_DAMAGE); };
func void venom_swampdrone_explosion_apply(var int bh)  { venom_dot_apply(bh, VENOM_SWAMPDRONE_EXPLOSION_TOTAL_DAMAGE); };

instance venom_small_bloodfly(lCBuff) {
    durationMS = 1000 * VENOM_SMALL_BLOODFLY_DURATION_SEC;
    tickMS = 1000 * VENOM_SMALL_BLOODFLY_DURATION_SEC / VENOM_SMALL_BLOODFLY_TOTAL_DAMAGE;
    OnApply = SAVE_GetFuncID(venom_small_bloodfly_apply);
    OnRemoved = SAVE_GetFuncID(venom_dot_remove);
};
instance venom_bloodfly(lCBuff) {
    durationMS = 1000 * VENOM_BLOODFLY_DURATION_SEC;
    tickMS = 1000 * VENOM_BLOODFLY_DURATION_SEC / VENOM_BLOODFLY_TOTAL_DAMAGE;
    OnApply = SAVE_GetFuncID(venom_bloodfly_apply);
    OnRemoved = SAVE_GetFuncID(venom_dot_remove);
};
instance venom_swampdrone_explosion(lCBuff) {
    durationMS = 1000 * VENOM_SWAMPDRONE_EXPLOSION_DURATION_SEC;
    tickMS = 1000 * VENOM_SWAMPDRONE_EXPLOSION_DURATION_SEC / VENOM_SWAMPDRONE_EXPLOSION_TOTAL_DAMAGE;
    OnApply = SAVE_GetFuncID(venom_swampdrone_explosion_apply);
    OnRemoved = SAVE_GetFuncID(venom_dot_remove);
};

//######################################################
// For smooth icecube dot
//######################################################

func void freeze_dot_tick(var int bh) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    var lCBuff b; b = get(bh);

    if (n.attribute[ATR_HITPOINTS] > 0 && TAL_GetValue(n, TAL_DOT_FREEZE) > 0)
    {
        var int tickdmg; tickdmg = TAL_GetValue(n, TAL_DOT_FREEZE);
        if (tickdmg > SPL_FREEZE_DAMAGE) { tickdmg = SPL_FREEZE_DAMAGE; };
        ptr = Buff_GetNpcOrigin(bh);
        if (!ptr)
        {
            Npc_ChangeAttribute (n, ATR_HITPOINTS, -tickdmg);
        }
        else
        {
            var c_npc o; o = _^(ptr);
            B_MagicHurtNpc(o, n, tickdmg);
            if (n.attribute[ATR_HITPOINTS] <= 0)
            {
                Npc_SendPassivePerc (o, PERC_ASSESSMURDER, o, o);
            };
        };
        TAL_ModValue(n, TAL_DOT_FREEZE, -tickdmg);
    } else {
        TAL_SetValue(n, TAL_DOT_FREEZE, 0);
        Buff_Remove(bh);
    };
};

func void freeze_dot_remove(var int bh) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    Wld_StopEffect_Ext("spellFX_IceSpell_SENDPERCEPTION", 0, n, FALSE); // doesnt work
};

instance freeze_dot(lCBuff)
{
    durationMS = 3600000; // 1h
    tickMS = 1000;
    OnTick = SAVE_GetFuncID(freeze_dot_tick);
    OnRemoved = SAVE_GetFuncID(freeze_dot_remove);
};

func void freeze_dot_apply(var c_npc npc, var int total_damage, var c_npc origin)
{
    Buff_RemoveAll(npc, freeze_dot);
    TAL_SetValue(npc, TAL_DOT_FREEZE, total_damage);
    Buff_Apply(npc, freeze_dot, origin);
};

//######################################################
// Fire spell burn
//######################################################

func void burn_dot_tick(var int bh) {
    var int ptr; ptr = Buff_GetNpc(bh); if (!ptr) { return; }; var c_npc n; n = _^(ptr);
    var lCBuff b; b = get(bh);

    if (n.attribute[ATR_HITPOINTS] > 0 && TAL_GetValue(n, TAL_DOT_BURN) > 0)
    {
        var int tickdmg; tickdmg = (TAL_GetValue(n, TAL_DOT_BURN)) / (b.durationMS / b.tickMS - (b.nextTickNr - 1));
        ptr = Buff_GetNpcOrigin(bh);
        if (!ptr)
        {
            Npc_ChangeAttribute (n, ATR_HITPOINTS, -tickdmg);
        }
        else
        {
            var c_npc o; o = _^(ptr);
            B_MagicHurtNpc(o, n, tickdmg);
            if (n.attribute[ATR_HITPOINTS] <= 0)
            {
                Npc_SendPassivePerc (o, PERC_ASSESSMURDER, o, o);
            };
        };
        TAL_ModValue(n, TAL_DOT_BURN, -tickdmg);
    } else {
        TAL_SetValue(n, TAL_DOT_BURN, 0);
        Buff_Remove(bh);
    };
};

instance burn_dot(lCBuff)
{
    durationMS = FIRE_SPELL_DOT_VFX_DURATION_MS;
    tickMS = 1000;
    OnTick = SAVE_GetFuncID(burn_dot_tick);
};

func void burn_dot_apply(var c_npc npc, var int total_damage, var c_npc origin)
{
    Buff_RemoveAll(npc, burn_dot);
    TAL_ModValue(npc, TAL_DOT_BURN, total_damage);
    Buff_Apply(npc, burn_dot, origin);
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
