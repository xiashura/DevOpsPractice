with (import <nixpkgs> {});

stdenv.mkDerivation {

	RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}"; 

  KUBECONFIG = "./.kube/config";

  name = "terraform";
  buildInputs = [
    ansible
    kubectl
    terraform_0_15
    terraform-providers.libvirt
  ];
}

