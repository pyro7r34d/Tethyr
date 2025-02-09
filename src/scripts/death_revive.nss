#include "loi_functions"

void main()
{
object oPC = GetPCSpeaker();
string sPCName = GetName(oPC);
object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

string sBodyID = ObjectToString(oPC)+"BODY";
object oBody = GetObjectByTag(sBodyID);

    if(GetIsObjectValid(oBody) == TRUE)
    {
        effect eSanct = EffectSanctuary(35);
        int nHealed = GetMaxHitPoints(oPC);
        effect eHeal = EffectHeal(nHealed + 10);

        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oPC);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSanct,oPC,6.0f);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect( EffectCutsceneGhost()),oPC);
        EventRevivePCBody(oBody);
    }
    else
    {
        EventRespawnSafeNoBody(oPC);
    }
}
