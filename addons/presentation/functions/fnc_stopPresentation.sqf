#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Stops the presentation.
 *
 *  Parameter(s):
 *      0: [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 *  Example:
 *      [[arguments]] call [function name]
 *
 */

 params [["_disconnect", false , [false]]];

if (!_disconnect) then {
    if (hasInterface && GVAR(presenter) isEqualTo CURRENT_PLAYER) then {
        (uiNamespace getVariable [QGVAR(curSlideDisplay), displayNull]) closeDisplay 1;
        uiNamespace setVariable [QGVAR(curSlideDisplay), displayNull];

        (uiNamespace getVariable [QGVAR(previewNextSlideDisp), displayNull]) closeDisplay 1;
        uiNamespace setVariable [QGVAR(previewNextSlideDisp), displayNull];

        if (GVAR(cba_settings_actions) isEqualTo "ace_interaction" && GVAR(ace_interact_menu_loaded)) then {
            [GVAR(presenter), 1, GVAR(aceSelfInteractionArray)] call ace_interact_menu_fnc_removeActionFromObject;
        } else {
            GVAR(presenter) removeAction GVAR(actionID);
        };
    } else {
        if (!isNull GVAR(presenter)) then {
            remoteExecCall [QFUNC(stopPresentation), GVAR(presenter)];
        };
    };
};

missionNamespace setVariable [QGVAR(presenter), objNull, true];
