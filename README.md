<p align="center">
    <img src="https://i.imgur.com/u9MnYWR.png" width="1024">
</p>
 
<p align="center">
    <a href="https://github.com/Metis-Team/mts_presentation/releases/latest">
        <img src="https://img.shields.io/badge/Version-1.0.2-blue.svg?style=flat-square" alt="Metis Presentation Version">
    </a>
    <a href="https://github.com/Metis-Team/mts_presentation/releases/latest">
        <img src="https://img.shields.io/github/downloads/Metis-Team/mts_presentation/total.svg?style=flat-square&label=Downloads" alt="Metis Presentation Downloads">
    </a>
    <a href="https://steamcommunity.com/sharedfiles/filedetails/?id=2795312040">
        <img src="https://img.shields.io/badge/Steam-Workshop-green.svg?style=flat-square" alt="Steam Workshop">
    </a>
    <a href="https://github.com/Metis-Team/mts_presentation/blob/master/LICENSE">
        <img src="https://img.shields.io/badge/License-APL--SA-red.svg?style=flat-square" alt="APL-SA License">
    </a>
</p>
 
<p align="center">
    <sup><strong>Requires the latest version of <a href="https://github.com/CBATeam/CBA_A3/releases/latest">CBA A3</a>.</sup></strong>
</p>

**Metis Presentation** brings you the ability to present videos and images in front of an ingame audience.  
With this you will be able to conduct mission briefings or training lectures.

## Features
 
- Support for multiple presentations (selectable in a list)
- Slides can be images (jpg, paa) and videos (ogv)
- Support for multiple screens
- ACE3 & Vanilla access menu
- Hotkeys for presentation control (CBA Keybinds)
- Toggle size of presenter view for current slide (big/small/off)
- Toggle visibility of preview of next slide (on/off)
- Start presentation on any slide
- Continue presentation on current slide (possible to switch presenters in the middle of the presentation)
 
## FAQ
- Q: Does the mod have to be run on the server?  
  A: No.
- Q: Can I mix videos and images in one presentation?  
  A: No.
- Q: Can I do multiple presentation at the same time?  
  A: No.
 
## Setup
 
### Editor
 
First you need to setup the objects you want to use in our presentation. You need one or more screens and a presentation control. 
Follow these steps:
- Place screen and control object
- Assign each object a variable name (double click on the object and give it an unique variable name)
- Configure Metis Presentation to use chosen objects:
  - Go to `Settings -> Addons Options -> Mission -> Metis Presentation`
  - Under `Mission` settings enter the corresponding screen and control variable names (separated by comma)
 
### Slides
 
Slides can be images or videos. Following extensions are supported:
- .jpg
- .paa
- .ogv
 
Metis Presentation requires you to name the slide files in a specific format.  
- Every slide in a presentation must have the same name
- Every slide in a presentation must have the same extension
- Slides must be numerically ascending
 
Format:
```
[name][number].[extension]
```
 
Examples:
```
my_presentation1.jpg
my_presentation2.jpg
my_presentation3.jpg
 
my_second_presentation1.paa
my_second_presentation2.paa
 
funny_videos1.ogv
```
 
Now that you have named your slide files accordingly, they need to be added either in the description.ext of the mission or with an addon.
 
#### Add slides to presentation with `description.ext`
 
Lets assume following mission folder structure:
 
```
my_mission.Stratis
│   description.ext
│   mission.sqm
│
├───my_presentation_slides
│       my_presentation1.jpg
│       my_presentation2.jpg
│       my_presentation3.jpg
│
└───videos
    └───cats
            funny_videos1.ogv
```
 
You want to configure two presentations. One with three image slides and one with a video.  
The configuration in the `description.ext` would look something like:
 
```cpp
// description.ext
class mts_presentation_topics {
    // The class name is not relevant but should be unique for every presentation in a mission
    class My_Presentation {
        displayName = "10 Reasons why bananas are good"; // Name displayed in the presentation control in game
        path = "my_presentation_slides"; // Relative path from mission root folder
        name = "my_presentation"; // Same name as for the slide files except the number (my_presentation1.jpg, ...)
        extension = ".jpg"; // Extension of the slide files
        slides = 2; // Number of slides in the presentation (my_presentation1.jpg, ...)
    };
 
    class Funny_Cat_Videos {
        displayName = "Funny cat videos"; // Name displayed in the presentation control in game
        path = "videos\cats"; // Relative path from mission root folder
        name = "funny_videos"; // Same name as for the slide files except the number (funny_videos1.ogv)
        extension = ".ogv"; // Extension of the slide file
        slides = 1; // Number of videos (funny_videos1.ogv)
    };
};
```
 
#### Add slides to presentation with an addon (`config.cpp`)
 
Lets say that you don't want that the mission size to be too large, so you pack all slide files in an addon.
We assume the same file structure as in the mission folder except that `mission.sqm` and `description.ext` do not exist. The addon prefix is e.g. `my_slide_mod`.
 
```cpp
// config.cpp
class mts_presentation_topics {
    // The class name is not relevant but should be unique for every presentation in a mission
    class My_Presentation {
        displayName = "10 Reasons why bananas are good"; // Name displayed in the presentation control in game
        path = "my_slide_mod\my_presentation_slides"; // Path to mod and folder
        name = "my_presentation"; // Same name as for the slide files except the number (my_presentation1.jpg, ...)
        extension = ".jpg"; // Extension of the slide files
        slides = 2; // Number of slides in the presentation (my_presentation1.jpg, ...)
    };
 
    class Funny_Cat_Videos {
        displayName = "Funny cat videos"; // Name displayed in the presentation control in game
        path = "my_slide_mod\videos\cats"; // Path to mod and folder
        name = "funny_videos"; // Same name as for the slide files except the number (funny_videos1.ogv)
        extension = ".ogv"; // Extension of the slide file
        slides = 1; // Number of videos (funny_videos1.ogv)
    };
};
```
 
## User manual
 
- Open the presentation with the vanilla or ACE3 action
- Select a presentation and continue or select a specific slide and start. (Continue defaults to slide 1 if nothing was presented before)
- Stop presentation with the scroll or ACE3 self interaction menu
 
### Settings
 
User settings can be found in CBA Settings `Options -> Addons Options -> Client -> Addon: Metis Presentation`
 
### Keybinding 
 
Keybinds can be found and changed in CBA Keybinding `Options -> Controls -> Configure Addons (at the bottom right) -> Addon: Metis Presentation`
 
## Behavior
 
- Only one player can present at the same time. The presenter can stop and someone else can continue or start a new presentation
- If someone is presenting and you try to open the presentation menu, it will give you a hint that it is in use and by whom
- If the presenter is not alive or disconnected, someone else can take over by simply open the presentation menu
 
## Contributing
- [Issues & Feature requests](https://github.com/Metis-Team/mts_presentation/issues)
- [Become a developer](https://github.com/Metis-Team/mts_presentation/wiki/For-developers)
 
## License
Metis Presentation is licensed under Arma Public License Share Alike ([APL-SA](https://github.com/Metis-Team/mts_presentation/blob/master/LICENSE)).
 
## Images
<p align="center">
    <img src="https://i.imgur.com/PsbpNAc.jpg" width="1024">
</p>
<p align="center">
    <img src="https://i.imgur.com/b62WbPK.jpg" width="1024">
</p>
<p align="center">
    <img src="https://i.imgur.com/0PbeOg4.jpg" width="1024">
</p>
<p align="center">
    <img src="https://i.imgur.com/JWdbj3i.jpg" width="1024">
</p>
<p align="center">
    <img src="https://i.imgur.com/VraeKVM.jpg" width="1024">
</p>
