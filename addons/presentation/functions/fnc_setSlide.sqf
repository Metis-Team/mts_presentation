#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Sets the given slide on all screens.
 *
 *  Parameter(s):
 *      0: STRING - Full slide path. (e.g. "my_slide_mod\test_images\slide1.jpg")
 *      1: STRING - Full slide path for the next slide (preview slide for the presenter) (e.g. "my_slide_mod\test_images\slide2.jpg")
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["my_slide_mod\test_images\slide1.jpg", "my_slide_mod\test_images\slide2.jpg"] call mts_presentation_fnc_setSlide
 *
 */
params [["_slide", "", [""]], ["_previewSlide", "", [""]]];
TRACE_2("",_slide,_previewSlide);

private _extension = _slide select [(count _slide) - 3 , 3];
CHECKRET(!(_extension in [ARR_3("ogv","jpg","paa")]),ERROR_1("Not supported media format: %1",_extension));


//set world screens
if (_extension isEqualTo "ogv") then {
    //stop any video that could currently running
    QGVAR(stopVideo) call CBA_fnc_globalEvent;
    [QGVAR(startVideo), _slide] call CBA_fnc_globalEvent;
} else {
    {
        _x setObjectTextureGlobal [0, _slide];
    } forEach GVAR(screens);
};

//set presenter display screens
private _displayData = [];

if (GVAR(displayCurrentSlide)) then {
    _displayData pushBack [((uiNamespace getVariable [QGVAR(curSlideDisplay), displayNull]) displayCtrl IDC_DISPLAY_PICTURE), _slide];
};
if (GVAR(previewNextSlide) && !GVAR(disablePreview)) then {
    _displayData pushBack [((uiNamespace getVariable [QGVAR(previewNextSlideDisp), displayNull]) displayCtrl IDC_DISPLAY_PICTURE), _previewSlide];
};

TRACE_1("",_displayData);
{
    (_x select 0) ctrlSetText (_x select 1);
} forEach _displayData;
