{
    description = "Pottarr TMXDS : TMUX Session and Directory Manager";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    outputs = { self, nixpkgs }:
    let
        systems = [ "x86_64-linux" "aarch64-linux" ];
        forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
        packages = forAllSystems (system:
        let
            pkgs = nixpkgs.legacyPackages.${system};
        in {
            default = pkgs.stdenvNoCC.mkDerivation {
            pname = "tmxds";
            version = "1.0.0";

            src = self;

            buildInputs = [
                pkgs.ripgrep
                pkgs.skim
                pkgs.tmux
            ];

            dontBuild = true;

            installPhase = ''
                mkdir -p $out/bin
                install -m755 tmxd tmxs $out/bin/
            '';
            };
        });
    };
}
