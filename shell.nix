with import <nixpkgs> {
  overlays = [
    (import (fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/e912ed483e980dfb4666ae0ed17845c4220e5e7c.tar.gz))
  ];
};
stdenv.mkDerivation {
  name = "rust-env";
  buildInputs = [
    pkgs.latest.rustChannels.stable.rust
    pkgs.pkgconfig
  ];

  # Set Environment Variables
  RUST_BACKTRACE = 1;
}
