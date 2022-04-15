#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Starts the presentation.
 *
 *  Parameter(s):
 *      0: BOOLEAN - Continue presentation. (Don't change any slide, while taking control)
 *      1: NUMBER - Topic. Numbers originate from the variable mts_presentation_topics (not needed if parameter 0 is true) (Optional, default: -1. Get information from the dialog)
 *      2: NUMBER - Page. Numbers originate from the variable mts_presentation_topics (not needed if parameter 0 is true) (Optional, default: 1. First slide)
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [false, 0, 1] call mts_presentation_fnc_startPresentation
 *
 */
params [["_continue", false, [false]], ["_topic", -1, [0]], ["_page", 1, [0]]];
TRACE_3("Before processing", _continue, _topic, _page);

scopeName "function";

private _presenter = GVAR(presenter);
private _player = CURRENT_PLAYER;

//check whether the controls are already occupied or the presenter is unable to present.
if (!isNull _presenter) then {
    if (!alive _presenter || (_presenter getVariable ["ACE_isUnconscious", false])) then {
        _presenter = _player;
    };
    if !(_presenter isEqualTo _player) then {
        [[LLSTRING(mod_name), 1.2, [1, 1, 0, 1]], LLSTRING(presenter_slot_occupied_line_1), format[LLSTRING(presenter_slot_occupied_line_2), name _presenter], false] call CBA_fnc_notify;
        breakOut "function";
    };
} else {
    _presenter = _player
};


//check if given parameters are usable for presentation
if (!_continue) then {
    if (_topic isEqualTo -1) then {
        private _mainDisplay = findDisplay IDD_MAIN_DISPLAY;
        if (isNull _mainDisplay) then {
            ERROR("Failed to retrieve main display!");
            breakOut "function";
        };
        private _listboxCtrl = (_mainDisplay displayCtrl IDC_LISTBOX);

        _topic = _listboxCtrl lbValue (lbCurSel _listboxCtrl);
        _page =  (lbCurSel (_mainDisplay displayCtrl IDC_COMBOBOX)) + 1;
    } else {
        if (_topic < 0 && _page < 1) then {
            ERROR("Parameters invalid!")
            breakOut "function";
        };
    };
    [true] call FUNC(stopPresentation);

    missionNamespace setVariable [QGVAR(topic), _topic, true];
    missionNamespace setVariable [QGVAR(currentPage), _page, true];

    if (GVAR(screens) isEqualTo []) then {
        [[LLSTRING(mod_name), 1.2, [1, 1, 0, 1]], LLSTRING(no_screen_to_display), false] call CBA_fnc_notify;
        INFO("No screen available to display presentation.")
        breakOut "function";
    };
};
TRACE_3("After processing", _continue, _topic, _page);

SET_SLIDE call FUNC(changeSlide);

if (GVAR(cba_settings_actions) isEqualTo "ace_interaction" && GVAR(ace_interact_menu_loaded)) then {
    private _action = [
    QGVAR(stopPresentation),
    LLSTRING(actions_stop_presentation),
    "",
    {
        [] call FUNC(stopPresentation);
    },
    {
        [_player, _target] call ace_common_fnc_canInteractWith;
    }
    ] call ace_interact_menu_fnc_createAction;

    GVAR(aceSelfInteractionArray) = [_presenter, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
} else {
    GVAR(actionID) = _presenter addAction [
        LLSTRING(actions_stop_presentation),
        {
            [] call FUNC(stopPresentation);
        },
        nil,
        1.5,
        true,
        true,
        "",
        "_target isEqualTo _this"
    ];
};

[_player, "killed", {
    _thisArgs params ["_player"];
    [] call FUNC(stopPresentation);
    _player removeEventhandler ["killed", _thisID];
}] call CBA_fnc_addBISEventHandler;

missionNamespace setVariable [QGVAR(presenter), _presenter, true];
closeDialog 1;
