{ pkgs, driveMountPath, ... }: {
  home-manager.users.andrew.programs.rclone.enable = true;
  home-manager.users.andrew.systemd.user.services.rclone-gdrive = {
    Unit = {
      Description = "Sync GG drive via rclone";
      After = [ "default.target" ];
    };
    Install = { WantedBy = [ "default.target" ]; };
    Service = {
      Type = "simple";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${driveMountPath}";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount gdrive: ${driveMountPath} \
        --vfs-cache-max-age 24h \
        --dir-cache-time 1h \
        --vfs-cache-mode full \
        --config %h/.config/rclone/rclone.conf
      '';
      ExecStop = "${pkgs.fuse}/bin/fusermount -u ${driveMountPath}";
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };
}
