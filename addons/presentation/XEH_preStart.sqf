#include "script_component.hpp"
// Print version to rpt log
private _version = getText (configFile >> "CfgPatches" >> "mts_presentation" >> "versionStr");
INFO_1("Metis Presentation version: %1.",_version);
#include "XEH_PREP.hpp"
