class RscPicture;
class RscCombo;
class RscShortcutButton;
class RscText;
class RscListBox;
class IGUIBack;

class GVAR(dialog) {
    idd = IDD_MAIN_DISPLAY;
    movingEnable = 0;
    OnLoad = QUOTE(((_this select 0) displayctrl IDC_LISTBOX) ctrlAddEventHandler [ARR_2('LBSelChanged',{_this call FUNC(fillSlidesCombo); _this call FUNC(toggleContinueButton)})];);

    class Button: RscShortcutButton {
        type = 16;
        class HitZone;
        class ShortcutPos;
        class TextPos {
            left = 0;
            top = 0.0125;
            right = 0;
            bottom = 0;
        };
        class Attributes
        {
            font = "RobotoCondensed";
            color = "#E5E5E5";
            align = "center";
            shadow = "true";
        };
        class AttributesImage;

        colorBackground[] = {1, 1, 1, 1};
        colorBackgroundFocused[] = {1, 1, 1, 1};

        animTextureDefault = QPATHTOF(data\Button_np.paa);
        animTextureNormal = QPATHTOF(data\Button_np.paa);
        animTextureDisabled = QPATHTOF(data\Button_p.paa);
        animTextureOver = QPATHTOF(data\Button_h.paa);
        animTextureFocused = QPATHTOF(data\Button_h.paa);
        animTexturePressed = QPATHTOF(data\Button_p.paa);
    };

    class Listbox: RscListBox {
        class ComboScrollBar;

        colorBackground[] = {0.231,0.231,0.231,1};
        colorPictureRight[] = {0, 0, 0, 1};
        colorTextRight[] = {0, 0, 0, 1};
        arrowEmpty = "\A3\ui_f\data\GUI\Cfg\Scrollbar\arrowEmpty_ca.paa";
        arrowFull = "\A3\ui_f\data\GUI\Cfg\Scrollbar\arrowFull_ca.paa";
        thumb = "\A3\ui_f\data\GUI\Cfg\Scrollbar\thumb_ca.paa";
        border = "\A3\ui_f\data\GUI\Cfg\Scrollbar\border_ca.paa";
        color[] = {1,1,1,0.6};
    };

    class ControlsBackground {
        class logo: RscPicture {
            idc = -1;
            x = "SafeZoneX + (704 / 1920) * SafeZoneW";
            y = "SafeZoneY + (400 / 1080) * SafeZoneH";
            w = "(64 / 1920) * SafeZoneW";
            h = "(64 / 1080) * SafeZoneH";
            text = QPATHTOF(data\Logo.paa);
        };
        class background_nav: RscPicture {
            idc = -1;
            x = "SafeZoneX + (768 / 1920) * SafeZoneW";
            y = "SafeZoneY + (400 / 1080) * SafeZoneH";
            w = "(448 / 1920) * SafeZoneW";
            h = "(64 / 1080) * SafeZoneH";
            text = QPATHTOF(data\Background_nav.paa);
        };
        class background_selection: RscPicture    {
            idc = -1;
            x = "SafeZoneX + (704 / 1920) * SafeZoneW";
            y = "SafeZoneY + (464 / 1080) * SafeZoneH";
            w = "(512 / 1920) * SafeZoneW";
            h = "(216 / 1080) * SafeZoneH";
            text = QPATHTOF(data\Background_selection.paa);
        };
    };
    class controls {
        class combo_slides: RscCombo {
            idc = IDC_COMBOBOX;
            style = "16";
            x = "SafeZoneX + (1034 / 1920) * SafeZoneW";
            y = "SafeZoneY + (528 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(33 / 1080) * SafeZoneH";


            class ComboScrollBar: RscCombo {};
        };
        class button_start: Button {
            idc = IDC_BUTTON_START;
            text = CSTRING(dialog_btn_start);
            x = "SafeZoneX + (1034 / 1920) * SafeZoneW";
            y = "SafeZoneY + (629 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(40 / 1080) * SafeZoneH";
            onButtonClick = QUOTE(false call FUNC(startPresentation));
        };
        class button_continue: Button {
            idc = IDC_BUTTON_CONTINUE;
            text = CSTRING(dialog_btn_continue);
            x = "SafeZoneX + (1034 / 1920) * SafeZoneW";
            y = "SafeZoneY + (575 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(40 / 1080) * SafeZoneH";
            onButtonClick = QUOTE(true call FUNC(startPresentation));
        };
        // class button_help: Button {
        //     idc = -1;
        //     text = "Hilfe";
        //     x = "SafeZoneX + (1034 / 1920) * SafeZoneW";
        //     y = "SafeZoneY + (474 / 1080) * SafeZoneH";
        //     w = "(150 / 1920) * SafeZoneW";
        //     h = "(40 / 1080) * SafeZoneH";
        //   action = QUOTE(call FUNC(help););
        // };
        class title: RscText {
            idc = -1;
            style = 2;
            x = "SafeZoneX + (768 / 1920) * SafeZoneW";
            y = "SafeZoneY + (400 / 1080) * SafeZoneH";
            w = "(384 / 1920) * SafeZoneW";
            h = "(57 / 1080) * SafeZoneH";
            text = "Presentation Selection";
        };
        class listbox_backgorund: RscPicture {
            idc = -1;
            x = "SafeZoneX + (736 / 1920) * SafeZoneW";
            y = "SafeZoneY + (473 / 1080) * SafeZoneH";
            w = "(266 / 1920) * SafeZoneW";
            h = "(196 / 1080) * SafeZoneH";
            text = QPATHTOF(data\lb_bg.paa);
        };
        class listbox: Listbox {
            idc = IDC_LISTBOX;
            style = "16";
            x = "SafeZoneX + (736 / 1920) * SafeZoneW";
            y = "SafeZoneY + (475 / 1080) * SafeZoneH";
            w = "(264 / 1920) * SafeZoneW";
            h = "(192 / 1080) * SafeZoneH";
        };
    };
};
