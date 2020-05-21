#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Add every page of the topic to the combo box.
 *
 *  Parameter(s):
 *      0: CONTROL - Listbox control
 *      1: NUMBER - Index of selected entry
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [Control #4, 0] call mts_presentation_fnc_fillPagesCombo
 *
 */

params ["_listboxCtrl", "_index"];

private _topic = _listboxCtrl lbValue _index;
private _pages = (GVAR(topics) select _topic) select 2;
private _comboCtrl = (ctrlParent _listboxCtrl) displayCtrl IDC_COMBOBOX;

lbClear _comboCtrl;

for "_i" from 1 to _pages do {
    _comboCtrl lbAdd (str _i);
};

_comboCtrl lbSetCurSel 0;
