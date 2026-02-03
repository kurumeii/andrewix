{ fontFamily, ... }: {
  home-manager.users.andrew.gtk = {
    enable = true;
    font = {
      name = "${fontFamily}";
      size = 12;
    };
  };
}
