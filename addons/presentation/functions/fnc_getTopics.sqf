#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Parse presentation topics from mission and game config (mod)
 *
 *  Parameter(s):
 *      0: Config - Topics. Config entry with various presentation classes
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [configfile >> mts_presentation_topics] call mts_presentation_getTopics;
 *
 */

params ["_topics"];

private ["_topic", "_displayName", "_path", "_name", "_pages", "_extension"];

for "_i" from 0 to (count _topics - 1) do {
     _topic = configName (_topics select _i);
     _displayName = getText (_topics >> _topic >> "displayName");
     _path = getText (_topics >>  _topic >> "path");
     _name = getText (_topics >>  _topic >> "name");
     _pages = getNumber (_topics >>  _topic >> "pages");
     _extension = toLower (getText (_topics >>  _topic >> "extension"));

     GVAR(topics) pushBack [_displayName, _path, _name, _pages, _extension];
};
