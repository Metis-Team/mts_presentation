#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Add every slide number of the topic to the combo box.
 *
 *  Parameter(s):
 *      0: CONTROL - Listbox control
 *      1: NUMBER - Index of selected entry
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [Control #4, 0] call mts_presentation_fnc_fillSlidesCombo
 *
 */

params ["_listboxCtrl", "_index"];

private _topic = _listboxCtrl lbValue _index;
private _numberOfSlides = (GVAR(topics) select _topic) select 3;
private _comboCtrl = (ctrlParent _listboxCtrl) displayCtrl IDC_COMBOBOX;

lbClear _comboCtrl;

for "_i" from 1 to _numberOfSlides do {
    _comboCtrl lbAdd (str _i);
};

_comboCtrl lbSetCurSel 0;
