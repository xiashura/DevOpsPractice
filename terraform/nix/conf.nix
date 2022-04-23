
{config, pkgs, ...}:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

	environment.systemPackages = with pkgs; [
    fish
    git
		vim
		openssh
  ];


  services.sshd.enable = true;

	users.extraUsers.root.password = "";
 	users.users.root = {
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
		"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKEcOfY3EOwQTyLSGZELMCh9IbQroPKl6GnyfHLxbLLoyiKhAN96yoIQNcuGsdbO8uj1Hfl+vUvl7/5JRPavpmOCOX1XfLBdcwhEsVKZQEsf0QXMF5Y/yUQLr25sNqGIH9xVzyHT/pnrRBt5ULF4MvOFtf3iZUvHgiB/bphYKwjxxOXolDRojPMC9gaNktxngltHz0OJyIs/3sWjscmRoTnkU/mZKJCLK9+DrPSRBEe6iE+zvS1tYjJ7w79kFdos0nFDdBSXe8RCEL3mNBn4RTpinPALQcFzvTd7NuIAKz7GiwO61c+7u0iRHgYGnM+odyuGabgzmbgv4zLGyav9RXzg7OiaNXKqxvmUBkpYfqjq9awrNfhtj6clNLJQU1LLLzF9J/B4X6xIw36FoMrDeK/3lJ78SaYtcUV9O16pnLJLrToJL2BflO9eclhY8eB6SGNeYUQAmggvuEk9+Qyb0h9kjmS57gFptpM6C0w0gmhlFwxjbQEyRSrAs9qslh6vc= xiashura@arch"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClAa1q27xKavfjBrWxpIegUHVaaUg9ud/8ugw4FL6z3dqHnyaeRk1S/G4tZ/pvxo+KPkNHwd1GGQ/YJKg5ssof1t0Ax+y3+d4oGHCsVqyLjnKGhUvLKuBW2yclH+IUTYfwuv8TchvC6zOiN+IynU9/3Vlk/RqxP7cULykggqtBk5FKhsIwz32hzvBoZD/Ne/xeXZxDc/JCjGNde1wiRKEpZ+C0xs4uqLlh54lOdqY5QlVqO+Ou2vxBhoNGG9D3SARxcTLkOPu1NYtUblcJANXsWYgsAsak3FTXreLzRct8rovWMjDx86xa3RVdbLmODVdLOb2++k+qWefnAoNFin+eYCjMuviwF/3FG31KcYhe0wgKDtxi6Nm8qfoGQax9FsKL1lqi3EaEJM6W0XQCXOvDBOj5blv0cIVEZki4TJdL7BX3tQcOwXstA4ogENirnfpoRU5FcHiKw0Gre42yqT2KlOnZibE6IsOZwFz4t3qffaMTNFSnWcSixKnKIwIfjQs= xi@nixos"
      ];
  };

  isoImage.contents = [ 
    { 
      source = /home/xi2/Projects/nix/data;
      target = "/data";
    }
    { 
      source = /home/xi2/Projects/devOpsPractics/terraform/nix/data/configuration.nix;
      target = "/etc/nixos/configuration.nix";
    }
  ];
    
}
