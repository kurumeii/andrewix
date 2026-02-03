{ username, stateVersion, ... }: {
  # imports = [ ./bundle.nix ];
  home = {
    # Do not override var here
    inherit username stateVersion;
    homeDirectory = "/home/${username}";
  };

}
