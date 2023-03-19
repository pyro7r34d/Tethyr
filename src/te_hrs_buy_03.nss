#include "x3_inc_horse"
void main()
{
    object oPC   = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oCreature;

    if(GetGold(oPC) >=100)
    {
        TakeGoldFromCreature(100,oPC,TRUE);
        SetLocalInt(oItem,"hrs_03",TRUE);
        SetLocalInt(oPC,"hrs_03",TRUE);

    if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_lightbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_03",GetLocation(oPC),oPC,"",499);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_medbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_03",GetLocation(oPC),oPC,"",500);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_heabard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_03",GetLocation(oPC),oPC,"",501);
    }
    else
    {
        oCreature = HorseCreateHorse("hrs_03",GetLocation(oPC),oPC,"",497);
    }

    SetLocalInt(oCreature,"X3_HORSE_MOUNT_SPEED",60);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_DWARF",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_GNOME",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFLING",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFORC",TRUE);
    }
}
