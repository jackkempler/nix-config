{pkgs, ...}: {
  
  # --- NIX ---
  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "26.11";
  
  imports = [./hardware-configuration.nix];
  environment.systemPackages = with pkgs; [
    btop
    tree
    alejandra
    neovim
    nerd-fonts.symbols-only
  ];

  # --- NH ---
  programs.nh = {
    enable = true;
  };

  # --- BOOT ---
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # --- BLUETOOTH ---
  hardware.bluetooth = {
    enable = true;
  };

  # --- WAYLAND ---
  programs.sway = {
    enable = true;
    package = null;
  };

  # --- NETWORK ---
  networking = {
    hostName = "nixos";
    wireless.iwd.enable = true;
  };

  # --- TIME ---
  services.automatic-timezoned.enable = true;

  # --- USER ---
  users.users.jack = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  # --- AUDIO ---
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;
  };

  # --- FONTS ---
  fonts = {
    packages = with pkgs.nerd-fonts; [dejavu-sans-mono symbols-only];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["DejaVu Sans Mono" "Symbols Nerd Font"];
      };
    };
  };

  services.sshd.enable = true;

  # --- SYSTEMD ---
  systemd.user.services.speech-dispatcher.enable = false;
  systemd.user.sockets.speech-dispatcher.enable = false;
}
