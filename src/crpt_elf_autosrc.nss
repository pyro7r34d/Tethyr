#include "crp_inc_paw"
void main()
{
    object oPC = GetEnteringObject();
    location lLoc = GetLocation(oPC);

    if(GetRacialType(oPC) == RACIAL_TYPE_ELF)
        SearchForSecrets(lLoc, TRUE, oPC);
}
