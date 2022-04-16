#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Disables the continue button, if a video presentation is selected.
 *
 *  Parameter(s):
 *      0: CONTROL - Listbox control
 *      1: NUMBER - Index of selected entry
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [Control #4, 0] call mts_presentation_fnc_toggleContinueButton
 *
 */

params ["_listboxCtrl", "_index"];

private _topic = _listboxCtrl lbValue _index;
private _extension = (GVAR(topics) select _topic) select 4;

private _btnContinueCtrl = (ctrlParent _listboxCtrl) displayCtrl IDC_BUTTON_CONTINUE;

if (_extension isEqualTo ".ogv") then {
    _btnContinueCtrl ctrlEnable false;
    _btnContinueCtrl ctrlSetTooltip "Only for images.";
} else {
    _btnContinueCtrl ctrlEnable true;
    _btnContinueCtrl ctrlSetTooltip "";
};
