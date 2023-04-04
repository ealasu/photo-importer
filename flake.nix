{
  inputs = {
    nixpkgs.url      = "github:nixos/nixpkgs/nixos-22.11";
    rust-overlay.url = "github:oxalica/rust-overlay";
    utils.url        = "github:numtide/flake-utils";
    naersk.url        = "github:nix-community/naersk";
  };

  outputs = { self, nixpkgs, rust-overlay, utils, naersk }:
    utils.lib.eachDefaultSystem (system: let
      overlays = [ (import rust-overlay) ];
      pkgs = import nixpkgs {
        inherit system overlays;
      };
      #pkgs = nixpkgs.legacyPackages."${system}";
      naersk-lib = naersk.lib."${system}";
    in rec {
      # `nix build`
      packages.my-project = naersk-lib.buildPackage {
        pname = "my-project";
        root = ./.;
      };
      defaultPackage = packages.my-project;

      # `nix run`
      apps.my-project = utils.lib.mkApp {
        drv = packages.my-project;
      };
      defaultApp = apps.my-project;

      # `nix develop`
      devShell = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          pkgconfig
          rust-bin.beta.latest.complete
          cargo-edit
        ];
      };
    });
}
