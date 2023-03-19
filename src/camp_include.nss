//::///////////////////////////////////////////////
//:: camp_include
//:://////////////////////////////////////////////
/*
    MAGUS CAMP SYSTEM - INCLUDE

    DO NOT EDIT THIS FILE
    EDIT camp_config TO CONFIGURE THIS CAMP SYSTEM

    include this file whereever you need to use the camp system

*/
//:://////////////////////////////////////////////
//:: Creator   : The Magus (2013 jun 29)
//:: Modified  :
//:://////////////////////////////////////////////


// INCLUDES --------------------------------------------------------------------

// part of config ------------
// the following includes may contain functions or constants which you have defined elsewhere
// if that is the case feel free to use your own includes and delete these provided
#include "te_functions"
//#include "v2_inc_creatures"

// required ------------------

// Magus' Food System - eating and hunger
#include "food_include"

// CONSTANTS -------------------------------------------------------------------

// ........ CONFIGURABLE ........
// object resrefs
const string REF_CAMPSITE           = "campsite_pit";   // invisible object which holds all the data for the campsite
const string REF_CAMPFIRE_1         = "campsite_fire1"; // campfire basic (typical firepit)
const string REF_CAMPFIRE_2         = "campsite_fire2"; // campfire with spit or tripod
const string REF_CAMPFIRE_3         = "campsite_fire3"; // campfire with pot
const string REF_FIREWOOD           = "firewood";       // firewood
const string REF_COOKPOT            = "cookpot";        // cookpot
// object tags
const string TAG_CAMPSITE           = "campsite";
const string TAG_FIREWOOD           = "firewood";
const string TAG_COOKPOT            = "cookpot";

// minimum amount of FUEL_REMAINING to build a campfire
// The assumption is that FUEL_REMAINING is measured in minutes
const int CAMPFIRE_FUEL_MINIMUM     = 60;

// Set to the index of REF_CAMPFIRE you want to show when HANGING a pot on the fire
const int CAMPFIRE_STATE_HANG_POT   = 3;
// Set to the index of REF_CAMPFIRE you want to show when RETRIEVING the pot from the fire
const int CAMPFIRE_STATE_RETRIEVE_POT= 2;


// not configurable .....................

// local variable on a burnable object indicating how long it will burn
const string FUEL_MINUTES   = "FUEL_MINUTES";   // set by builder. if not set, item can not be burned.
const string FUEL_REMAINING = "FUEL_REMAINING"; // set by script to track how much fuel remains (measured in heartbeats)

// a firewood object to be used in making a fire set as a local object on the PC
const string CAMP_FIREWOOD  = "CAMP_FIREWOOD";


// FUNCTION DECLARATIONS -------------------------------------------------------

// configurable ----------------------------------------------------------------

// Returns TRUE if oCreature has the ability to make a campfire [FILE: camp_config]
// if you will require a tinderbox or woodcraft or a fire spell to make a fire, you should make those adjustments here
// firewood should be checked for separately see GetFirewoodInInventory() in camp_include
int GetCanCreatureMakeCampfire(object oCreature=OBJECT_SELF);

// Returns TRUE if lLocation is suitable for building a campfire [FILE: camp_config]
// oCreature is included to provide another means of checking (eg local variables set on a PC when they are underwater)
int GetIsLocationSuitableForCampfire(location lCampsite, object oCreature=OBJECT_SELF);


// not configurable ------------------------------------------------------------

// Returns object (burnable item) in oCreature's inventory with FUEL >= nMinimum [FILE: camp_include]
// if more than one is found it goes with the following priority
// (1) first object that is already burned
// (2) first object with firewood tag
// (3) object with the most fuel
// fail safe: system will warn players before burning an object which isn't firewood
object GetFirewoodInInventory(object oCreature=OBJECT_SELF, int nMinimum = CAMPFIRE_FUEL_MINIMUM);
// Determines whether oCreature is near a camp [FILE: camp_include]
// Returned values are 0, 1, and 2  (TRUE = adjacent camp regardless of whether a fire is lit)
// 0 = no camp nearby
// 1 = camp nearby, but no fire is lit
// 2 = camp nearby with lit fire
int GetIsNearCamp(object oCreature=OBJECT_SELF);
// Returns a light value when given a fuel value [FILE: camp_include]
int ConvertFuelToLight(int nFuel);

// Calling creature moves to a campsite prior to creating it [FILE: camp_include]
// bClearActions allows caller to clear the queue prior to moving to the location
void CamperMovesToCampsite(location lCampsite, object oFirewood=OBJECT_INVALID, int bClearActions=FALSE);
// Calling creature creates a campsite  [FILE: camp_include]
// bClearActions allows caller to clear the queue prior to building the fire
void CamperCreatesCampsite(location lCampsite, object oFirewood, int bClearActions=FALSE);
// Calling creature builds fire  [FILE: camp_include]
// bClearActions allows caller to clear the queue prior to building the fire
void CamperBuildsFire(location lCampSite, object oFirewood);
// Calling creature uses oFire  [FILE: camp_include]
// if oFire==OBJECT_INVALID, a nearby campfire is searched for - if none found nothing happens
// bClearActions allows caller to clear the queue prior to using the campfire
void CamperUsesCampfire(object oFire=OBJECT_INVALID, int bClearActions=FALSE);
// Add more fuel to the fire [FILE: camp_include]
// used by campfire_dlg
void CamperFuelsCampfire(object oFire, object oWood);
// Pack up the campsite [FILE: camp_include]
// used by campfire_dlg
void CamperPacksCampfire(object oFire);
// cook something over the fire [FILE: camp_include]
// used by campfire_dlg. Returns 1 if the camper cooks. 2 if the food item was destroyed.
int CamperCooksAtCampfire(object oFire, object oFood, object oCamper=OBJECT_SELF);
// Hang the pot on the fire [FILE: camp_include]
// used by campfire_dlg
void CamperHangsPot(object oFire, object oPot=OBJECT_INVALID, object oCamper=OBJECT_SELF);
// Retrieve the pot from the fire [FILE: camp_include]
// used by campfire_dlg
void CamperRetrievesPot(object oFire, object oCamper=OBJECT_SELF);


// change the appearance/state of the fire [FILE: camp_include]
// used by campfire_dlg
object CampfireState(object oPC, int nState, object campfire=OBJECT_SELF);
// Adjusts the light of the capfire based on nFuel [FILE: camp_include]
// if nFuel = 0 then the light is extinguished
void CampfireResetLight(int nFuel);
// [FILE: camp_include]
void CampfireLight();
// [FILE: camp_include]
void CampfireExtinguish();
// process campfire death and then destroy [FILE: camp_include]
void CampfireGarbageCollection(object oFire=OBJECT_SELF);


// FUNCTION IMPLEMENTATIONS ----------------------------------------------------

// configurable ----------------------------------------------------------------

int GetCanCreatureMakeCampfire(object oCreature=OBJECT_SELF)
{
    // we assume that everyone knows how to build a fire
    // you will, of course, need to change this if you want to add any requirements for making a fire
    int nAble   = TRUE;

    return nAble;
}

int GetIsLocationSuitableForCampfire(location lCampsite, object oCreature=OBJECT_SELF)
{
    int bSuitable   = TRUE;

     // TERRAIN SYSTEM CHECKS
    if(     GetLocalString(oCreature,"UNDERWATER_ID")!=""
       ||   GetLocalString(oCreature,"SWAMP_ID")!=""
      )
    {
        SendMessageToPC(oCreature, RED+"The wet makes building a fire here impossible.");
        bSuitable   = FALSE;
    }

    /*
    else if( GetLocalInt(oCreature, "BRAMBLE") )
    {
        SendMessageToPC(oCreature, RED+"The undergrowth prevents fire building in this location.");
        bSuitable   = FALSE;
    }
    */

    return bSuitable;
}


// not configurable ------------------------------------------------------------

object GetFirewoodInInventory(object oCreature=OBJECT_SELF, int nMinimum = CAMPFIRE_FUEL_MINIMUM)
{
    int nMostFuel, nFuel, bFirewood;
    object oFirewood= OBJECT_INVALID;
    object oTemp    = GetFirstItemInInventory(oCreature);
    while(oTemp!=OBJECT_INVALID)
    {
        nFuel       = GetLocalInt(oTemp, FUEL_REMAINING);
        if( nFuel && nFuel>=nMinimum)
        {
            // object is burned && meets minimum requirements
            return oTemp;
        }
        else if(!bFirewood)
        {
            nFuel   = GetLocalInt(oTemp, FUEL_MINUTES);
            if(nFuel && nFuel>=nMinimum)
            {
                if(GetTag(oTemp)==TAG_FIREWOOD)
                {
                    bFirewood   = TRUE;
                    oFirewood   = oTemp;
                }
                else if(nFuel>nMostFuel)
                {
                    nMostFuel   = nFuel;
                    oFirewood   = oTemp;
                }
            }
        }

        oTemp    = GetNextItemInInventory(oCreature);
    }

    return oFirewood;
}

int GetIsNearCamp(object oCreature=OBJECT_SELF)
{
    object oCampSite    = GetNearestObjectByTag(TAG_CAMPSITE,oCreature);
    int nLight          = GetLocalInt(oCampSite, LIGHT_VALUE);
    if( !GetIsObjectValid(oCampSite)
        ||  GetDistanceBetween(oCreature,oCampSite) > IntToFloat(nLight+4)
      )
        return FALSE;
    else if( nLight < 1)
        return 1;
    else
        return 2;
}

int ConvertFuelToLight(int nFuel)
{
    int nLight;

    if(nFuel<90)
        nLight  = 1;
    else if(nFuel<180)
        nLight  = 2;
    else if(nFuel<240)
        nLight  = 3;
    else if(nFuel<300)
        nLight  = 4;
    else if(nFuel<360)
        nLight  = 5;
    else
        nLight  = 6;

    return nLight;
}

void CamperMovesToCampsite(location lCampsite, object oFirewood=OBJECT_INVALID, int bClearActions=FALSE)
{
    if(bClearActions)
        ClearAllActions();
    ActionMoveToLocation(lCampsite, TRUE);
    if(oFirewood!=OBJECT_INVALID)
        ActionDoCommand(CamperCreatesCampsite(lCampsite, oFirewood, bClearActions));
}

void CamperCreatesCampsite(location lCampsite, object oFirewood, int bClearActions=FALSE)
{
    if(oFirewood==OBJECT_INVALID)
    {
        SendMessageToPC(OBJECT_SELF, RED+"You lack the fuel for a fire.");
    }
    else if(!GetIsLocationSuitableForCampfire(lCampsite))
    {
        // failure. do not continue.
    }
    else
    {
        // failsafe check for firewood used should be established here
        // the magus is too lazy right now to do so.

        FloatingTextStringOnCreature(LIME+GetName(OBJECT_SELF)+" sets up camp...",OBJECT_SELF);
        if(bClearActions)
            ClearAllActions();
        ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0f,2.0f);
        DelayCommand(1.0f, CamperBuildsFire(lCampsite, oFirewood));
    }
}

void CamperBuildsFire(location lCampSite, object oFirewood)
{
    // remaining fuel
    int nFuel = GetLocalInt(oFirewood,FUEL_REMAINING);
    // unburned?
    if(!nFuel)
    {
        // total fuel set by builder
        nFuel = GetLocalInt(oFirewood,FUEL_MINUTES);
        // error?
        if(!nFuel)
            nFuel = CAMPFIRE_FUEL_MINIMUM; // give the benefit of the doubt and allow minimum fuel for a fire
    }

    // Fire - usable placeable
    object oFire        = CreateObject(OBJECT_TYPE_PLACEABLE, REF_CAMPFIRE_1, lCampSite, FALSE);   // has usable event
    object oCampSite    = CreateObject(OBJECT_TYPE_PLACEABLE, REF_CAMPSITE, lCampSite, FALSE); // has heartbeat event

    SetLocalObject(oFire, "PAIRED", oCampSite);
    SetLocalObject(oCampSite, "PAIRED", oFire);
    SetLocalObject(oCampSite, "CAMPER", OBJECT_SELF);

    SetLocalInt(oCampSite, FUEL_REMAINING, nFuel);
    DelayCommand(0.1f, SetPlaceableIllumination(oFire, FALSE));
    AssignCommand(oFire, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE) );
    DelayCommand(0.3f, ActionInteractObject(oFire));

    DestroyObject(oFirewood,1.0f);
}

void CamperUsesCampfire(object oFire=OBJECT_INVALID, int bClearActions=FALSE)
{
    if(oFire==OBJECT_INVALID)
    {
        oFire    = GetNearestObjectByTag(TAG_CAMPSITE);
        if(     oFire==OBJECT_INVALID
            ||  GetDistanceBetween(OBJECT_SELF, oFire) > 5.0
          )
            return;
    }

    if(bClearActions)
        ClearAllActions();

    ActionInteractObject(oFire);
}

void CamperFuelsCampfire(object oFire, object oWood)
{
    object oArea= GetArea(oFire);
    int nFuel   = GetLocalInt(oFire, FUEL_REMAINING);
    int nLight  = GetLocalInt(oFire, LIGHT_VALUE);

    int nWoodFuel       = GetLocalInt(oWood,FUEL_REMAINING);
    string sResponse    = GetStringLowerCase(GetName(oWood));
    if(     FindSubString(sResponse,"firewood")!=-1
        ||  FindSubString(sResponse,"planks")!=-1
      )
        sResponse = "some "+sResponse;
    else
        sResponse = "a "+sResponse;
    FloatingTextStringOnCreature(LIME+GetName(OBJECT_SELF)+" lays "+sResponse+" on the fire.", OBJECT_SELF);
    DestroyObject(oWood, 0.1);

    nFuel +=nWoodFuel;
    SetLocalInt(oFire,FUEL_REMAINING,nFuel);

    if(nLight>0)
    {
        AssignCommand(oFire, CampfireResetLight(nFuel));
    }
}

void CamperPacksCampfire(object oFire)
{
    // TRACKING SYSTEM
    /*
    if(GetLocalInt(oFire,"nLit"))
    {
        object oScorch  = GetNearestObjectByTag("ashes");
        if(GetDistanceBetween(oScorch,oFire)<=3.0)
        {
            if(GetHasFeat(FEAT_TRACKLESS_STEP,OBJECT_SELF))
                SetLocalInt(oScorch,"FADE_TIME", 30);
            else
                SetLocalInt(oScorch,"FADE_TIME", 120);
            InitializeFade(oScorch);
        }
    }
    */

    int nFuel   = GetLocalInt(oFire, FUEL_REMAINING);

    SetFacingPoint(GetPosition(oFire));
    PlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,3.0);
    if(nFuel && nFuel>=CAMPFIRE_FUEL_MINIMUM)
    {
        FloatingTextStringOnCreature(WHITE+"You gather the remaining firewood.", OBJECT_SELF, FALSE);

        object oWood    = CreateItemOnObject(REF_FIREWOOD, OBJECT_SELF, 1, TAG_FIREWOOD);
        SetLocalInt(oWood, FUEL_REMAINING, nFuel);
        SetName(oWood, GetName(oWood)+" (Partially Burned)");
    }
    else
    {
        FloatingTextStringOnCreature(WHITE+"Only soot and char remains.", OBJECT_SELF, FALSE);
    }

    object oPaired  = GetLocalObject(oFire, "PAIRED");

    AssignCommand(oFire,CampfireGarbageCollection());

    DestroyObject(oPaired, 2.9);
    DestroyObject(oFire, 3.0);
}

int CamperCooksAtCampfire(object oFire, object oFood, object oCamper=OBJECT_SELF)
{
    int camper_cooked  = FALSE;
    int nLight  = GetLocalInt(oFire, LIGHT_VALUE);
    if(!nLight)
    {
        SendMessageToPC(oCamper, RED+"There is no flame to cook with. Light the fire first.");
        DeleteLocalInt(oCamper, "COOK_SERVINGS");
    }
    else
    {
        int nStack;
        string sTag     =GetTag(oFood);
        string sRawFood =GetName(oFood);
        int nTime       = GetTimeCumulative();

        int nPerish     = GetLocalInt(oFood,FOOD_PERISHABLE_TIME);
        if( nPerish && nTime>=nPerish )
        {
            // spoiled
            SendMessageToPC(oCamper, PINK+"The "+sRawFood+" had spoiled so you discard it.");
            DestroyObject(oFood);
            camper_cooked +=2;
        }
        else
        {
            // good
            nStack      = GetItemStackSize(oFood);

            if(nStack<=1)
            {
                DestroyObject(oFood);
                camper_cooked +=2;
            }
            else
                SetItemStackSize(oFood,nStack-1);
        }


        if(nStack)
        {
            FloatingTextStringOnCreature(LIME+GetName(oCamper)+" cooks "+sRawFood+" over the fire.", oCamper);
            AssignCommand(oCamper, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0) );

            object oRations;

            // good place to break out different kinds of food
            oRations    = CreateItemOnObject("rations", oCamper);
            camper_cooked +=1;

            SendMessageToPC(oCamper, LIGHTBLUE+"You produce "+GetName(oRations)+".");
        }
    }
    return camper_cooked;
}

void CamperHangsPot(object oFire, object oPot=OBJECT_INVALID, object oCamper=OBJECT_SELF)
{
    if(oPot==OBJECT_INVALID)
        oPot = GetItemPossessedBy(OBJECT_SELF, TAG_COOKPOT);

    if(oPot!=OBJECT_INVALID)
    {
        object oNew = CampfireState(oCamper, CAMPFIRE_STATE_HANG_POT, oFire);

        SetLocalString(oNew,"POT_NAME", GetName(oPot));
        SetLocalString(oNew,"POT_DESCRIPTION", GetDescription(oPot));
        SetLocalString(oNew,"POT_REF", GetResRef(oPot));

        itemproperty ip = GetFirstItemProperty(oPot);
        string sMaterial;
        while(GetIsItemPropertyValid(ip))
        {
            if(GetItemPropertyType(ip)==ITEM_PROPERTY_MATERIAL)
            {
                int nID     = GetItemPropertyCostTableValue(ip);
                sMaterial   = GetStringLowerCase(
                                    GetStringByStrRef(
                                        StringToInt(
                                            Get2DAString("iprp_matcost","NAME",nID)
                                          )
                                      )
                                  );
                SetLocalInt(oNew,"POT_MATERIAL", nID);
                break;
            }
            ip          = GetNextItemProperty(oPot);
        }
        string sVowel   = GetStringLeft(sMaterial,1);
        string sAgree;
        if(FindSubString("aeiou", sVowel)!=-1)
            sAgree      = "n";
        FloatingTextStringOnCreature(
                GREEN+GetName(oCamper)+LIME+" sets a"+sAgree+" "+sMaterial+" pot over the fire.",
                oCamper
            );

        DestroyObject(oPot);
    }
    else
    {
        FloatingTextStringOnCreature(
                                    GREEN+GetName(oCamper)+LIME+" considers the fire....",
                                    OBJECT_SELF
                                    );
        SendMessageToPC(oCamper, RED+"You need the pot in your posession in order to use it.");
    }
}

void CamperRetrievesPot(object oFire, object oCamper=OBJECT_SELF)
{
    // get pot info
    object oPaired  = GetLocalObject(oFire, "PAIRED");
    string pot_ref  = GetLocalString(oPaired,"POT_REF");
    string pot_name = GetLocalString(oPaired,"POT_NAME");
    string pot_desc = GetLocalString(oPaired,"POT_DESCRIPTION");
    int pot_material= GetLocalInt(oPaired,"POT_MATERIAL");

    object oNew     = CampfireState(oCamper, CAMPFIRE_STATE_RETRIEVE_POT, oFire);

    object oPot = CreateItemOnObject( pot_ref, oCamper);
    SetName(oPot, pot_name);
    SetDescription(oPot,pot_desc);

    if(GetItemHasItemProperty(oPot, ITEM_PROPERTY_MATERIAL))
    {
        itemproperty ip = GetFirstItemProperty(oPot);
        while(GetIsItemPropertyValid(ip))
        {
            if(GetItemPropertyType(ip)==ITEM_PROPERTY_MATERIAL)
                RemoveItemProperty(oPot, ip);

            ip          = GetNextItemProperty(oPot);
        }

    }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(pot_material), oPot);

    string sContents;
    if(MoveInventory(oPaired, oCamper))
        sContents   = " and all it contains";

    FloatingTextStringOnCreature(
                GREEN+GetName(OBJECT_SELF)+LIME+" takes the pot"+sContents+".",
                oCamper
                                );
}



object CampfireState(object oPC, int nState, object campfire=OBJECT_SELF)
{
    vector vPos = GetPosition(campfire);
    AssignCommand(oPC, SetFacingPoint(vPos) );
    AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0) );

    string sRef;
    if(nState==1)
        sRef    = REF_CAMPFIRE_1;
    else if(nState==2)
        sRef    = REF_CAMPFIRE_2;
    else if(nState==3)
        sRef    = REF_CAMPFIRE_3;

    object oPaired  = GetLocalObject(campfire, "PAIRED");
    object oNew     = CreateObject(OBJECT_TYPE_PLACEABLE, sRef, GetLocation(oPaired));
    SetLocalObject(campfire, "PAIRED", oNew);
    SetLocalObject(oNew, "PAIRED", campfire);


    if(GetLocalString(campfire, "SOUND")!="")
        SetLocalString(campfire, "SOUND", GetLocalString(oNew, "SOUND") );

    if(GetLocalInt(campfire, LIGHT_VALUE))
    {
        AssignCommand(oNew, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        DelayCommand( 0.1, SetPlaceableIllumination(oNew, TRUE) );
        SetLocalInt(oNew, "NW_L_AMION", TRUE);
    }
    else
    {
        AssignCommand(oNew, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        DelayCommand( 0.1, SetPlaceableIllumination(oNew, FALSE) );
        SetLocalInt(oNew, "NW_L_AMION", FALSE);
    }


    SetLocalInt(oPaired, "IGNORE_DEATH", TRUE);
    DestroyObject(oPaired, 0.2);
    return oNew;
}


void CampfireResetLight(int nFuel)
{
    // remove all VFX on campfire
    effect xLight = GetFirstEffect(OBJECT_SELF);
    int nInt = 0;
    while(nInt < 10)
    {
        RemoveEffect(OBJECT_SELF, xLight);
        GetNextEffect(OBJECT_SELF);
        nInt++;
    }
    // delete light value (used to determine how much light the fire emits)
    DeleteLocalInt(OBJECT_SELF, LIGHT_VALUE);

    // nFuel==FALSE (no fuel is burning) --> therefore don't display the light
    if(!nFuel)
    {
        DelayCommand(0.1, RecomputeStaticLighting(GetArea(OBJECT_SELF)) );
        SetLocalString(OBJECT_SELF, "SOUND", "");
    }
    // some fuel in fire --> therefore display a light
    else
    {
        int nLight = ConvertFuelToLight(nFuel);
        int nVFX;
        if (nLight==1)
            nVFX    = VFX_DUR_LIGHT_ORANGE_5;
        else if(nLight==2)
            nVFX    = VFX_DUR_LIGHT_ORANGE_10;
        else if(nLight==3)
            nVFX    = VFX_DUR_LIGHT_ORANGE_15;
        else
            nVFX    = VFX_DUR_LIGHT_ORANGE_20;


        SetLocalInt(OBJECT_SELF, LIGHT_VALUE, nLight);

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(nVFX), OBJECT_SELF);

        DelayCommand(3.0, RecomputeStaticLighting(GetArea(OBJECT_SELF)) );
    }
}

void CampfireLight()
{
    int nFuel       = GetLocalInt(OBJECT_SELF, FUEL_REMAINING);
    CampfireResetLight(nFuel);

    // Adjust state of paired placeable (this is the visible part of the campfire)
    object oPaired  = GetLocalObject(OBJECT_SELF, "PAIRED");
    AssignCommand(oPaired, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    SetPlaceableIllumination(oPaired, TRUE);
    SetLocalInt(oPaired, "NW_L_AMION", TRUE);

    // ignite sound
    PlaySound("scm_hitfire");
    // SOUND is resref/name of sound to loop while fire is lit
    string sSound   = GetLocalString(oPaired, "SOUND");
    SetLocalString(OBJECT_SELF, "SOUND", sSound);
    ExecuteScript("_ex_sound", OBJECT_SELF);

    // TRACKING
    /*
    if(!GetLocalInt(OBJECT_SELF,"nLit"))
    {//do once..
        SetLocalInt(OBJECT_SELF,"nLit",1);
        object oScorch = CreateObject(OBJECT_TYPE_PLACEABLE,"ashes",GetLocation(OBJECT_SELF),FALSE);
        SetLocalInt(oScorch,"TRACKS",TRUE);
        SetLocalInt(oScorch,"campsite",TRUE);
    }
    */
}

void CampfireExtinguish()
{
    // This value is set by a builder to indicate that a campfire placeable should be "ON"
    DeleteLocalInt(OBJECT_SELF,"CAMPFIRE_INIT_ON");

    // Adjust state of paired placeable (this is the visible part of the campfire)
    object oPaired  = GetLocalObject(OBJECT_SELF, "PAIRED");
    AssignCommand(oPaired, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetPlaceableIllumination(oPaired, FALSE);
    SetLocalInt(oPaired, "NW_L_AMION", FALSE);

    // remove the lighting VFX
    CampfireResetLight(FALSE);

    SetLocalString(OBJECT_SELF, "SOUND", "");
}

void CampfireGarbageCollection(object oFire=OBJECT_SELF)
{
    object oPaired  = GetLocalObject(oFire, "PAIRED");

    if(GetResRef(oFire)!=REF_CAMPSITE)
    {
        oFire       = oPaired;
        oPaired     = GetLocalObject(oFire, "PAIRED");
    }

    if(GetResRef(oPaired)==REF_CAMPFIRE_3) // campfire with pot
    {
        location lLoc   = GetLocation(oPaired);
        object oPot     = CreateObject( OBJECT_TYPE_PLACEABLE,
                                        REF_COOKPOT,
                                        lLoc
                                      );

        SetName(oPot, GetLocalString(oPaired,"POT_NAME"));
        SetDescription(oPot, GetLocalString(oPaired,"POT_DESCRIPTION"));
        SetLocalString(oPot,"PLACEABLE_TAKE_RESREF", GetLocalString(oPaired,"POT_REF"));

        int nContents   = MoveInventory(oPaired, oPot);
    }

    SetPlotFlag(oPaired, FALSE);
    SetPlotFlag(oFire, FALSE);
    DestroyObject(oPaired, 1.99);
    DestroyObject(oFire, 2.0);
}

// void main(){}
