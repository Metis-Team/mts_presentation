#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Stops the presentation.
 *
 *  Parameter(s):
 *      0: BOOLEAN - Local maschine is not the presenter. (Optional, default: false)
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_presentation_fnc_stopPresentation
 *
 */

 params [["_notLocal", false, [false]]];

if (!_notLocal) then {
    if (hasInterface && GVAR(presenter) isEqualTo CURRENT_PLAYER) then {
        (uiNamespace getVariable [QGVAR(curSlideDisplay), displayNull]) closeDisplay 1;
        uiNamespace setVariable [QGVAR(curSlideDisplay), displayNull];

        (uiNamespace getVariable [QGVAR(previewNextSlideDisp), displayNull]) closeDisplay 1;
        uiNamespace setVariable [QGVAR(previewNextSlideDisp), displayNull];

        QGVAR(stopVideo) call CBA_fnc_globalEvent;

        if (GVAR(cba_settings_actions) isEqualTo "ace_interaction" && GVAR(ace_interact_menu_loaded)) then {
            [GVAR(presenter), 1, GVAR(aceSelfInteractionArray)] call ace_interact_menu_fnc_removeActionFromObject;
        } else {
            GVAR(presenter) removeAction GVAR(actionID);
        };
        missionNamespace setVariable [QGVAR(presenter), objNull, true];
    } else {
        if (!isNull GVAR(presenter)) then {
            remoteExecCall [QFUNC(stopPresentation), GVAR(presenter)];
        };
    };
};
