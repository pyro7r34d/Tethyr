//::///////////////////////////////////////////////
//:: Player Tool 5 Instant Feat
//:: x3_pl_tool05
//:: Copyright (c) 2007 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is a blank feat script for use with the
    10 Player instant feats provided in NWN v1.69.

    Look up feats.2da, spells.2da and iprp_feats.2da

*/
//:://////////////////////////////////////////////
//:: Created By: Brian Chung
//:: Created On: 2007-12-05
//:://////////////////////////////////////////////

void main()
{
    object oPC = OBJECT_SELF;
    ActionStartConversation(OBJECT_SELF,"te_callforhelp",TRUE,FALSE);
}
