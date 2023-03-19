//::///////////////////////////////////////////////
//:: Tailor - Buy Outfit
//:: tlr_buyoutfit.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: March 8, 2004
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);

    int iCost = GetGoldPieceValue(oItem) * 2;

    TakeGoldFromCreature(0, oPC, TRUE);

    CopyItem(oItem, oPC, TRUE);
}
