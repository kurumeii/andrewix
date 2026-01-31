{...}:
{
	services = {
		displayManager.gdm.enable = true;
		desktopManager.gnome.enable = true;
		xserver = {
			enable = true;
			autoRepeatDelay = 200;
			autoRepeatInterval = 35;
			xkb = {
				layout = "us";
				variant = "";
			};
		};
		printing.enable = false;
		pulseaudio.enable = false;
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
		};
		power-profiles-daemon.enable = false;
		tlp = {
			enable = true;
			settings = {
				USB_AUTOSUSPEND = 0;
				STOP_CHARGE_THRESH_BAT0 = 85;
				CPU_SCALING_GOVERNOR_ON_AC = "performance";
				CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
				CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
				CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
			};
		};
	};
}
