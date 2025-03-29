# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "ShanheLUG"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;

  

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shanheix = {
    description = "Shanhe";
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      chromium
      python312Packages.huggingface-hub
      ollama
      gpt4all
      lmstudio
      vscode
      jetbrains.pycharm-community
      jetbrains-toolbox
      pipx
      oterm
      python312Packages.notebook
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    gh
    fastfetch
    flatpak
    fcitx5
  ];

  fonts.packages = with pkgs; [
    source-han-sans
    source-han-mono
    source-han-serif
    jetbrains-mono
    texlivePackages.opensans
    inter-nerdfont
    noto-fonts
    roboto
    roboto-mono
  ];

  nix.extraOptions = ''
  extra-experimental-features = nix-command flakes
  '';
  nixpkgs.config.allowUnfree = true;
  # Yes, you! Don't edit the content below. Thanks :)
  environment.etc."issue".text = ''
  <<< Welcome to ShanheixOS Labs 0.98 "Priest"! >>>
  Shanhe University Linux Distribution for Developers
  Producted by Shanhe Linux Linux Users Group
  ShanheixOS Labs, an NixOS-based Linux distribution for AI Professional only
    
  (C) 2025 Shanhe University
  Licensed under GPL-3.0 LICENSE

  Visit Shanhe University at https://shanhe.co for more infomation you interested about us!

  "Yes, my liege :)." --Von Lycaon
  ENJOY YOUR SYSTEM!
'';
 
  environment.etc."os-release".text = ''
  ANSI_COLOR="1;34"
  BUG_REPORT_URL="https://github.com/NixOS/nixpkgs/issues"
  BUILD_ID="0.98"
  DOCUMENTATION_URL="https://nixos.org/learn.html"
  HOME_URL="https://shanhe.co/"
  ID=shanheix
  IMAGE_ID=""
  IMAGE_VERSION=""
  LOGO="nix-snowflake"
  NAME=ShanheixOS
  PRETTY_NAME="ShanheixOS Labs 0.98 (Priest)"
  SUPPORT_URL="https://nixos.org/community.html"
  VARIANT_ID=labs
  VERSION="0.98 (Priest)"
  VERSION_CODENAME=priest
  VERSION_ID="0.98"
'';

  nix.settings.substituters = lib.mkForce [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

