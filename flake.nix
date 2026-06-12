{
  description = "Nix flake packing the fr(iendly) ed(itor)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
      ];
      forAllSystems = function: nixpkgs.lib.genAttrs systems (system:
        function nixpkgs.legacyPackages.${system});
    in
      nixpkgs.lib.foldAttrs nixpkgs.lib.mergeAttrs {} (
        nixpkgs.lib.mapAttrsToList (_: v: v) (
          forAllSystems (pkgs:
            let
              inherit (pkgs)
                stdenv
                callPackage
                ;

              system = stdenv.hostPlatform.system;
            in {
              packages.${system}.default = callPackage ./package.nix {};
            })
        ));
}
