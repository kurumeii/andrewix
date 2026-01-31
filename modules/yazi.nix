{pkgs, ...}:
let plug = pkgs.yaziPlugins;
in
{
	programs.yazi = {
		enable = true;
		plugins = {
			"full-border.yazi" = plug.full-border;
			"smart-enter.yazi" = plug.smart-enter;
			"lazygit.yazi" = plug.lazygit;
		};
	};
}
