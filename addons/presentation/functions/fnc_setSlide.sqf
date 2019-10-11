#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Sets the given slide on all screens.
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
params [["_slide", "", [""]], ["_previewSlide", "", [""]]];
TRACE_2("", _slide, _previewSlide);

private _extension = _slide select [(count _slide) - 3 , 3];
CHECK(!(_extension in [ARR_4("ogv", "jpg", "jpeg", "paa")]));

//set world screens
if 	(_extension isEqualTo "ogv") then {
    //stop any video that could currently running
    QGVAR(stopVideo) call CBA_fnc_globalEvent;
    [QGVAR(startVideo), _slide] call CBA_fnc_globalEvent;
};
if (_extension in ["jpg", "jpeg", "paa"]) then {
    {
        _x setObjectTextureGlobal [0, _slide];
        } forEach GVAR(screens);
};

//check locality
//set presenter display screens
private _displayData = [];

if (GVAR(displayCurrentSlide)) then {
    _displayData pushBack [((uiNamespace getVariable [QGVAR(curSlideDisplay), displayNull]) displayCtrl IDC_DISPLAY_PICTURE), _slide];
};
if (GVAR(previewNextSlide) && !GVAR(disablePreview)) then {
    _displayData pushBack [((uiNamespace getVariable [QGVAR(previewNextSlideDisp), displayNull]) displayCtrl IDC_DISPLAY_PICTURE), _previewSlide];
};

TRACE_1("", _displayData);
{
    (_x select 0) ctrlSetText (_x select 1);
} forEach _displayData;
