//::///////////////////////////////////////////////
//:: FileName at_001
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/25/2016 3:49:47 PM
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{

	// Set the faction to hate the player, then attack the player
	AdjustReputation(GetPCSpeaker(), OBJECT_SELF, -100);
	DetermineCombatRound(GetPCSpeaker());
}
