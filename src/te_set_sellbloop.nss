#include "te_settle_inc"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");

    int nTradeCount = GetLocalInt(oPC,TRADE_BLOODPURGE);

    if(nTradeCount >= 10)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }


}
