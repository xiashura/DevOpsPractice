with (import <nixpkgs> {});

stdenv.mkDerivation {

  KUBECONFIG = "./.kube/config";
  
  shellHook = '' 
    pip install --user jinja2
  '';

  name = "dev-ops-practics";
  buildInputs = [
    ansible
    python39
    python39Packages.pip
    kubectl
    terraform_0_15
    terraform-providers.libvirt
  ];
}

