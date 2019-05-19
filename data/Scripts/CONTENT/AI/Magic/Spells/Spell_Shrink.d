// **********
// SPL_Shrink
// **********

const int SPL_Cost_Shrink			= 100;
const int SPL_Shrink_Penalty		= 30; // 30%
const int SPL_Shrink_Size			= 30; // 30%
const int SPL_Shrink_Duration		= 3; // 3s

INSTANCE Spell_Shrink (C_Spell_Proto)
{
	time_per_mana			= 0;					//Wert wird nicht gebraucht - Spell wirkt INSTANT
	spelltype				= SPELL_NEUTRAL;
	targetCollectAlgo		= TARGET_COLLECT_FOCUS;
	targetCollectRange		= 1000;					//10m
};

func int Spell_Logic_Shrink	(var int manaInvested) 	//Parameter manaInvested wird hier nicht benutzt
{
	return Spell_Logic_Basic(self, SPL_Cost_Shrink);
};

func void Spell_Cast_Shrink()
{
	if (other.flags != NPC_FLAG_IMMORTAL)		//nicht auf Immortals
	&& (!C_NpcIsUndead(other)) 					//nicht auf Untote
	&& (other.guild > GIL_SEPERATOR_HUM)		//nicht auf Humans
	&& (other.aivar[AIV_MM_ShrinkState]==0)		//nur auf bisher ungeschrumpfte Monster!
	{		
		Npc_ClearAIQueue	(other);
		B_ClearPerceptions	(other);
		AI_StartState		(other, ZS_MagicShrink, 0, "");
	};
	
	Spell_Cast_Basic(self, SPL_Cost_Shrink);
};
