void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    SetLocalInt(oItem,"BG_Select",5);

    //Rashemi
    SetLocalInt(oItem,"30",1);
    int nInt = GetLocalInt(oItem,"nLangSelect");

    SetLocalInt(oItem,"nLangSelect", nInt-1);
}

