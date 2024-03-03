#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Set next and preview slide, according to input.
 *
 *  Parameter(s):
 *      0: NUMBER - Specifies which direction the slide should be going. -1 previous slide. 0 set starting slide of presentation (e.g. slide0.png). 1 next slide. (default: 1)
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      1 call mts_presentation_fnc_changeSlide
 *
 */
params [["_direction", NEXT_SLIDE, [0]]];
TRACE_1("",_direction);

(GVAR(topics) select GVAR(topic)) params ["", "_path", "_name", "_numberOfSlides", "_extension"];

TRACE_1("Before processing",_slideNumber);
private _getSlideNumber = {
    params ["_direction", "_slideNumber"];
    TRACE_2("getSlideNumber",_direction,_slideNumber);
    switch (_direction) do {
        case (NEXT_SLIDE): {
            LOG("nextSlide");
            if (_slideNumber isEqualTo _numberOfSlides) then {
                _slideNumber = 1;
            } else {
                _slideNumber = _slideNumber + 1;
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
            if (_slideNumber isEqualTo 1) then {
                _slideNumber = _numberOfSlides;
            } else {
                _slideNumber = _slideNumber - 1;
            };
        };
    };
    _slideNumber
};

private _currentSlideNumber = [_direction, GVAR(currentSlideNumber)] call _getSlideNumber;
private _previewSlideNumber = [1, _currentSlideNumber] call _getSlideNumber;
TRACE_2("After processing",_currentSlideNumber,_previewSlideNumber);

missionNamespace setVariable [QGVAR(currentSlideNumber), _currentSlideNumber, true];

private _slide = [_path, _name, _currentSlideNumber, _extension] joinString "";
private _previewSlide = [_path, _name, _previewSlideNumber, _extension] joinString "";

[_slide, _previewSlide] call FUNC(setSlide);
