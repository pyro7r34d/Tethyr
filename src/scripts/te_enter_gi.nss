#include "nw_i0_plot"
#include "nwnx_creature"
#include "loi_background"

void main()
{
    object oPC = GetEnteringObject();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    int iCL = GetHitDice(oPC);
    location lNo = GetLocation(GetObjectByTag("WP_Starting_Area"));
    location lFail = GetLocation(GetObjectByTag("WP_NewCharacter"));
    object oCreate;

    object oInvent = GetFirstItemInInventory(oPC);

    while (oInvent != OBJECT_INVALID )
    {
        if(GetTag(oInvent) != "PC_Data_Object")
        {
            DestroyObject(oInvent);
        }
        oInvent = GetNextItemInInventory(oPC);
    }

    //Racial/Class Language Reapplication:
    if((GetRacialType(oPC) == RACIAL_TYPE_ELF)||(GetRacialType(oPC) == RACIAL_TYPE_HALFELF))
    {
        SetLocalInt(oItem,"1",1);
    }
    if(GetRacialType(oPC) == RACIAL_TYPE_GNOME)
    {
        SetLocalInt(oItem,"2",1);
    }
    if(GetRacialType(oPC) == RACIAL_TYPE_HALFLING)
    {
        SetLocalInt(oItem,"3",1);
    }
    if(GetRacialType(oPC) == RACIAL_TYPE_DWARF)
    {
        SetLocalInt(oItem,"4",1);
    }
    if(GetRacialType(oPC) == RACIAL_TYPE_HALFORC)
    {
        SetLocalInt(oItem,"5",1);
    }
    if((GetLevelByClass(CLASS_TYPE_RANGER,oPC) >= 8 )||( GetLevelByClass(CLASS_TYPE_DRUID,oPC) >= 5 ))
    {
        SetLocalInt(oItem,"8",1);
    }
    if((GetLevelByClass(CLASS_TYPE_ROGUE,oPC)) >= 1 ||( GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC) >= 1 ))
    {
        SetLocalInt(oItem,"9",1);
    }
    if(GetLevelByClass(CLASS_TYPE_DRUID,oPC) >= 5)
    {
        SetLocalInt(oItem,"14",1);
    }
    if(GetHasFeat(BACKGROUND_CALISHITE_TRAINED,oPC) ==TRUE)
    {
        SetLocalInt(oItem,"23",1);
    }
    if(GetHasFeat(BACKGROUND_TALFIRIAN,oPC) ==TRUE)
    {
        SetLocalInt(oItem,"38",1);
    }
    if(GetHasFeat(BACKGROUND_CIRCLE_BORN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"8",1);
    }
    if(GetHasFeat(BACKGROUND_DARK_ELF,oPC) == TRUE)
    {
        SetLocalInt(oItem,"13",1);
        SetLocalInt(oItem,"81",1);
        SetLocalInt(oItem,"46",1);
    }
    if(GetHasFeat(BACKGROUND_GREY_DWARF,oPC) == TRUE)
    {
        SetLocalInt(oItem,"64",1);
        SetLocalInt(oItem,"46",1);
    }
    if(GetHasFeat(ETHNICITY_CALISHITE,oPC) == TRUE)
    {
        SetLocalInt(oItem,"23",1);
    }
    if(GetHasFeat(ETHNICITY_CHONDATHAN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"53",1);
    }
    if(GetHasFeat(ETHNICITY_DAMARAN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"56",1);
    }
    if(GetHasFeat(ETHNICITY_ILLUSKAN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"22",1);
    }
    if(GetHasFeat(ETHNICITY_MULAN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"27",1);
    }
    if(GetHasFeat(ETHNICITY_RASHEMI,oPC) == TRUE)
    {
        SetLocalInt(oItem,"30",1);
    }
    if(GetHasFeat(1137,oPC) == TRUE)
    {
        SetLocalInt(oItem,"11",1);
    }
    if(GetHasFeat(1139,oPC) == TRUE)
    {
        SetLocalInt(oItem,"12",1);
    }

    //Base starting Items
    if (iCL == 3)
    {
        object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
        int iState = GetLocalInt(oItem,"BG_Select");

        if (iState == 8 &&
            (GetHasFeat(BACKGROUND_UPPER,oPC) == TRUE || GetHasFeat(BACKGROUND_MIDDLE,oPC) == TRUE || GetHasFeat(BACKGROUND_LOWER,oPC) == TRUE))
        {
            oCreate = CreateItemOnObject("bandages", oPC, 3);
            SetIdentified(oCreate,TRUE);
            oCreate = CreateItemOnObject("ceb_crcraftbox", oPC, 1);
            SetIdentified(oCreate,TRUE);
            oCreate = CreateItemOnObject("ceb_crcombinera", oPC, 1);
            SetIdentified(oCreate,TRUE);
            oCreate = CreateItemOnObject("te_serverrules",oPC,1);
            SetIdentified(oCreate,TRUE);
            oCreate = CreateItemOnObject("ceb_crbk_craft",oPC,1);
            SetIdentified(oCreate,TRUE);
            oCreate = CreateItemOnObject("te_towel",oPC,1);
            SetIdentified(oCreate,TRUE);
            oCreate = CreateItemOnObject("bedroll",oPC,1);
            SetIdentified(oCreate,TRUE);
            oCreate = CreateItemOnObject("dmfi_pc_dicebag",oPC,1);
            SetIdentified(oCreate,TRUE);

            if(GetHasFeat(BACKGROUND_UPPER,oPC) == TRUE)
            {
                object oRing = CreateItemOnObject("housering", oPC, 1);
                SetName(oRing,GetName(oPC)+"'s House Ring");
                SetIdentified(oRing,TRUE);
            }

            if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC) > 1)
            {
                SetLocalInt(oItem,"te_hrs_10",TRUE);
            }

            if(GetLevelByClass(CLASS_TYPE_MONK,oPC) > 1)
            {
                SetLocalInt(oItem,"KiLevel",50);
            }

            if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC) > 1 ||
               GetLevelByClass(CLASS_TYPE_CLERIC,oPC)  > 1 ||
               GetLevelByClass(CLASS_TYPE_RANGER,oPC)  > 1 ||
               GetLevelByClass(CLASS_TYPE_DRUID,oPC)   > 1
            )
            {
                oCreate = CreateItemOnObject("it_holysymbol",oPC,1);
                SetIdentified(oCreate,TRUE);
            }
            SetLocalInt(oItem,"nPiety",100);
        }
        else
        {
            SendMessageToPC(oPC,"You must select background, subrace, langauge, and deities before leaving the starting room.");
            AssignCommand(oPC, JumpToLocation(lFail));
            return;
        }

        AwardStartingGold(oPC);

        //Background Item Creation
        if (GetHasFeat(BACKGROUND_AFFLUENCE,oPC) == TRUE)
        {
        }
        else if (GetHasFeat(BACKGROUND_BRAWLER,oPC) == TRUE)
        {
            CreateItemOnObject("bg_cestys", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_COSMOPOLITAN,oPC) == TRUE)
        {
            CreateItemOnObject("te_item_0019", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_CRUSADER,oPC) == TRUE)
        {
            CreateItemOnObject("bg_holycenser", oPC, 1);
            CreateItemOnObject("bandages", oPC, 5);
            CreateItemOnObject("te_book022", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_DUELIST,oPC) == TRUE)
        {
            CreateItemOnObject("duelingbelt", oPC, 1);
            CreateItemOnObject("bandages", oPC, 5);
            CreateItemOnObject("bg_steeldudagger", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_EVANGELIST,oPC) == TRUE)
        {
            CreateItemOnObject("bg_evanstaff", oPC, 1);
            CreateItemOnObject("te_9005", oPC, 5);
        }
        else if (GetHasFeat(BACKGROUND_FORESTER,oPC) == TRUE)
        {
            CreateItemOnObject("woodenring", oPC, 1);
            CreateItemOnObject("te_item_9004", oPC, 5);
            CreateItemOnObject("te_item_5024", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_HARD_LABORER,oPC) == TRUE)
        {
            CreateItemOnObject("workboots", oPC, 1);
            CreateItemOnObject("bandages", oPC, 1);
            CreateItemOnObject("bg_workbelt", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_HEALER,oPC) == TRUE)
        {
            CreateItemOnObject("bg_healerneck", oPC, 1);
            CreateItemOnObject("bg_healerglove", oPC, 10);
        }
        else if (GetHasFeat(BACKGROUND_KNIGHT,oPC) == TRUE)
        {
            SetLocalInt(oItem,"hrs_07",TRUE);
            CreateItemOnObject("knightlycloak", oPC, 1);
            CreateItemOnObject("te_writknight",oPC,1);
            CreateItemOnObject("knightlyhalfplate",oPC,1);
            CreateItemOnObject("te_item_5022",oPC,1);
        }
        else if (GetHasFeat(BACKGROUND_HEDGEMAGE,oPC) == TRUE)
        {
            CreateItemOnObject("apprenticessta", oPC, 1);
            CreateItemOnObject("te_item_8457", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_MENDICANT,oPC) == TRUE)
        {
            CreateItemOnObject("bg_humblerobe", oPC, 1);
            CreateItemOnObject("te_item_8144", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_MERCHANT,oPC) == TRUE)
        {
            CreateItemOnObject("bg_merchantneck", oPC, 1);
            CreateItemOnObject("te_item_0007", oPC, 3);
            CreateItemOnObject("te_item_0009", oPC, 3);
            CreateItemOnObject("te_item_0010", oPC, 3);
            CreateItemOnObject("ShieldKnightCoin", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_MINSTREL,oPC) == TRUE)
        {
            CreateItemOnObject("bg_fancylute", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_OCCULTIST,oPC) == TRUE)
        {
            CreateItemOnObject("summonersmanual", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SABOTEUR,oPC) == TRUE)
        {
            CreateItemOnObject("bg_saboglove", oPC, 1);
            CreateItemOnObject("it_trap019", oPC, 1);
            CreateItemOnObject("it_trap018", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SCOUT,oPC) == TRUE)
        {
            CreateItemOnObject("scoutsring", oPC, 1);
            CreateItemOnObject("bg_scoutcloak",oPC,1);

        }
        else if (GetHasFeat(BACKGROUND_SNEAK,oPC) == TRUE)
        {
            CreateItemOnObject("bg_thiefglove", oPC, 1);
            CreateItemOnObject("te_thieftools", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SOLDIER,oPC) == TRUE)
        {
            CreateItemOnObject("bg_soldierhelm", oPC, 1);
            CreateItemOnObject("te_footsoldier",oPC,1);
        }
        else if (GetHasFeat(BACKGROUND_TRAVELER,oPC) == TRUE)
        {
            CreateItemOnObject("bg_walkingstick", oPC, 1);
            CreateItemOnObject("bg_tatteredboots", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SPELLFIRE,oPC) == TRUE)
        {
            CreateItemOnObject("depletedring", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SHADOW,oPC) == TRUE)
        {
            CreateItemOnObject("it_sparsc610", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_CARAVANNER, oPC) == TRUE)
        {
            CreateItemOnObject("te_item_0007", oPC, 3);
            CreateItemOnObject("te_item_0009", oPC, 3);
            CreateItemOnObject("te_item_0010", oPC, 3);
            CreateItemOnObject("bg_merchantneck", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_CHURCH_ACOLYTE, oPC) == TRUE)
        {
            CreateItemOnObject("te_item_9005", oPC, 5);
            CreateItemOnObject("te_book022", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_CIRCLE_BORN, oPC) == TRUE)
        {
            CreateItemOnObject("te_item_8155", oPC, 1);
            CreateItemOnObject("te_dr_sash", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_ENLIGHTENED_STUDENT, oPC) == TRUE)
        {
            CreateItemOnObject("ringofknowledge", oPC, 1);
            CreateItemOnObject("te_item_8457", oPC, 1);
            CreateItemOnObject("te_book002", oPC, 1);
            CreateItemOnObject("te_item_8456", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_HAREM_TRAINED, oPC) == TRUE)
        {
            CreateItemOnObject("te_item_8331", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_HARPER, oPC) == TRUE)
        {
            CreateItemOnObject("bg_harperbrooch", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_KNIGHT_SQUIRE, oPC) == TRUE)
        {
            CreateItemOnObject("te_item_8456", oPC, 1);
            CreateItemOnObject("bg_squirebelt", oPC, 1);
            CreateItemOnObject("bg_squirehelm", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_TALFIRIAN, oPC) == TRUE)
        {
            CreateItemOnObject("te_book028", oPC, 1);
            CreateItemOnObject("te_item_0002", oPC, 1);
            CreateItemOnObject("mal_sm_illus1", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_THEOCRAT, oPC) == TRUE)
        {
            CreateItemOnObject("it_prayerbook", oPC, 1);
            CreateItemOnObject("te_item_9005", oPC, 5);
            CreateItemOnObject("te_book022", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_WARD_TRIAD, oPC) == TRUE)
        {
            CreateItemOnObject("bg_triadneck", oPC, 1);
            CreateItemOnObject("te_book022", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_ZHENTARIM, oPC) == TRUE)
        {
            CreateItemOnObject("bg_zhentneck", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_CALISHITE_TRAINED, oPC) == TRUE)
        {
            CreateItemOnObject("te_item_8374", oPC, 1);
            CreateItemOnObject("te_item_8339", oPC, 1);
            CreateItemOnObject("it_spellbook", oPC, 1);
            CreateItemOnObject("mal_sm_nerco1", oPC,1);
            CreateItemOnObject("mal_sm_evoc1", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_AMN_TRAINED, oPC) == TRUE)
        {
            CreateItemOnObject("te_item_2011", oPC, 1);
            CreateItemOnObject("ShieldKnightCoin", oPC, 1);
            CreateItemOnObject("mal_sm_conj1", oPC, 1);
            CreateItemOnObject("it_spellbook", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_ELDRETH, oPC) == TRUE)
        {
            CreateItemOnObject("bg_lesselfcloak", oPC, 1);
            CreateItemOnObject("bg_eldrethbow", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_ELMANESSE, oPC) == TRUE)
        {
        }
        else if (GetHasFeat(BACKGROUND_SULDUSK, oPC) == TRUE)
        {
        }
        else if (GetHasFeat(BACKGROUND_DUKES_WARBAND, oPC) == TRUE)
        {
        }
        else if (GetHasFeat(BACKGROUND_CALISHITE_SLAVE, oPC) == TRUE)
        {
            CreateItemOnObject("bg_brokenshackle", oPC, 1);
            CreateItemOnObject("bg_worncloak", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SELDARINE_PRIEST, oPC) == TRUE)
        {
        }
        else if (GetHasFeat(BACKGROUND_HIGH_MAGE, oPC) == TRUE)
        {
        }
        else if (GetHasFeat(BACKGROUND_UNDERDARK_EXILE, oPC) == TRUE)
        {
        }
        else if (GetHasFeat(BACKGROUND_THUNDER_TWIN, oPC) == TRUE)
        {
        }
        else if (GetHasFeat(BACKGROUND_HEIR, oPC) == TRUE)
        {
        }
        else if (GetHasFeat(BACKGROUND_MORDINS_PRIEST, oPC) == TRUE)
        {
        }
        else if (GetHasFeat(BACKGROUND_WARY_SWORDKNIGHT, oPC) == TRUE)
        {
        }


        //Crafting Proficiency Starting Items
        if(GetHasFeat(PROFICIENCY_ARMORING,oPC) == TRUE)
        {
            CreateItemOnObject("ceb_crbk_armor", oPC, 1);
            CreateItemOnObject("ceb_crbk_ltwpn", oPC, 1);
            CreateItemOnObject("ceb_crbk_lgwpn", oPC, 1);
        }
        if(GetHasFeat(PROFICIENCY_CARPENTRY,oPC) == TRUE)
        {
            CreateItemOnObject("ceb_crbk_wood", oPC, 1);
        }
        if(GetHasFeat(PROFICIENCY_HERBALISM,oPC) == TRUE)
        {
            CreateItemOnObject("ceb_crtcottonpic", oPC, 1);
            CreateItemOnObject("ceb_mortarandpes", oPC, 1);
        }
        if(GetHasFeat(PROFICIENCY_HUNTING,oPC) == TRUE)
        {
            CreateItemOnObject("ceb_crtcottonpic", oPC, 1);
        }
        if(GetHasFeat(PROFICIENCY_MINING,oPC) == TRUE)
        {
            CreateItemOnObject("te_item_0007", oPC, 3);
            CreateItemOnObject("ceb_crtpickaxe", oPC, 3);
        }
        if(GetHasFeat(PROFICIENCY_TAILORING,oPC) == TRUE)
        {
            CreateItemOnObject("ceb_crbk_leather", oPC, 1);
            CreateItemOnObject("ceb_crtcottonpic", oPC, 1);
        }
        if(GetHasFeat(PROFICIENCY_WOOD_GATHERING,oPC) == TRUE)
        {
            CreateItemOnObject("ceb_crbk_wood", oPC, 2);
        }

        //Subrace Starting Items
        if (GetHasFeat(BACKGROUND_COPPER_ELF,oPC) == TRUE)
        {
            CreateItemOnObject("bg_lesselfcloak", oPC, 1);
            CreateItemOnObject("bg_lesselfboots", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_GREEN_ELF,oPC) == TRUE)
        {
            CreateItemOnObject("bg_lesselfcloak", oPC, 1);
            CreateItemOnObject("bg_lesselfboots", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_DARK_ELF,oPC) == TRUE)
        {
            CreateItemOnObject("bg_lessdrowcloak", oPC, 1);
            CreateItemOnObject("bg_lessdrowboots", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SILVER_ELF,oPC) == TRUE)
        {
            CreateItemOnObject("bg_elflongblade", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_GOLD_ELF,oPC) == TRUE)
        {
            CreateItemOnObject("te_item_1010", oPC, 1);
            CreateItemOnObject("te_item_1004", oPC, 1);
            CreateItemOnObject("bg_elflongblade", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_GOLD_DWARF,oPC) == TRUE)
        {
            CreateItemOnObject("wblmhw003", oPC, 1);
            CreateItemOnObject("te_item_8482", oPC, 1);
            CreateItemOnObject("te_item_8483", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_GREY_DWARF,oPC) == TRUE)
        {
            CreateItemOnObject("travelersneckl", oPC, 1);
            CreateItemOnObject("te_item_8482", oPC, 1);
            CreateItemOnObject("te_item_8483", oPC, 1);
            CreateItemOnObject("te_item_0006", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SHIELD_DWARF,oPC) == TRUE)
        {
            CreateItemOnObject("travelersneckl", oPC, 1);
            CreateItemOnObject("te_item_8482", oPC, 1);
            CreateItemOnObject("te_item_8483", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_OUTSIDER,oPC) == TRUE)
        {
            CreateItemOnObject("bg_shadyhood", oPC, 1);
            CreateItemOnObject("bg_worncloak", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_AASIMAR,oPC) == TRUE)
        {
            CreateItemOnObject("te_item_9005", oPC, 5);
            CreateItemOnObject("te_item_5021", oPC, 1);

        }
        else if (GetHasFeat(BACKGROUND_TIEFLING, oPC) == TRUE)
        {
            CreateItemOnObject("te_item_5023", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_NAT_LYCAN,oPC) == TRUE)
        {
            CreateItemOnObject("brokentoothamule", oPC, 1);
        }


        AssignCommand(oPC, JumpToLocation(lNo));
    }
    else
    {
        SendMessageToPC(oPC,"You must be level 3 before leaving the starting room.");
        AssignCommand(oPC, JumpToLocation(lFail));
    }
}
