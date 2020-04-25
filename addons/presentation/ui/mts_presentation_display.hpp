class RscTitles {
	class GVAR(curSlideDisplay) {
		idd = IDD_CURRENT_SLIDE_DISPLAY;
        OnLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(curSlideDisplay), _this select 0)]);
		duration = 1e+011;

		class controls {
			class background: IGUIBack {
				idc = IDC_DISPLAY_BACKGROUND;
			};
			class slide: RscPicture {
				idc = IDC_DISPLAY_PICTURE;
			};
		};
	};
    class GVAR(previewNextSlideDisp) {
		idd = IDD_PREVIEW_NEXT_SLIDE_DISPLAY;
        OnLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(previewNextSlideDisp), _this select 0)]);
		duration = 1e+011;

		class controls {
			class background: IGUIBack {
				idc = IDC_DISPLAY_BACKGROUND;
                w = "(532 / 1920) * SafeZoneW";
                h = "(276 / 1080) * SafeZoneH";
			};
			class slide: RscPicture {
				idc = IDC_DISPLAY_PICTURE;
                w = "(512 / 1920) * SafeZoneW";
                h = "(256 / 1080) * SafeZoneH";
			};
			class preview_label_background: IGUIBack {
				idc = IDC_DISPLAY_PREVIEW_BACKGROUND_LABEL;
				w = "(512 / 1920) * SafeZoneW";
				h = "(40 / 1080) * SafeZoneH";
			};
			class preview_label: RscText {
				idc = IDC_DISPLAY_PREVIEW_LABEL;
				text = CSTRING(display_preview);
				w = "(512 / 1920) * SafeZoneW";
				h = "(40 / 1080) * SafeZoneH";
			};
		};
	};
};
