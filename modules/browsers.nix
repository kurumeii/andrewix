{pkgs, ... }:
let 
	keepass = pkgs.keepassxc;
in
{
	programs.firefox = {
		enable = true;
		nativeMessagingHosts = [ keepass ];
	};
	programs.brave = {
		nativeMessagingHosts = [ keepass ];
	};
}
