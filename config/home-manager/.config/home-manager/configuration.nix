# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    configurationLimit = 5;
  };
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.nameservers = ["1.1.1.1" "1.0.0.1"];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services = {
		xserver = {
			enable = true;
			displayManager = {
				lightdm.enable = true;
				defaultSession = "none+qtile";
			};
			windowManager.qtile = {
				enable = true;
				configFile = "/home/cognusboi/.config/qtile/config.py";
				extraPackages = python3Packages: with python3Packages; [
					  qtile-extras
				];
			};
		};
	};

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
		xkbOptions = "caps:escape";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;
	services.pipewire = {
		systemWide = true;
		enable = true;
		wireplumber.enable = true;
		pulse.enable = true;
	};

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cognusboi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "video" "audio" "networkmanager" "network" "storage" "pipewire" "realtime" "libvirt"]; # Enable ‘sudo’ for the user.
		initialPassword = "password";
    packages = with pkgs; [
      tree
    ];
		shell = pkgs.fish;
  };
	nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
		neovim
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
		emacs
		brave
		git
		kitty
		discord
		rofi
		dunst
		zathura
		lazygit
		gnat13
		python3
		nodejs_20
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableuSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

	nixpkgs.overlays = [
		(self: super: {
			discord = super.discord.overrideAttrs (
				_: { src = builtins.fetchTarball {
					url = "https://discord.com/api/download?platform=linux&format=tar.gz";
				};
			});
		})
	];
	programs.fish.enable = true;

	environment.variables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
	};

	nix = {
		package = pkgs.nixFlakes;
		extraOptions = "experimental-features = nix-command flakes";
	};
}

