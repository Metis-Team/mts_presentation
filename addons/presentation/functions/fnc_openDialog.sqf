#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Opens the presentation selection dialog and add available topics.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_presentation_fnc_openDialog
 *
 */
private _status = createDialog QGVAR(dialog);
CHECKRET(!_status,ERROR("Failed to create dialog"));

private _mainDisplay = findDisplay IDD_MAIN_DISPLAY;
private _listboxCtrl = _mainDisplay displayCtrl IDC_LISTBOX;
private "_index";
{
    _index = _listboxCtrl lbAdd (_x select 0);
    _listboxCtrl lbSetValue [_index, _forEachIndex];
} forEach GVAR(topics);

if (GVAR(sortAlphabetically)) then {
    lbSort _listboxCtrl;
};
_listboxCtrl lbSetCurSel 0;
