#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Creates or changes size of displays for the presenter.
 *
 *  Parameter(s):
 *      0: STRING - Displaysize. Current values: "small" or "big"
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["small"] call mts_presentation_fnc_setDisplay
 *
 */

params [["_displaySize", GVAR(dispSlideSize), [""]]];

private ["_x", "_y", "_w", "_h"];
private _displayData = [];
private _commitSpeed = DISPLAY_COMMIT_SPEED;

if (GVAR(displayCurrentSlide)) then {
    private _curSlideDisp = uiNamespace getVariable [QGVAR(curSlideDisplay), displayNull];
    if (isNull _curSlideDisp) then {
        QGVAR(curSlideDisplay) cutRsc [QGVAR(curSlideDisplay), "PLAIN"];
        _curSlideDisp = uiNamespace getVariable [QGVAR(curSlideDisplay), displayNull];
        _commitSpeed = 0;
    };
    private _bgCtrl = _curSlideDisp displayCtrl IDC_DISPLAY_BACKGROUND;
    private _slideCtrl = _curSlideDisp displayCtrl IDC_DISPLAY_PICTURE;
    TRACE_3("displayCurrentSlide", _curSlideDisp, _bgCtrl, _slideCtrl);

    if (_displaySize isEqualTo "small") then {
        //small display
        _x = (SafeZoneX + (1363 / 1920) * SafeZoneW);
        _y = (SafeZoneY + (780 / 1080) * SafeZoneH);
        _w = ((532 / 1920) * SafeZoneW);
        _h = ((276 / 1080) * SafeZoneH);
        _displayData pushBack [_bgCtrl, [_x, _y, _w, _h]];

        _x = (SafeZoneX + (1373 / 1920) * SafeZoneW);
        _y = (SafeZoneY + (790 / 1080) * SafeZoneH);
        _w = ((512 / 1920) * SafeZoneW);
        _h = ((256 / 1080) * SafeZoneH);
        _displayData pushBack [_slideCtrl, [_x, _y, _w, _h]];
    } else {
        //big display
        _x = (SafeZoneX + (851/ 1920) * SafeZoneW);
        _y = (SafeZoneY + (524/ 1080) * SafeZoneH);
        _w = ((1044/ 1920) * SafeZoneW);
        _h = ((532/ 1080) * SafeZoneH);
        _displayData pushBack [_bgCtrl, [_x, _y, _w, _h]];

        _x = (SafeZoneX + (861 / 1920) * SafeZoneW);
        _y = (SafeZoneY + (534/ 1080) * SafeZoneH);
        _w = ((1024 / 1920) * SafeZoneW);
        _h = ((512/ 1080) * SafeZoneH);
        _displayData pushBack [_slideCtrl, [_x, _y, _w, _h]];
    };
};

if (GVAR(previewNextSlide) && !GVAR(disablePreview)) then {
    private _previewNextSlideDisp = uiNamespace getVariable [QGVAR(previewNextSlideDisp), displayNull];
    if (isNull _previewNextSlideDisp) then {
        QGVAR(previewNextSlideDisp) cutRsc [QGVAR(previewNextSlideDisp), "PLAIN"];
        _previewNextSlideDisp = uiNamespace getVariable [QGVAR(previewNextSlideDisp), displayNull];
        _commitSpeed = 0;
    };
    private _bgCtrl = _previewNextSlideDisp displayCtrl IDC_DISPLAY_BACKGROUND;
    private _slideCtrl = _previewNextSlideDisp displayCtrl IDC_DISPLAY_PICTURE;
    private _previewLblCtrl = _previewNextSlideDisp displayCtrl IDC_DISPLAY_PREVIEW_LABEL;
    private _previewBgLblCtrl = _previewNextSlideDisp displayCtrl IDC_DISPLAY_PREVIEW_BACKGROUND_LABEL;
    TRACE_5("previewNextSlide", _previewNextSlideDisp, _bgCtrl, _slideCtrl, _previewLblCtrl, _previewBgLblCtrl);

    if (GVAR(displayCurrentSlide)) then {
        if (_displaySize isEqualTo "small") then {
            //small display positioning
            _x = (SafeZoneX + (1363 / 1920) * SafeZoneW);
            _y = (SafeZoneY + (494 / 1080) * SafeZoneH);
            _displayData pushBack [_bgCtrl, [_x, _y]];

            _x = (SafeZoneX + (1373 / 1920) * SafeZoneW);
            _y = (SafeZoneY + (504 / 1080) * SafeZoneH);
            _displayData pushBack [_slideCtrl, [_x, _y]];
            _displayData pushBack [_previewLblCtrl, [_x, _y]];
            _displayData pushBack [_previewBgLblCtrl, [_x, _y]];
        } else {
            //big display positioning
            _x = (SafeZoneX + (1363/ 1920) * SafeZoneW);
            _y = (SafeZoneY + (238/ 1080) * SafeZoneH);
            _displayData pushBack [_bgCtrl, [_x, _y]];

            _x = (SafeZoneX + (1373 / 1920) * SafeZoneW);
            _y = (SafeZoneY + (248/ 1080) * SafeZoneH);
            _displayData pushBack [_slideCtrl, [_x, _y]];
            _displayData pushBack [_previewLblCtrl, [_x, _y]];
            _displayData pushBack [_previewBgLblCtrl, [_x, _y]];
        };
    } else {
        //without displayCurrentSlide
        _x = (SafeZoneX + (1363 / 1920) * SafeZoneW);
        _y = (SafeZoneY + (780 / 1080) * SafeZoneH);
        _displayData pushBack [_bgCtrl, [_x, _y]];

        _x = (SafeZoneX + (1373 / 1920) * SafeZoneW);
        _y = (SafeZoneY + (790 / 1080) * SafeZoneH);
        _displayData pushBack [_slideCtrl, [_x, _y]];
        _displayData pushBack [_previewLblCtrl, [_x, _y]];
        _displayData pushBack [_previewBgLblCtrl, [_x, _y]];
    };
};

TRACE_1("", _displayData);
{
    _x params ["_ctrl", "_pos"];

    _ctrl ctrlSetPosition _pos;
    _ctrl ctrlCommit _commitSpeed;
} forEach _displayData;
