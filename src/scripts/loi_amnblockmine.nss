/*
 *  Script generated by LS Script Generator, v.TK.0
 *
 *  For download info, please visit:
 *  http://nwvault.ign.com/View.php?view=Other.Detail&id=1502
 */
// Put this script OnFailToOpen.


void main()
{
    // Get the creature who triggered this event.
    object oPC = GetClickingObject();

    // Only fire once per PC.
    if ( GetLocalInt(oPC, "DO_ONCE__" + GetTag(OBJECT_SELF)) )
        return;
    SetLocalInt(oPC, "DO_ONCE__" + GetTag(OBJECT_SELF), TRUE);

    // Have text appear over the PC's head.
    FloatingTextStringOnCreature("[Try as you might, this door appears heavily barred from the other side.]", oPC, FALSE);
}

