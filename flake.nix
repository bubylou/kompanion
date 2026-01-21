{
  description = "A self hosted backend for bookworms, tightly coupled with KOReader";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.default = pkgs.buildGoModule rec {
        pname = "kompanion";
        src = ./.;
        version = "0.0.4";
        vendorHash = "sha256-c6fSGqjnq3d5qXj/IrvE+lULSf1pAjqbjkVPNaRG8+s=";

        ldflags = [
          "-X main.version=${version}"
          "-w"
          "-s"
        ];
      };
    });
}
