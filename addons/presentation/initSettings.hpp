[
    QGVAR(displayCurrentSlide),
    "CHECKBOX",
    [LLSTRING(cba_settings_show_current_slide), LLSTRING(cba_settings_show_current_slide_tooltip)],
    [LLSTRING(mod_name), LLSTRING(cba_category_name_user_settings)],
    true,
    0,
    {}
] call CBA_settings_fnc_init;

[
    QGVAR(dispSlideSize),
    "LIST",
    [LLSTRING(cba_settings_show_current_slide_size), LLSTRING(cba_settings_show_current_slide_size_tooltip)],
    [LLSTRING(mod_name), LLSTRING(cba_category_name_user_settings)],
    [["small","big"], [LLSTRING(cba_settings_current_slide_size_small), LLSTRING(cba_settings_current_slide_size_big)], 0],
    0,
    {}
] call CBA_settings_fnc_init;

[
    QGVAR(previewNextSlide),
    "CHECKBOX",
    [LLSTRING(cba_settings_preview_next_slide), LLSTRING(cba_settings_preview_next_slide_tooltip)],
    [LLSTRING(mod_name), LLSTRING(cba_category_name_user_settings)],
    true,
    0,
    {}
] call CBA_settings_fnc_init;

[
    QGVAR(sortAlphabetically),
    "CHECKBOX",
    [LLSTRING(cba_settings_sort_alphabetically), LLSTRING(cba_settings_sort_alphabetically_tooltip)],
    [LLSTRING(mod_name), LLSTRING(cba_category_name_user_settings)],
    true,
    0,
    {}
] call CBA_settings_fnc_init;

[
    QGVAR(cba_settings_screens),
    "EDITBOX",
    [LLSTRING(cba_settings_screens), LLSTRING(cba_settings_screens_tooltip)],
    [LLSTRING(mod_name), LLSTRING(cba_category_name_mission_settings)],
    "",
    1,
    {}
] call CBA_settings_fnc_init;

[
    QGVAR(cba_settings_controls),
    "EDITBOX",
    [LLSTRING(cba_settings_controls), LLSTRING(cba_settings_controls_tooltip)],
    [LLSTRING(mod_name), LLSTRING(cba_category_name_mission_settings)],
    "",
    1,
    {}
] call CBA_settings_fnc_init;

[
    QGVAR(cba_settings_actions),
    "LIST",
    [LLSTRING(cba_settings_actions), LLSTRING(cba_settings_actions_tooltip)],
    [LLSTRING(mod_name), LLSTRING(cba_category_name_mission_settings)],
    [["ace_interaction","scroll_menu"],[LLSTRING(cba_settings_actions_ace_interaction), LLSTRING(cba_settings_actions_scroll_menu)],0],
    1,
    {}
] call CBA_settings_fnc_init;
