#include "script_component.hpp"

GVAR(topics) = [];
//get all topics from config
private _topics = configfile >> QGVAR(topics);

private ["_topic", "_displayName", "_path", "_pages", "_extension"];
for "_i" from 0 to (count _topics - 1) do {
    _topic = configName (_topics select _i);
    _displayName = getText (_topics >> _topic >> "displayName");
    _path = getText (_topics >>  _topic >> "path");
    _pages = getNumber (_topics >>  _topic >> "pages");
    _extension = toLower (getText (_topics >>  _topic >> "extension"));

    GVAR(topics) pushBack [_displayName, _path, _pages, _extension];
};
TRACE_1("", GVAR(topics));

//set default values
GVAR(topic) = 0;
GVAR(currentPage) = 1;
GVAR(presenter) = objNull;
GVAR(videoRunning) = false;
uiNamespace setVariable [QGVAR(videoCtrl), controlNull]; //missionnamespace? [ctrl, display, display]

//parse cba settings variables for screens
private "_screen";
GVAR(screens) = [];
{
    _screen = missionNamespace getVariable [_x, objNull];
    if ((count ([getObjectTextures _screen] param [0,[]])) > 0) then {
        GVAR(screens) pushBack _screen;
    };
} forEach ((GVAR(cba_settings_screens) call CBA_fnc_removeWhitespace) splitString ",");

//parse cba settings variables for controls
private "_control";
GVAR(controls) = [];
{
    _control = missionNamespace getVariable [_x, objNull];
    if (!(isNull _control) && !(isSimpleObject _control)) then {
        GVAR(controls) pushBack _control;
    };
} forEach ((GVAR(cba_settings_controls) call CBA_fnc_removeWhitespace) splitString ",");

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



//18:34:24 WARNING: Function 'name' - B Alpha 1-2:1 REMOTE (p_1) has empty name
//when server shutdown and remote unit is presenter
