#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Changes according to input the slides.
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
params [["_direction", NEXT_SLIDE, [0]]];
TRACE_1("", _direction);

(GVAR(topics) select GVAR(topic)) params ["", "_path", "_pages", "_extension"];

TRACE_1("Before processing", _page);
private _getPage = {
    params ["_direction", "_page"];
    TRACE_2("getPage", _direction, _page);
    switch (_direction) do {
        case (NEXT_SLIDE): {
            LOG("nextSlide");
            if (_page isEqualTo _pages) then {
                _page = 1;
            } else {
                _page = _page + 1;
            };
        };
        case (SET_SLIDE): {
            GVAR(disablePreview) = false;
            if (_extension isEqualTo ".ogv") then {
                GVAR(disablePreview) = true;
            };
            [] call FUNC(setDisplay);
        };
        case (PREVIOUS_SLIDE): {
            if (_page isEqualTo 1) then {
                _page = _pages;
            } else {
                _page = _page - 1;
            };
        };
    };
    _page
};

private _currentpage = [_direction, GVAR(currentPage)] call _getPage;
private _previewPage = [1, _currentpage] call _getPage;
TRACE_2("After processing", _currentpage, _previewPage);

missionNamespace setVariable [QGVAR(currentPage), _currentpage, true];

private _slide = format ["%1%2%3", _path, _currentpage, _extension];
private _previewSlide = format ["%1%2%3", _path, _previewPage, _extension];

[_slide, _previewSlide] call FUNC(setSlide);