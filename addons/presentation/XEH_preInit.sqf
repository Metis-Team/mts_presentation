#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;

GVAR(ace_interact_menu_loaded) = false;
if (isClass (configFile >> "CfgPatches" >> "ace_interact_menu")) then {
    GVAR(ace_interact_menu_loaded) = true;
};

#include "initKeybinds.hpp"
#include "initSettings.hpp"
