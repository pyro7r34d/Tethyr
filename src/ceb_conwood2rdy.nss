int StartingConditional()
{
object oPC = GetPCSpeaker();
object oBox = GetItemPossessedBy(oPC, "ceb_crcraftbox");
int nCount = 0;
int nCheck=0;
object oItem = GetFirstItemInInventory(oBox);
while (GetIsObjectValid(oItem)==TRUE)
        {
        nCount=nCount+1;
        oItem= GetNextItemInInventory(oBox);
        }
if (nCount==1) nCheck=nCheck+1;

oItem = GetFirstItemInInventory(oBox);
if (GetTag(oItem)=="te_cebcraft07") nCheck=nCheck+1;
if (GetTag(oItem)=="te_cebcraft09") nCheck=nCheck+1;
if (GetTag(oItem)=="te_cebcraft011") nCheck=nCheck+1;
if (GetTag(oItem)=="te_cebcraft016") nCheck=nCheck+1;
if (GetTag(oItem)=="te_cebcraft034") nCheck=nCheck+1;

if (GetCalendarDay() != GetLocalInt(oItem, "Date")) nCheck=nCheck+1;

if (GetLocalInt(oItem, "Days") < 1) nCheck=nCheck+1;

if (nCheck==4) return TRUE;
return FALSE;
}

