{pkgs, ...}@inputs: 
{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting
			fastfetch -c examples/13.jsonc
			fnm env --use-on-cd --version-file-strategy=recursive --shell fish | source
			'';
		shellAliases = {
			rebuild = "nh os switch ~/dotconfigs";
			cleanup = "nh clean all";
			update = "sudo nix flake update --flake ~/dotconfigs";
			ll = "eza --long --icons";
			ls = "eza --all";
			cd = "z";
			cat = "bat";
			grep = "rg";
			man = "tldr";
		};
		plugins = [
		{name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src;}
		{name = "done"; src = pkgs.fishPlugins.done.src;}
		{name = "git"; src = pkgs.fishPlugins.plugin-git.src;}
		];
	};
	programs.oh-my-posh = {
		enable = true;
		configFile = "${inputs.self}/andrew.omp.json";
	};
}
