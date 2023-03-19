//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Set hair to be changed
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////
#include "zep_cw_inc"

void main()
{
struct CW2da data = Get2daData();
object oTarget = data.target;
int nChannel = COLOR_CHANNEL_HAIR;
string sColor = IntToString(GetColor(oTarget, nChannel));

SetLocalInt(OBJECT_SELF, "CW_Channel", nChannel);
SetCustomToken(308, "hair");
SetCustomToken(309, sColor);
}
