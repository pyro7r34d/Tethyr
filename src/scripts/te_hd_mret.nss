#include "loi_xp"

void main()
{
    object oPC = GetPCSpeaker();
    object oSet = OBJECT_SELF;

    if((GetTag(oSet) == "te_npc_2176") && (GetItemPossessedBy(oPC,"te_sm_001") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_001"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}
    if((GetTag(oSet) == "te_npc_2177") && (GetItemPossessedBy(oPC,"te_sm_002") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_002"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}
    if((GetTag(oSet) == "te_npc_2184") && (GetItemPossessedBy(oPC,"te_sm_003") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_003"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}
    if((GetTag(oSet) == "te_npc_2185") && (GetItemPossessedBy(oPC,"te_sm_004") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_004"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}
    if((GetTag(oSet) == "te_npc_2186") && (GetItemPossessedBy(oPC,"te_sm_005") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_005"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}
    if((GetTag(oSet) == "te_npc_2187") && (GetItemPossessedBy(oPC,"te_sm_006") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_006"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}
    if((GetTag(oSet) == "te_npc_2192") && (GetItemPossessedBy(oPC,"te_sm_007") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_007"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}
    if((GetTag(oSet) == "te_npc_2193") && (GetItemPossessedBy(oPC,"te_sm_008") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_008"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}
    if((GetTag(oSet) == "te_npc_2196") && (GetItemPossessedBy(oPC,"te_sm_009") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_009"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}
    if((GetTag(oSet) == "te_npc_2198") && (GetItemPossessedBy(oPC,"te_sm_010") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_010"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}
    if((GetTag(oSet) == "te_npc_2200") && (GetItemPossessedBy(oPC,"te_sm_011") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_011"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}
    if((GetTag(oSet) == "te_npc_2150") && (GetItemPossessedBy(oPC,"te_sm_012") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_012"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}
    if((GetTag(oSet) == "te_npc_2151") && (GetItemPossessedBy(oPC,"te_sm_013") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_013"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}
    if((GetTag(oSet) == "te_npc_2152") && (GetItemPossessedBy(oPC,"te_sm_014") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_014"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}
    if((GetTag(oSet) == "te_npc_2153") && (GetItemPossessedBy(oPC,"te_sm_015") != OBJECT_INVALID)){DestroyObject(GetItemPossessedBy(oPC,"te_sm_015"));GiveGoldToCreature(oPC,25); AwardXP(oPC,25);}

}

