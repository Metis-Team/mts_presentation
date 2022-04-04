<h1 align="center">Metis Presentation</h1>

<p align="center">
    <a href="https://github.com/Metis-Team/mts_presentation/releases/latest">
        <img src="https://img.shields.io/badge/Version-0.9.0-blue.svg?style=flat-square" alt="Metis Presentation Version">
    </a>
    <a href="https://github.com/Metis-Team/mts_presentation/releases/latest">
        <img src="https://img.shields.io/github/downloads/Metis-Team/mts_presentation/total.svg?style=flat-square&label=Downloads" alt="Metis Presentation Downloads">
    </a>
    <a href="https://steamcommunity.com/sharedfiles/filedetails/?id=">
        <img src="https://img.shields.io/badge/Steam-Workshop-green.svg?style=flat-square" alt="Steam Workshop">
    </a>
    <a href="https://github.com/Metis-Team/mts_presentation/blob/master/LICENSE">
        <img src="https://img.shields.io/badge/License-APL--ND-red.svg?style=flat-square" alt="APL-ND License">
    </a>
</p>

<p align="center">
    <sup><strong>Requires the latest version of <a href="https://github.com/CBATeam/CBA_A3/releases/latest">CBA A3</a>.</sup></strong>
</p>

## Features
- Supports more then one presentation (selectable in a list)
- Supports images (jpg, paa) and videos (ogv)
- Supports multiple screens
- ACE3 & Vanilla access menu
- Change slides via hotkeys (Customizable CBA Keybinds)
- Toggleable view of current slide (big/small/off)
- Togglebale preview of next slide (on/off)
- Start presentation on any slide
- Continue presentation where someone left it (switch presenter mid presentation)

## Setup
### Editor
* Give every object that should be a screen or have the presentation control a name (double click on the object an give it a unique variable name)
* Got to Settings -> Addons Options -> select the Mission tab -> Metis Presentation
 * Under Mission Settings enter the corresponding screen and control variable name (comma seperated)
 * Please configure the user settings in the user tab according to your needs
 
### Images and videos
* Supported extension jpg, paa, ogv  
* Naming scheme:  
    The filenames must be numerically ascending and must have the same name for every presentation  
    ```  
    [some text][number].[extension]
    
    test_image1.jpg  
    test_image2.jpg  
    test_image3.jpg  
    
    my_second_presentation1.paa  
    my_second_presentation2.paa  
    my_second_presentation3.paa
    ```

#### Via mission (description.ext)
```sqf
class mts_presentation_topics {
    //Images in root mission folder
    //The class name is not relevant but should'nt be the same for every presentation
    class Test_Images {
        displayName = "Test Images Description"; //Display name
        path = "test_image"; //Path in mission folder and with the filename up to the number
        pages = 3; //Number of Images (test_image1, test_image2, test_image3)
        extension = ".jpg"; //Extension of the image/video
    };
    //Video in mission subfolder
    class Test_videos {
        displayName = "Test Videos Description"; //Display name
        path = "videos\test_video"; //Path in mission folder and with the filename up to the number
        pages = 1; //Number of videos
        extension = ".ogv"; //Extension of the image/video
    };
}; 
```
#### Via mod
```sqf
//The class name is not relevant but should'nt be the same for every presentation
class mts_presentation_topics {
    class Test_Images {
        displayName = "Test Images"; //Display name
        path = "\z\mts_slides\addons\slides\test_images\slide"; //Full mod path and with the filename up to the number
        pages = 3; //Number of Images (test_image1, test_image2, test_image3)
        extension = ".jpg"; //Extension of the image/video
    };
    class Test_Videos {
        displayName = "Test Videos"; //Display name
        path = "\z\mts_slides\addons\slides\test_videos\video"; //Full mod path and with the filename up to the number
        pages = 1; //Number of videos
        extension = ".ogv"; //Extension of the image/video
    };
};
```
## User manual
* Open the presentation via the vanilla or ACE3 action
* Select a presentation and continue or select a specific slide and start. (Continue defaults to 1 if nothing was presented before)
* Stop presentation via the scroll menu or ACE3 self interaction menu

##### Settings
User settigns can be found in CBA Settings under ESC -> Options -> Addons Options -> Client -> Addon: Metis Presentation

##### Keybinds
CBA Keybinds are in use an can be found under ESC -> Options -> Controls -> Configure Addons (at the bottom right) -> Addon: Metis Presentation  

## Behavior
* Only one can present at the same time. The presenter can stop and someone else can continue or start a new presentation
* If some one is presenting and you try to open the presentation menu, it will give you a hint that it is in use and by whom
* If the presenter is not alive or disconnected, someone else can take over by simply open the presentation menu

## Contributing
- [Issues & Feature requests](https://github.com/Metis-Team/mts_presentation/issues)
- [Become a developer](https://github.com/Metis-Team/mts_presentation/wiki/For-developers)

## License
Metis Marker is licensed under Arma Public License No Derivatives ([APL-ND](https://github.com/Metis-Team/mts_marker/blob/master/LICENSE)).

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
