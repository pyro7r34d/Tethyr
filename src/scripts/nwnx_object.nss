/// @addtogroup object Object
/// @brief Functions exposing additional object properties.
/// @{
/// @file nwnx_object.nss
#include "nwnx"

const string NWNX_Object = "NWNX_Object"; ///< @private

/// @anchor object_localvar_types
/// @name Local Variable Types
/// @{
const int NWNX_OBJECT_LOCALVAR_TYPE_UNKNOWN  = 0;
const int NWNX_OBJECT_LOCALVAR_TYPE_INT      = 1;
const int NWNX_OBJECT_LOCALVAR_TYPE_FLOAT    = 2;
const int NWNX_OBJECT_LOCALVAR_TYPE_STRING   = 3;
const int NWNX_OBJECT_LOCALVAR_TYPE_OBJECT   = 4;
const int NWNX_OBJECT_LOCALVAR_TYPE_LOCATION = 5;
const int NWNX_OBJECT_LOCALVAR_TYPE_JSON     = 6;
/// @}

/// @anchor object_internal_types
/// @name Internal Object Types
/// @{
const int NWNX_OBJECT_TYPE_INTERNAL_INVALID = -1;
const int NWNX_OBJECT_TYPE_INTERNAL_GUI = 1;
const int NWNX_OBJECT_TYPE_INTERNAL_TILE = 2;
const int NWNX_OBJECT_TYPE_INTERNAL_MODULE = 3;
const int NWNX_OBJECT_TYPE_INTERNAL_AREA = 4;
const int NWNX_OBJECT_TYPE_INTERNAL_CREATURE = 5;
const int NWNX_OBJECT_TYPE_INTERNAL_ITEM = 6;
const int NWNX_OBJECT_TYPE_INTERNAL_TRIGGER = 7;
const int NWNX_OBJECT_TYPE_INTERNAL_PROJECTILE = 8;
const int NWNX_OBJECT_TYPE_INTERNAL_PLACEABLE = 9;
const int NWNX_OBJECT_TYPE_INTERNAL_DOOR = 10;
const int NWNX_OBJECT_TYPE_INTERNAL_AREAOFEFFECT = 11;
const int NWNX_OBJECT_TYPE_INTERNAL_WAYPOINT = 12;
const int NWNX_OBJECT_TYPE_INTERNAL_ENCOUNTER = 13;
const int NWNX_OBJECT_TYPE_INTERNAL_STORE = 14;
const int NWNX_OBJECT_TYPE_INTERNAL_PORTAL = 15;
const int NWNX_OBJECT_TYPE_INTERNAL_SOUND = 16;
/// @}

/// @anchor projectile_types
/// @name Projectile VFX Types
/// @{
const int NWNX_OBJECT_SPELL_PROJECTILE_TYPE_DEFAULT = 6;
const int NWNX_OBJECT_SPELL_PROJECTILE_TYPE_USE_PATH = 7;
/// @}

/// A local variable structure.
struct NWNX_Object_LocalVariable
{
    int type; ///< Int, String, Float, Object
    string key; ///< Name of the variable
};

/// @brief Gets the count of all local variables.
/// @param obj The object.
/// @return The count.
int NWNX_Object_GetLocalVariableCount(object obj);

/// @brief Gets the local variable at the provided index of the provided object.
/// @param obj The object.
/// @param index The index.
/// @note Index bounds: 0 >= index < NWNX_Object_GetLocalVariableCount().
/// @note As of build 8193.14 local variables no longer have strict ordering.
///       this means that any change to the variables can result in drastically
///       different order when iterating.
/// @note As of build 8193.14, this function takes O(n) time, where n is the number
///       of locals on the object. Individual variable access with GetLocalXxx()
///       is now O(1) though.
/// @note As of build 8193.14, this function will not return a variable if the value is
///       the default (0/0.0/""/OBJECT_INVALID/JsonNull()) for the type. They are considered not set.
/// @note Will return type UNKNOWN for cassowary variables.
/// @return An NWNX_Object_LocalVariable struct.
struct NWNX_Object_LocalVariable NWNX_Object_GetLocalVariable(object obj, int index);

/// @brief Set oObject's position.
/// @param oObject The object.
/// @param vPosition A vector position.
/// @param bUpdateSubareas If TRUE and oObject is a creature, any triggers/traps at vPosition will fire their events.
void NWNX_Object_SetPosition(object oObject, vector vPosition, int bUpdateSubareas = TRUE);

/// @brief Get an object's hit points.
/// @note Unlike the native GetCurrentHitpoints function, this excludes temporary hitpoints.
/// @param obj The object.
/// @return The hit points.
int NWNX_Object_GetCurrentHitPoints(object obj);

/// @brief Set an object's hit points.
/// @param obj The object.
/// @param hp The hit points.
void NWNX_Object_SetCurrentHitPoints(object obj, int hp);

/// @brief Adjust an object's maximum hit points
/// @note Will not work on PCs.
/// @param obj The object.
/// @param hp The maximum hit points.
void NWNX_Object_SetMaxHitPoints(object obj, int hp);

/// @brief Serialize a full object to a base64 string
/// @param obj The object.
/// @return A base64 string representation of the object.
/// @note includes locals, inventory, etc
string NWNX_Object_Serialize(object obj);

/// @brief Deserialize the object.
/// @note The object will be created outside of the world and needs to be manually positioned at a location/inventory.
/// @param serialized The base64 string.
/// @return The object.
object NWNX_Object_Deserialize(string serialized);

/// @brief Gets the dialog resref.
/// @param obj The object.
/// @return The name of the dialog resref.
string NWNX_Object_GetDialogResref(object obj);

/// @brief Sets the dialog resref.
/// @param obj The object.
/// @param dialog The name of the dialog resref.
void NWNX_Object_SetDialogResref(object obj, string dialog);

/// @brief Set oPlaceable's appearance.
/// @note Will not update for PCs until they re-enter the area.
/// @param oPlaceable The placeable.
/// @param nAppearance The appearance id.
void NWNX_Object_SetAppearance(object oPlaceable, int nAppearance);

/// @brief Get oPlaceable's appearance.
/// @param oPlaceable The placeable.
/// @return The appearance id.
int NWNX_Object_GetAppearance(object oPlaceable);

/// @brief Determine if an object has a visual effect.
/// @param obj The object.
/// @param nVFX The visual effect id.
/// @return TRUE if the object has the visual effect applied to it
int NWNX_Object_GetHasVisualEffect(object obj, int nVFX);

/// @brief Get an object's damage immunity.
/// @param obj The object.
/// @param damageType The damage type to check for immunity. Use DAMAGE_TYPE_* constants.
/// @return Damage immunity as a percentage.
int NWNX_Object_GetDamageImmunity(object obj, int damageType);

/// @brief Add or move an object.
/// @param obj The object.
/// @param area The area.
/// @param pos The position.
void NWNX_Object_AddToArea(object obj, object area, vector pos);

/// @brief Get placeable's static setting
/// @param obj The object.
/// @return TRUE if placeable is static.
int NWNX_Object_GetPlaceableIsStatic(object obj);

/// @brief Set placeable as static or not.
/// @note Will not update for PCs until they re-enter the area.
/// @param obj The object.
/// @param isStatic TRUE/FALSE
void NWNX_Object_SetPlaceableIsStatic(object obj, int isStatic);

/// @brief Gets if a door/placeable auto-removes the key after use.
/// @param obj The object.
/// @return TRUE/FALSE or -1 on error.
int NWNX_Object_GetAutoRemoveKey(object obj);

/// @brief Sets if a door/placeable auto-removes the key after use.
/// @param obj The object.
/// @param bRemoveKey TRUE/FALSE
void NWNX_Object_SetAutoRemoveKey(object obj, int bRemoveKey);

/// @brief Get the geometry of a trigger
/// @param oTrigger The trigger object.
/// @return A string of vertex positions.
string NWNX_Object_GetTriggerGeometry(object oTrigger);

/// @brief Set the geometry of a trigger with a list of vertex positions
/// @param oTrigger The trigger object.
/// @param sGeometry Needs to be in the following format -> {x.x, y.y, z.z} or {x.x, y.y}
/// Example Geometry: "{1.0, 1.0, 0.0}{4.0, 1.0, 0.0}{4.0, 4.0, 0.0}{1.0, 4.0, 0.0}"
///
/// @remark The Z position is optional and will be calculated dynamically based
/// on terrain height if it's not provided.
///
/// @remark The minimum number of vertices is 3.
void NWNX_Object_SetTriggerGeometry(object oTrigger, string sGeometry);

/// @brief Export an object to the UserDirectory/nwnx folder.
/// @param sFileName The filename without extension, 16 or less characters.
/// @param oObject The object to export. Valid object types: Creature, Item, Placeable, Waypoint, Door, Store, Trigger
/// @param sAlias The alias of the resource directory to add the .git file to. Default: UserDirectory/nwnx
void NWNX_Object_Export(object oObject, string sFileName, string sAlias = "NWNX");

/// @brief Get oObject's integer variable sVarName.
/// @param oObject The object to get the variable from.
/// @param sVarName The variable name.
/// @return The value or 0 on error.
int NWNX_Object_GetInt(object oObject, string sVarName);

/// @brief Set oObject's integer variable sVarName to nValue.
/// @param oObject The object to set the variable on.
/// @param sVarName The variable name.
/// @param nValue The integer value to to set
/// @param bPersist When TRUE, the value is persisted to GFF, this means that it'll be saved in the .bic file of a player's character or when an object is serialized.
void NWNX_Object_SetInt(object oObject, string sVarName, int nValue, int bPersist);

/// @brief Delete oObject's integer variable sVarName.
/// @param oObject The object to delete the variable from.
/// @param sVarName The variable name.
void NWNX_Object_DeleteInt(object oObject, string sVarName);

/// @brief Get oObject's string variable sVarName.
/// @param oObject The object to get the variable from.
/// @param sVarName The variable name.
/// @return The value or "" on error.
string NWNX_Object_GetString(object oObject, string sVarName);

/// @brief Set oObject's string variable sVarName to sValue.
/// @param oObject The object to set the variable on.
/// @param sVarName The variable name.
/// @param sValue The string value to to set
/// @param bPersist When TRUE, the value is persisted to GFF, this means that it'll be saved in the .bic file of a player's character or when an object is serialized.
void NWNX_Object_SetString(object oObject, string sVarName, string sValue, int bPersist);

/// @brief Delete oObject's string variable sVarName.
/// @param oObject The object to delete the variable from.
/// @param sVarName The variable name.
void NWNX_Object_DeleteString(object oObject, string sVarName);

/// @brief Get oObject's float variable sVarName.
/// @param oObject The object to get the variable from.
/// @param sVarName The variable name.
/// @return The value or 0.0f on error.
float NWNX_Object_GetFloat(object oObject, string sVarName);

/// @brief Set oObject's float variable sVarName to fValue.
/// @param oObject The object to set the variable on.
/// @param sVarName The variable name.
/// @param fValue The float value to to set
/// @param bPersist When TRUE, the value is persisted to GFF, this means that it'll be saved in the .bic file of a player's character or when an object is serialized.
void NWNX_Object_SetFloat(object oObject, string sVarName, float fValue, int bPersist);

/// @brief Delete oObject's persistent float variable sVarName.
/// @param oObject The object to delete the variable from.
/// @param sVarName The variable name.
void NWNX_Object_DeleteFloat(object oObject, string sVarName);

/// @brief Delete any variables that match sRegex
/// @note It will only remove variables set by NWNX_Object_Set{Int|String|Float}()
/// @param oObject The object to delete the variables from.
/// @param sRegex The regular expression, for example .*Test.* removes every variable that has Test in it.
void NWNX_Object_DeleteVarRegex(object oObject, string sRegex);

/// @brief Get if vPosition is inside oTrigger's geometry.
/// @note The Z value of vPosition is ignored.
/// @param oTrigger The trigger.
/// @param vPosition The position.
/// @return TRUE if vPosition is inside oTrigger's geometry.
int NWNX_Object_GetPositionIsInTrigger(object oTrigger, vector vPosition);

/// @brief Gets the given object's internal type (NWNX_OBJECT_TYPE_INTERNAL_*)
/// @param oObject The object.
/// @return The object's type (NWNX_OBJECT_TYPE_INTERNAL_*)
int NWNX_Object_GetInternalObjectType(object oObject);

/// @brief Have oObject acquire oItem.
/// @note Useful to give deserialized items to an object, may not work if oItem is already possessed by an object.
/// @param oObject The object receiving oItem, must be a Creature, Placeable, Store or Item
/// @param oItem The item.
/// @return TRUE on success.
int NWNX_Object_AcquireItem(object oObject, object oItem);

/// @brief Clear all spell effects oObject has applied to others.
/// @param oObject The object that applied the spell effects.
void NWNX_Object_ClearSpellEffectsOnOthers(object oObject);

/// @brief Peek at the UUID of oObject without assigning one if it does not have one
/// @param oObject The object
/// @return The UUID or "" when the object does not have or cannot have an UUID
string NWNX_Object_PeekUUID(object oObject);

/// @brief Get if oDoor has a visible model.
/// @param oDoor The door
/// @return TRUE if oDoor has a visible model
int NWNX_Object_GetDoorHasVisibleModel(object oDoor);

/// @brief Get if oObject is destroyable.
/// @param oObject The object
/// @return TRUE if oObject is destroyable.
int NWNX_Object_GetIsDestroyable(object oObject);

/// @brief Checks for specific spell immunity. Should only be called in spellscripts
/// @param oDefender The object defending against the spell.
/// @param oCaster The object casting the spell.
/// @param nSpellId The casted spell id. Default value is -1, which corrresponds to the normal game behaviour.
/// @return -1 if defender has no immunity, 2 if the defender is immune
int NWNX_Object_DoSpellImmunity(object oDefender, object oCaster, int nSpellId=-1);

/// @brief Checks for spell school/level immunities and mantles. Should only be called in spellscripts
/// @param oDefender The object defending against the spell.
/// @param oCaster The object casting the spell.
/// @param nSpellId The casted spell id. Default value is -1, which corrresponds to the normal game behaviour.
/// @param nSpellLevel The level of the casted spell. Default value is -1, which corrresponds to the normal game behaviour.
/// @param nSpellSchool The school of the casted spell (SPELL_SCHOOL_* constant). Default value is -1, which corrresponds to the normal game behaviour.
/// @return -1 defender no immunity. 2 if immune. 3 if immune, but the immunity has a limit (example: mantles)
int NWNX_Object_DoSpellLevelAbsorption(object oDefender, object oCaster, int nSpellId=-1, int nSpellLevel=-1, int nSpellSchool=-1);

/// @brief Sets if a placeable has an inventory.
/// @param obj The placeable.
/// @param bHasInventory TRUE/FALSE
/// @note Only works on placeables.
void NWNX_Object_SetHasInventory(object obj, int bHasInventory);

/// @brief Get the current animation of oObject
/// @note The returned value will be an engine animation constant, not a NWScript ANIMATION_ constant.
///       See: https://github.com/nwnxee/unified/blob/master/NWNXLib/API/Constants/Animation.hpp
/// @param oObject The object
/// @return -1 on error or the engine animation constant
int NWNX_Object_GetCurrentAnimation(object oObject);

/// @brief Gets the AI level of an object.
/// @param oObject The object.
/// @return The AI level (AI_LEVEL_* -1 to 4).
int NWNX_Object_GetAILevel(object oObject);

/// @brief Sets the AI level of an object.
/// @param oObject The object.
/// @param nLevel The level to set (AI_LEVEL_* -1 to 4).
void NWNX_Object_SetAILevel(object oObject, int nLevel);

/// @brief Retrieves the Map Note (AKA Map Pin) from a waypoint - Returns even if currently disabled.
/// @param oObject The Waypoint object
/// @param nID The Language ID (default English)
/// @param nGender 0 = Male, 1 = Female
string NWNX_Object_GetMapNote(object oObject, int nID = 0, int nGender = 0);

/// @brief Sets a Map Note (AKA Map Pin) to any waypoint, even if no previous map note. Only updates for clients on area-load. Use SetMapPinEnabled() as required.
/// @param oObject The Waypoint object
/// @param sMapNote The contents to set as the Map Note.
/// @param nID The Language ID (default English)
/// @param nGender 0 = Male, 1 = Female
void NWNX_Object_SetMapNote(object oObject, string sMapNote, int nID = 0, int nGender = 0);

/// @brief Gets the last spell cast feat of oObject.
/// @note Should be called in a spell script.
/// @param oObject The object.
/// @return The feat ID, or 65535 when not cast by a feat, or -1 on error.
int NWNX_Object_GetLastSpellCastFeat(object oObject);

/// @brief Sets the last object that triggered door or placeable trap.
/// @note Should be retrieved with GetEnteringObject.
/// @param oObject Door or placeable object
/// @param oLast Object that last triggered trap.
void NWNX_Object_SetLastTriggered(object oObject, object oLast);

/// @brief Gets the remaining duration of the AoE object.
/// @param oAoE The AreaOfEffect object.
/// @return The remaining duration, in seconds, or the zero on failure.
float NWNX_Object_GetAoEObjectDurationRemaining(object oAoE);

/// @brief Sets conversations started by oObject to be private or not.
/// @note ActionStartConversation()'s bPrivateConversation parameter will overwrite this flag.
/// @param oObject The object.
/// @param bPrivate TRUE/FALSE.
void NWNX_Object_SetConversationPrivate(object oObject, int bPrivate);

/// @brief Sets the radius of a circle AoE object.
/// @param oAoE The AreaOfEffect object.
/// @param fRadius The radius, must be bigger than 0.0f.
void NWNX_Object_SetAoEObjectRadius(object oAoE, float fRadius);

/// @brief Gets the radius of a circle AoE object.
/// @param oAoE The AreaOfEffect object.
/// @return The radius or 0.0f on error
float NWNX_Object_GetAoEObjectRadius(object oAoE);

/// @brief Gets whether the last spell cast of oObject was spontaneous.
/// @note Should be called in a spell script.
/// @param oObject The object.
/// @return true if the last spell was cast spontaneously
int NWNX_Object_GetLastSpellCastSpontaneous(object oObject);

/// @brief Gets the last spell cast domain level.
/// @note Should be called in a spell script.
/// @param oObject The object.
/// @return Domain level of the cast spell, 0 if not a domain spell
int NWNX_Object_GetLastSpellCastDomainLevel(object oObject);

/// @brief Force the given object to carry the given UUID. Any other object currently owning the UUID is stripped of it.
/// @param oObject The object
/// @param sUUID The UUID to force
void NWNX_Object_ForceAssignUUID(object oObject, string sUUID);

/// @brief Returns how many items are in oObject's inventory.
/// @param oObject A creature, placeable, or item.
/// @return Returns a count of how many items are in oObject's inventory.
int NWNX_Object_GetInventoryItemCount(object oObject);

/// @brief Override the projectile visual effect of ranged/throwing weapons and spells.
/// @param oCreature The creature.
/// @param nProjectileType A @ref projectile_types "NWNX_OBJECT_SPELL_PROJECTILE_TYPE_*" constant or -1 to remove the override.
/// @param nProjectilePathType A "PROJECTILE_PATH_TYPE_*" constant or -1 to ignore.
/// @param nSpellID A "SPELL_*" constant. -1 to ignore.
/// @param bPersist Whether the override should persist to the .bic file (for PCs).
/// @note Persistence is enabled after a server reset by the first use of this function. Recommended to trigger on a dummy target OnModuleLoad to enable persistence.
///       This will override all spell projectile VFX from oCreature until the override is removed.
void NWNX_Object_OverrideSpellProjectileVFX(object oCreature, int nProjectileType = -1, int nProjectilePathType = -1, int nSpellID = -1, int bPersist = FALSE);

/// @brief Returns TRUE if the last spell was cast instantly. This function should only be called in a spell script.
/// @note To initialize the hooks used by this function it is recommended to call this function once in your module load script.
/// @return TRUE if the last spell was instant.
int NWNX_Object_GetLastSpellInstant();

/// @brief Sets the creator of a trap on door, placeable, or trigger. Also changes trap Faction to that of the new Creator.
/// @note Triggers (ground traps) will instantly update colour (Green/Red). Placeable/doors will not change if client has already seen them.
/// @param oObject Door, placeable or trigger (trap) object
/// @param oCreator The new creator of the trap. Any non-creature creator will assign OBJECT_INVALID (similar to toolset-laid traps)
void NWNX_Object_SetTrapCreator(object oObject, object oCreator);

/// @}

int NWNX_Object_GetLocalVariableCount(object obj)
{
    string sFunc = "GetLocalVariableCount";

    NWNX_PushArgumentObject(obj);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

struct NWNX_Object_LocalVariable NWNX_Object_GetLocalVariable(object obj, int index)
{
    string sFunc = "GetLocalVariable";

    NWNX_PushArgumentInt(index);
    NWNX_PushArgumentObject(obj);
    NWNX_CallFunction(NWNX_Object, sFunc);

    struct NWNX_Object_LocalVariable var;
    var.key  = NWNX_GetReturnValueString();
    var.type = NWNX_GetReturnValueInt();
    return var;
}

void NWNX_Object_SetPosition(object oObject, vector vPosition, int bUpdateSubareas = TRUE)
{
    string sFunc = "SetPosition";

    NWNX_PushArgumentInt(bUpdateSubareas);
    NWNX_PushArgumentFloat(vPosition.x);
    NWNX_PushArgumentFloat(vPosition.y);
    NWNX_PushArgumentFloat(vPosition.z);
    NWNX_PushArgumentObject(oObject);

    NWNX_CallFunction(NWNX_Object, sFunc);
}

int NWNX_Object_GetCurrentHitPoints(object creature)
{
    string sFunc = "GetCurrentHitPoints";

    NWNX_PushArgumentObject(creature);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

void NWNX_Object_SetCurrentHitPoints(object creature, int hp)
{
    string sFunc = "SetCurrentHitPoints";

    NWNX_PushArgumentInt(hp);
    NWNX_PushArgumentObject(creature);

    NWNX_CallFunction(NWNX_Object, sFunc);
}

void NWNX_Object_SetMaxHitPoints(object creature, int hp)
{
    string sFunc = "SetMaxHitPoints";

    NWNX_PushArgumentInt(hp);
    NWNX_PushArgumentObject(creature);

    NWNX_CallFunction(NWNX_Object, sFunc);
}

string NWNX_Object_Serialize(object obj)
{
    string sFunc = "Serialize";

    NWNX_PushArgumentObject(obj);

    NWNX_CallFunction(NWNX_Object, sFunc);
    return NWNX_GetReturnValueString();
}

object NWNX_Object_Deserialize(string serialized)
{
    string sFunc = "Deserialize";

    NWNX_PushArgumentString(serialized);

    NWNX_CallFunction(NWNX_Object, sFunc);
    return NWNX_GetReturnValueObject();
}

string NWNX_Object_GetDialogResref(object obj)
{
    string sFunc = "GetDialogResref";

    NWNX_PushArgumentObject(obj);

    NWNX_CallFunction(NWNX_Object, sFunc);
    return NWNX_GetReturnValueString();
}

void NWNX_Object_SetDialogResref(object obj, string dialog)
{
    string sFunc = "SetDialogResref";

    NWNX_PushArgumentString(dialog);
    NWNX_PushArgumentObject(obj);

    NWNX_CallFunction(NWNX_Object, sFunc);
}

void NWNX_Object_SetAppearance(object oPlaceable, int nAppearance)
{
    string sFunc = "SetAppearance";

    NWNX_PushArgumentInt(nAppearance);
    NWNX_PushArgumentObject(oPlaceable);

    NWNX_CallFunction(NWNX_Object, sFunc);
}

int NWNX_Object_GetAppearance(object oPlaceable)
{
    string sFunc = "GetAppearance";

    NWNX_PushArgumentObject(oPlaceable);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

int NWNX_Object_GetHasVisualEffect(object obj, int nVFX)
{
    string sFunc = "GetHasVisualEffect";

    NWNX_PushArgumentInt(nVFX);
    NWNX_PushArgumentObject(obj);

    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

int NWNX_Object_GetDamageImmunity(object obj, int damageType)
{
    string sFunc = "GetDamageImmunity";

    NWNX_PushArgumentInt(damageType);
    NWNX_PushArgumentObject(obj);

    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

void NWNX_Object_AddToArea(object obj, object area, vector pos)
{
    string sFunc = "AddToArea";

    NWNX_PushArgumentFloat(pos.z);
    NWNX_PushArgumentFloat(pos.y);
    NWNX_PushArgumentFloat(pos.x);
    NWNX_PushArgumentObject(area);
    NWNX_PushArgumentObject(obj);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

int NWNX_Object_GetPlaceableIsStatic(object obj)
{
    string sFunc = "GetPlaceableIsStatic";

    NWNX_PushArgumentObject(obj);

    NWNX_CallFunction(NWNX_Object, sFunc);
    return NWNX_GetReturnValueInt();
}

void NWNX_Object_SetPlaceableIsStatic(object obj, int isStatic)
{
    string sFunc = "SetPlaceableIsStatic";

    NWNX_PushArgumentInt(isStatic);
    NWNX_PushArgumentObject(obj);

    NWNX_CallFunction(NWNX_Object, sFunc);
}

int NWNX_Object_GetAutoRemoveKey(object obj)
{
    string sFunc = "GetAutoRemoveKey";

    NWNX_PushArgumentObject(obj);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

void NWNX_Object_SetAutoRemoveKey(object obj, int bRemoveKey)
{
    string sFunc = "SetAutoRemoveKey";

    NWNX_PushArgumentInt(bRemoveKey);
    NWNX_PushArgumentObject(obj);

    NWNX_CallFunction(NWNX_Object, sFunc);
}

string NWNX_Object_GetTriggerGeometry(object oTrigger)
{
    string sFunc = "GetTriggerGeometry";

    NWNX_PushArgumentObject(oTrigger);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueString();
}

void NWNX_Object_SetTriggerGeometry(object oTrigger, string sGeometry)
{
    string sFunc = "SetTriggerGeometry";

    NWNX_PushArgumentString(sGeometry);
    NWNX_PushArgumentObject(oTrigger);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

void NWNX_Object_Export(object oObject, string sFileName, string sAlias = "NWNX")
{
    string sFunc = "Export";

    NWNX_PushArgumentString(sAlias);
    NWNX_PushArgumentString(sFileName);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

int NWNX_Object_GetInt(object oObject, string sVarName)
{
    string sFunc = "GetInt";

    NWNX_PushArgumentString(sVarName);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

void NWNX_Object_SetInt(object oObject, string sVarName, int nValue, int bPersist)
{
    string sFunc = "SetInt";

    NWNX_PushArgumentInt(bPersist);
    NWNX_PushArgumentInt(nValue);
    NWNX_PushArgumentString(sVarName);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

void NWNX_Object_DeleteInt(object oObject, string sVarName)
{
    string sFunc = "DeleteInt";

    NWNX_PushArgumentString(sVarName);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

string NWNX_Object_GetString(object oObject, string sVarName)
{
    string sFunc = "GetString";

    NWNX_PushArgumentString(sVarName);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueString();
}

void NWNX_Object_SetString(object oObject, string sVarName, string sValue, int bPersist)
{
    string sFunc = "SetString";

    NWNX_PushArgumentInt(bPersist);
    NWNX_PushArgumentString(sValue);
    NWNX_PushArgumentString(sVarName);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

void NWNX_Object_DeleteString(object oObject, string sVarName)
{
    string sFunc = "DeleteString";

    NWNX_PushArgumentString(sVarName);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

float NWNX_Object_GetFloat(object oObject, string sVarName)
{
    string sFunc = "GetFloat";

    NWNX_PushArgumentString(sVarName);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueFloat();
}

void NWNX_Object_SetFloat(object oObject, string sVarName, float fValue, int bPersist)
{
    string sFunc = "SetFloat";

    NWNX_PushArgumentInt(bPersist);
    NWNX_PushArgumentFloat(fValue);
    NWNX_PushArgumentString(sVarName);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

void NWNX_Object_DeleteFloat(object oObject, string sVarName)
{
    string sFunc = "DeleteFloat";

    NWNX_PushArgumentString(sVarName);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

void NWNX_Object_DeleteVarRegex(object oObject, string sRegex)
{
    string sFunc = "DeleteVarRegex";

    NWNX_PushArgumentString(sRegex);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

int NWNX_Object_GetPositionIsInTrigger(object oTrigger, vector vPosition)
{
    string sFunc = "GetPositionIsInTrigger";

    NWNX_PushArgumentFloat(vPosition.z);
    NWNX_PushArgumentFloat(vPosition.y);
    NWNX_PushArgumentFloat(vPosition.x);
    NWNX_PushArgumentObject(oTrigger);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

int NWNX_Object_GetInternalObjectType(object oObject)
{
    string sFunc = "GetInternalObjectType";

    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

int NWNX_Object_AcquireItem(object oObject, object oItem)
{
    string sFunc = "AcquireItem";

    NWNX_PushArgumentObject(oItem);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

void NWNX_Object_ClearSpellEffectsOnOthers(object oObject)
{
    string sFunc = "ClearSpellEffectsOnOthers";

    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

string NWNX_Object_PeekUUID(object oObject)
{
    string sFunc = "PeekUUID";

    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueString();
}

int NWNX_Object_GetDoorHasVisibleModel(object oDoor)
{
    string sFunc = "GetDoorHasVisibleModel";

    NWNX_PushArgumentObject(oDoor);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

int NWNX_Object_GetIsDestroyable(object oObject)
{
    string sFunc = "GetIsDestroyable";

    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

int NWNX_Object_DoSpellImmunity(object oDefender, object oCaster, int nSpellId=-1)
{
    string sFunc = "DoSpellImmunity";
    NWNX_PushArgumentInt(nSpellId);
    NWNX_PushArgumentObject(oCaster);
    NWNX_PushArgumentObject(oDefender);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return  NWNX_GetReturnValueInt();
}

int NWNX_Object_DoSpellLevelAbsorption(object oDefender, object oCaster, int nSpellId=-1, int nSpellLevel=-1, int nSpellSchool=-1)
{
    string sFunc = "DoSpellLevelAbsorption";
    NWNX_PushArgumentInt(nSpellSchool);
    NWNX_PushArgumentInt(nSpellLevel);
    NWNX_PushArgumentInt(nSpellId);
    NWNX_PushArgumentObject(oCaster);
    NWNX_PushArgumentObject(oDefender);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return  NWNX_GetReturnValueInt();
}

void NWNX_Object_SetHasInventory(object obj, int bHasInventory)
{
    string sFunc = "SetHasInventory";

    NWNX_PushArgumentInt(bHasInventory);
    NWNX_PushArgumentObject(obj);

    NWNX_CallFunction(NWNX_Object, sFunc);
}

int NWNX_Object_GetCurrentAnimation(object oObject)
{
    string sFunc = "GetCurrentAnimation";

    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

int NWNX_Object_GetAILevel(object oObject)
{
    string sFunc = "GetAILevel";

    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

void NWNX_Object_SetAILevel(object oObject, int nLevel)
{
    string sFunc = "SetAILevel";

    NWNX_PushArgumentInt(nLevel);
    NWNX_PushArgumentObject(oObject);

    NWNX_CallFunction(NWNX_Object, sFunc);
}

string NWNX_Object_GetMapNote(object oObject, int nID = 0, int nGender = 0)
{
    string sFunc = "GetMapNote";

    NWNX_PushArgumentInt(nGender);
    NWNX_PushArgumentInt(nID);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueString();
}

void NWNX_Object_SetMapNote(object oObject, string sMapNote, int nID = 0, int nGender = 0)
{
    string sFunc = "SetMapNote";

    NWNX_PushArgumentInt(nGender);
    NWNX_PushArgumentInt(nID);
    NWNX_PushArgumentString(sMapNote);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

int NWNX_Object_GetLastSpellCastFeat(object oObject)
{
    string sFunc = "GetLastSpellCastFeat";

    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

void NWNX_Object_SetLastTriggered(object oObject, object oLast)
{
    string sFunc = "SetLastTriggered";

    NWNX_PushArgumentObject(oLast);
    NWNX_PushArgumentObject(oObject);

    NWNX_CallFunction(NWNX_Object, sFunc);
}

float NWNX_Object_GetAoEObjectDurationRemaining(object oAoE)
{
    string sFunc = "GetAoEObjectDurationRemaining";

    NWNX_PushArgumentObject(oAoE);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueFloat();
}

void NWNX_Object_SetConversationPrivate(object oObject, int bPrivate)
{
    string sFunc = "SetConversationPrivate";

    NWNX_PushArgumentInt(bPrivate);
    NWNX_PushArgumentObject(oObject);

    NWNX_CallFunction(NWNX_Object, sFunc);
}

void NWNX_Object_SetAoEObjectRadius(object oAoE, float fRadius)
{
    string sFunc = "SetAoEObjectRadius";

    NWNX_PushArgumentFloat(fRadius);
    NWNX_PushArgumentObject(oAoE);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

float NWNX_Object_GetAoEObjectRadius(object oAoE)
{
    string sFunc = "GetAoEObjectRadius";

    NWNX_PushArgumentObject(oAoE);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueFloat();
}

int NWNX_Object_GetLastSpellCastSpontaneous(object oObject)
{
    string sFunc = "GetLastSpellCastSpontaneous";

    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

int NWNX_Object_GetLastSpellCastDomainLevel(object oObject)
{
    string sFunc = "GetLastSpellCastDomainLevel";

    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);

    return NWNX_GetReturnValueInt();
}

void NWNX_Object_ForceAssignUUID(object oObject, string sUUID)
{
    string sFunc = "ForceAssignUUID";

    NWNX_PushArgumentString(sUUID);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

int NWNX_Object_GetInventoryItemCount(object oObject)
{
    string sFunc = "GetInventoryItemCount";

    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);
    return NWNX_GetReturnValueInt();
}

void NWNX_Object_OverrideSpellProjectileVFX(object oCreature, int nProjectileType = -1, int nProjectilePathType = -1, int nSpellID = -1, int bPersist = FALSE)
{
    string sFunc = "OverrideSpellProjectileVFX";

    NWNX_PushArgumentInt(bPersist);
    NWNX_PushArgumentInt(nSpellID);
    NWNX_PushArgumentInt(nProjectilePathType);
    NWNX_PushArgumentInt(nProjectileType);
    NWNX_PushArgumentObject(oCreature);
    NWNX_CallFunction(NWNX_Object, sFunc);
}

int NWNX_Object_GetLastSpellInstant()
{
    string sFunc = "GetLastSpellInstant";
    NWNX_CallFunction(NWNX_Object, sFunc);
    return NWNX_GetReturnValueInt();
}

void NWNX_Object_SetTrapCreator(object oObject, object oCreator)
{
    string sFunc = "SetTrapCreator";
    NWNX_PushArgumentObject(oCreator);
    NWNX_PushArgumentObject(oObject);
    NWNX_CallFunction(NWNX_Object, sFunc);
}
