//::///////////////////////////////////////////////
//:: FileName sc_006
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/2/2017 7:29:52 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "ConvNum") == 3))
		return FALSE;

	return TRUE;
}
