int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    int iEntUp = GetLocalInt(oItem,"te_ent_up");

    if(iEntUp == 1)
        return TRUE;

    return FALSE;


}
