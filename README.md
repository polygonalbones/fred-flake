# fred-flake
Nix flake packing the fr(iendly) ed(itor)

# Usage
Add the flake to your system flake:
```
inputs = {
  fred = {
    url = "github:polygonalbones/fred-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  }
}
```
then you can add it to your systemPackages in your `/etc/nixos/configuration.nix`:
```
environment.systemPackages = with pkgs; [
  fred.packages.${system}.default
];
```

Finally, you need to provide your own copy of the `fred-linux` binary (if you are an alpha tester in the discord, there is a pinned message with the link to the downloads) and run:
```
nix store add --mode flat fred-linux
```
'fred-linux' is the path where your binary is. for me it is /home/polygonalbones/fred-linux
