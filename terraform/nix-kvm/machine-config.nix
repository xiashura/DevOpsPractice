
{ pkgs, lib, ... }:

with lib;

{
  imports = [
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
  ];

  config = {
    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    boot.growPartition = true;
    boot.kernelParams = [ "console=ttyS0" ];
    boot.loader.grub.device = "/dev/vda";

    networking.hostName = "dev";
    time.timeZone = "Asia/Yekaterinburg";




    users.extraUsers.root.password = "";
    services.openssh.enable = true;
    services.openssh.permitRootLogin = "yes";
    virtualisation.docker.enable = true;
    nixpkgs.config.allowUnfree = true;

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    users.users.dev = {
      isNormalUser  = true;
      home  = "/home/dev";
      description  = "dev";
      extraGroups  = [ "wheel" "networkmanager" "docker" ];
      openssh.authorizedKeys.keys  = [ "ssh-rsa ..." ];
    };



   environment.systemPackages = with pkgs; [
	htop
	wget
	ranger
	openssh
	sshfs
	docker
	docker-compose
	git
	bash
	vim 
	github-runner
   ];

    system.autoUpgrade.enable = false;
  };
}
