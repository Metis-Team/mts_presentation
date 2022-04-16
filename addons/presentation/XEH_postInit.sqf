#include "script_component.hpp"

GVAR(topics) = [];
//get all topics from config
[configfile >> QGVAR(topics)] call FUNC(getTopics);
[missionConfigFile >> QGVAR(topics)] call FUNC(getTopics);

TRACE_1("", GVAR(topics));

//set default values
if (isNil QGVAR(topic)) then {
    GVAR(topic) = 0;
};
if (isNil QGVAR(currentSlideNumber)) then {
    GVAR(currentSlideNumber) = 1;
};
if (isNil QGVAR(presenter)) then {
    GVAR(presenter) = objNull;
};
if (isNil QGVAR(videoRunning)) then {
    GVAR(videoRunning) = false;
};
if (isNil {uiNamespace getVariable QGVAR(videoCtrl)}) then {
    uiNamespace setVariable [QGVAR(videoCtrl), controlNull];
};

private _screens = (GVAR(cba_settings_screens) call CBA_fnc_removeWhitespace) splitString ",";
//parse cba settings variables for screens
private "_screen";
GVAR(screens) = [];
{
    _screen = missionNamespace getVariable [_x, objNull];
    TRACE_2("Screen", _screen, getObjectTextures _screen);

    if (isNull _screen) then {continue;};

    if ((count ([getObjectTextures _screen] param [0,[]])) > 0) then {
        GVAR(screens) pushBack _screen;
    };
} forEach _screens;

TRACE_2("CBA Screens", _screens, GVAR(screens));

private _controls = (GVAR(cba_settings_controls) call CBA_fnc_removeWhitespace) splitString ",";

//parse cba settings variables for controls
private "_control";
GVAR(controls) = [];
{
    _control = missionNamespace getVariable [_x, objNull];
    if (!(isNull _control) && !(isSimpleObject _control)) then {
        GVAR(controls) pushBack _control;
    };
} forEach _controls;

TRACE_2("CBA Controls", _controls, GVAR(controls));

//add actions to controls
if (GVAR(cba_settings_actions) isEqualTo "ace_interaction" && GVAR(ace_interact_menu_loaded)) then {
    private _action = [
        QGVAR(presentationMenu),
        LLSTRING(actions_presentation_menu),
        "",
        {
            [] call FUNC(openDialog);
        },
        {
            [_player, _target] call ace_common_fnc_canInteractWith;
        }
    ] call ace_interact_menu_fnc_createAction;

    {
        [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    } forEach GVAR(controls);
} else {
    {
        _x addAction [
            LLSTRING(actions_presentation_menu),
            {
                [] call FUNC(openDialog);
            },
            nil,
            1.5,
            true,
            true,
            "",
            "true",
            2
            ];
    } forEach GVAR(controls);
};



[QGVAR(startVideo), {
    params [["_video", "", [""]]];

    CHECK(_video isEqualTo "");

    private _videoCtrl = (uiNamespace getVariable [QGVAR(videoCtrl), controlNull]);

    //stop any video that is currently running
    _videoCtrl ctrlSetText "";
    //create display to start the video
    QGVAR(videoDisplay) cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
    private _videoDisplay = uiNamespace getVariable ["RscTitleDisplayEmpty", displayNull];

    _videoCtrl = _videoDisplay ctrlCreate ["RscVideo", -1];
    uiNamespace setVariable [QGVAR(videoCtrl), _videoCtrl];

    _videoCtrl ctrlAddEventHandler ["VideoStopped", {
        LOG("Video stopped");
        QGVAR(stopVideo) call CBA_fnc_localEvent;
    }];

    _videoCtrl ctrlSetPosition [10,10];
    _videoCtrl ctrlCommit 0;

    {
        _x setObjectTexture [0, _video];
    } forEach GVAR(screens);

    _videoCtrl ctrlSetText _video;
    GVAR(videoRunning) = true;
}] call CBA_fnc_addEventHandler;

[QGVAR(stopVideo), {
    if (GVAR(videoRunning)) then {
        (uiNamespace getVariable [QGVAR(videoCtrl), controlNull]) ctrlSetText "";
        {
            _x setObjectTexture [0, ""];
        } forEach GVAR(screens);
        GVAR(videoRunning) = false;
    };
}] call CBA_fnc_addEventHandler;

addMissionEventHandler ["HandleDisconnect", {
    params ["_player"];
    if (_player isEqualTo GVAR(presenter)) then {
        [true] call FUNC(stopPresentation);
    };
}];
