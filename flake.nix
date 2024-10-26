{
  description = "Ancient toolchain for Rinato kernel compilation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
          pkgs32 = pkgs.pkgsi686Linux;
        in
        with pkgs;
        {
          packages.default = pkgs32.stdenv.mkDerivation {
            pname = "rinato-kernel-build-toolchain";
            version = "4.6.2_20110921";

            src = ./toolchain-downstream;

            buildInputs = [ ];

            installPhase = ''
              mkdir -p $out/opt/toolchain/
              cp -r . $out/opt/toolchain/

              mkdir -p $out/bin
              for binary in $out/opt/toolchain/bin/*; do
                # Prefix all names with rinato- to avoid shadowing any potentially newer ARM toolchain in env
                ln -s $out/opt/toolchain/bin/$(basename $binary) $out/bin/rinato-$(basename $binary)
              done
            '';

            meta = with lib; {
              homepage = "https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads";
              description = "GCC for Rinato kernel";
              license = licenses.gpl3;
              platforms = platforms.unix;
            };

          };
        }
      );
}
