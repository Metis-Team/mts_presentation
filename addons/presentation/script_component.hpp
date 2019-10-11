#define COMPONENT presentation
#define COMPONENT_BEAUTIFIED Presentation
#include "\z\mts_presentation\addons\presentation\script_mod.hpp"

 #define DEBUG_MODE_FULL
 #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS

#ifdef DEBUG_ENABLED_PRESENTATION
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_PRESENTATION
    #define DEBUG_SETTINGS DEBUG_SETTINGS_PRESENTATION
#endif

#include "\z\mts_presentation\addons\presentation\script_macros.hpp"

//Dialog IDDs/IDCs
#include "\z\mts_presentation\addons\presentation\ui\mts_presentation_ui_macros.hpp"

#define NEXT_SLIDE 1
#define SET_SLIDE 0
#define PREVIOUS_SLIDE -1
#define DISPLAY_COMMIT_SPEED 0.2
#define CURRENT_PLAYER (missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player])
