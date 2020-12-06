
// Common stuff
var int temp_info;
var int temp_limit;
var func temp_callback;
func int DIA_LearnAttribute_Condition(var int attribute, var int limit) {
	if	(attribute == ATR_STRENGTH && other.aivar[REAL_STRENGTH] < limit)
	 || (attribute == ATR_DEXTERITY && other.aivar[REAL_DEXTERITY] < limit)
	 || (attribute == ATR_MANA_MAX && other.aivar[REAL_MANA_MAX] < limit)
	{ return TRUE; };
	return FALSE;
};
func VOID DIA_LearnAttribute_BACK()	{
	Info_ClearChoices (temp_info);
};

// Strength
func void B_AddInfoLearnAttribute_STR(var int info, var int limit, var func callback) {
	temp_info = info;
	temp_limit = limit;
	temp_callback = callback;
	Info_ClearChoices (info);
	Info_AddChoice	(info, DIALOG_BACK, DIA_LearnAttribute_BACK);
	Info_AddChoice	(info, B_BuildLearnString(PRINT_LearnSTR1	, B_GetLearnCostAttribute2(other,ATR_STRENGTH,1))	,DIA_LearnAttribute_STR_1);
	Info_AddChoice	(info, B_BuildLearnString(PRINT_LearnSTR5	, B_GetLearnCostAttribute2(other,ATR_STRENGTH,5))	,DIA_LearnAttribute_STR_5);
};
func VOID DIA_LearnAttribute_STR_1() {
	B_TeachAttributePoints (self, other, ATR_STRENGTH, 1, temp_limit);
	B_AddInfoLearnAttribute_STR (temp_info, temp_limit, temp_callback);
};
func VOID DIA_LearnAttribute_STR_5() {
	B_TeachAttributePoints (self, other, ATR_STRENGTH, 5, temp_limit);
	B_AddInfoLearnAttribute_STR (temp_info, temp_limit, temp_callback);
};

// Dexterity
func void B_AddInfoLearnAttribute_DEX(var int info, var int limit, var func callback) {
	temp_info = info;
	temp_limit = limit;
	temp_callback = callback;
	Info_ClearChoices (info);
	Info_AddChoice	(info, DIALOG_BACK, DIA_LearnAttribute_BACK);
	Info_AddChoice	(info, B_BuildLearnString(PRINT_LearnDEX1	, B_GetLearnCostAttribute2(other,ATR_DEXTERITY,1))	,DIA_LearnAttribute_DEX_1);
	Info_AddChoice	(info, B_BuildLearnString(PRINT_LearnDEX5	, B_GetLearnCostAttribute2(other,ATR_DEXTERITY,5))	,DIA_LearnAttribute_DEX_5);
};
func VOID DIA_LearnAttribute_DEX_1() {
	B_TeachAttributePoints (self, other, ATR_DEXTERITY, 1, temp_limit);
	B_AddInfoLearnAttribute_DEX (temp_info, temp_limit, temp_callback);
};
func VOID DIA_LearnAttribute_DEX_5() {
	B_TeachAttributePoints (self, other, ATR_DEXTERITY, 5, temp_limit);
	B_AddInfoLearnAttribute_DEX (temp_info, temp_limit, temp_callback);
};

// Mana
func void B_AddInfoLearnAttribute_MANA(var int info, var int limit, var func callback) {
	temp_info = info;
	temp_limit = limit;
	temp_callback = callback;
	Info_ClearChoices (info);
	Info_AddChoice	(info, DIALOG_BACK, DIA_LearnAttribute_BACK);
	Info_AddChoice	(info, B_BuildLearnString(PRINT_LearnMANA1	, B_GetLearnCostAttribute2(other,ATR_MANA_MAX,1))	,DIA_LearnAttribute_MANA_1);
	Info_AddChoice	(info, B_BuildLearnString(PRINT_LearnMANA5	, B_GetLearnCostAttribute2(other,ATR_MANA_MAX,5))	,DIA_LearnAttribute_MANA_5);
};
func VOID DIA_LearnAttribute_MANA_1() {
	B_TeachAttributePoints (self, other, ATR_DEXTERITY, 1, temp_limit);
	B_AddInfoLearnAttribute_MANA (temp_info, temp_limit, temp_callback);
};
func VOID DIA_LearnAttribute_MANA_5() {
	B_TeachAttributePoints (self, other, ATR_DEXTERITY, 5, temp_limit);
	B_AddInfoLearnAttribute_MANA (temp_info, temp_limit, temp_callback);
};
