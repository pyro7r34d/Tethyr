//::///////////////////////////////////////////////
//:: FileName BG 1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: 10/20/17
//:://////////////////////////////////////////////
#include "NWNX_Creature"
#include "NWNX_Creature"

void main()
{
    object oPC = GetPCSpeaker();
    int iFeat = 1457;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    SetLocalInt(oItem, "PC_ECL",0);
    SetSubRace(oPC, "Strongheart Halfling");
    NWNX_Creature_AddFeatByLevel(oPC,iFeat,1);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",1);
    ActionStartConversation(oPC,"bg_class",TRUE);
}
