[
    LLSTRING(mod_name),
    QGVAR(nextSlide),
    LLSTRING(cba_keybinding_next_slide),
    {
        LOG("Next slide keybind");
        if (GVAR(presenter) isEqualTo CURRENT_PLAYER) then {
            NEXT_SLIDE call FUNC(changeSlide);
            true
        };
    },
    "",
    [0x4D, [false, false, false]] //Numpad 4
] call CBA_fnc_addKeybind;

[
    LLSTRING(mod_name),
    QGVAR(previousSlide),
    LLSTRING(cba_keybinding_previous_slide),
    {
        LOG("Previous slide keybind");
        if (GVAR(presenter) isEqualTo CURRENT_PLAYER) then {
            PREVIOUS_SLIDE call FUNC(changeSlide);
            true
        }
    },
    "",
    [0x4B, [false, false, false]] //Numpad 6
] call CBA_fnc_addKeybind;

[
    LLSTRING(mod_name),
    QGVAR(bigDisplay),
    LLSTRING(cba_keybinding_big_display),
    {
        LOG("Big display keybind");
        if (GVAR(presenter) isEqualTo CURRENT_PLAYER) then {
            "big" call FUNC(setDisplay);
            true
        }
    },
    "",
    [0x48, [false, false, false]] //Numpad 8
] call CBA_fnc_addKeybind;

[
    LLSTRING(mod_name),
    QGVAR(smallDisplay),
    LLSTRING(cba_keybinding_small_display),
    {
        LOG("Small display keybind");
        if (GVAR(presenter) isEqualTo CURRENT_PLAYER) then {
            "small" call FUNC(setDisplay);
            true
        }
    },
    "",
    [0x50, [false, false, false]] //Numpad 2
] call CBA_fnc_addKeybind;

[
    LLSTRING(mod_name),
    QGVAR(startStopVideo),
    LLSTRING(cba_keybinding_start_stop_video),
    {
        LOG("Start/Stop Video keybind");
        if (GVAR(presenter) isEqualTo CURRENT_PLAYER) then {
            if (GVAR(videoRunning)) then {
                QGVAR(stopVideo) call CBA_fnc_globalEvent;
            } else {
                SET_SLIDE call FUNC(changeSlide);
            };
            true
        }
    },
    "",
    [0x52, [false, false, false]] //Numpad 0
] call CBA_fnc_addKeybind;

[
    LLSTRING(mod_name),
    QGVAR(openPresentationMenu),
    LLSTRING(actions_presentation_menu),
    {
        LOG("Open presentation menu");
        if (GVAR(presenter) isEqualTo CURRENT_PLAYER) then {
            [] call FUNC(openDialog);
            true
        }
    },
    "",
    [0x4C, [false, false, false]] //Numpad 5
] call CBA_fnc_addKeybind;

/*
↑   Switch to big screen
↓   Switch to small screen
←   previos slide
→   next slide
9   preview on/off
7   current slide on/off
5   choose new topic or slideNumber
1   start/stop timer (planned)
3   reset timer (planned)
L   laserpointer on/off  (planned)
0   start/stop video
*/
