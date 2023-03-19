//::///////////////////////////////////////////////
//:: Bolt: Web
//:: NW_S1_BltWeb
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Glues a single target to the ground with
    sticky strands of webbing.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 28, 2002
//:: Updated On: July 15, 2003 Georg Zoeller - Removed saving throws
//:: Updated On: 9/8/19 by DM Djinn Knights of Noromath
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_switches"
void main()
{
    object oTarget = GetSpellTargetObject();
    int nHD = GetHitDice(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_DUR_WEB);
    effect eStick = EffectSlow();
    effect eLink = EffectLinkEffects(eVis, eStick);

    int nDC = 10 + ((nHD/2) + (GetAbilityModifier(ABILITY_CONSTITUTION, OBJECT_SELF)));
    int nCount = ((nHD/2) + (GetAbilityModifier(ABILITY_CONSTITUTION, OBJECT_SELF)));

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BOLT_SLOW));
    //Make a saving throw check
    if (TouchAttackRanged(oTarget))
    {
       if( !GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) && GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_IS_INCORPOREAL) != TRUE )
       {
           //Apply the VFX impact and effects
           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCount));
        }
    }
}
