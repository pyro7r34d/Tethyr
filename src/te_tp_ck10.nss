int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCK1") > 5){return TRUE;} else {return FALSE;}
}
