//::///////////////////////////////////////////////
//:: Example Item Event Script
//:: x2_it_example
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is an example on how to use the
    new default module events for NWN to
    have all code concerning one item in
    a single file.

    Note that this system only works, if
    the following events set on your module

    OnEquip      - x2_mod_def_equ
    OnUnEquip    - x2_mod_def_unequ
    OnAcquire    - x2_mod_def_aqu
    OnUnAcqucire - x2_mod_def_unaqu
    OnActivate   - x2_mod_def_act

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-10
//:://////////////////////////////////////////////

#include "x2_inc_switches"

void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oTarget;
    int nDC;
    effect ePoison = GetFirstEffect(oTarget);
    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);

    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
        oTarget = GetItemActivatedTarget();
        nDC = 30;

        if (!GetIsInCombat(oPC))
        {
            if (GetHasFeat(1161,oPC))
            {
                nDC = 20;
            }

            if (GetIsSkillSuccessful(oPC,SKILL_HEAL, nDC))
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(d4(2)),oTarget);
                SendMessageToPC(oPC, "You successfully staunch the flow of blood.");
            }
            else
            {
                SendMessageToPC(oPC, "You are not able to staunch the flow of blood.");
            }
        }
        else
        {
            SendMessageToPC(oPC,"You may not use this item while in combat.");
        }
    }

}
