/*
const int timerTickRate = 1000;

func void UltimateStrangerLoop() {
	// Only run ingame
	if (!Hlp_IsValidNpc(hero)) { return; };
	if (!MEM_Game.timestep) { return; };

	// Handle timer
	var int timer; timer += MEM_Timer.frameTime;
	if (timer < timerTickRate) { return; };
	timer = 0;

	//Print(IntToString(GetWaterLevel(hero)));
};

func void UltimateStrangerLoopInit() {
	MEM_InitAll();
	HookEngineF(oCGame__Render, 7, UltimateStrangerLoop);
};
*/