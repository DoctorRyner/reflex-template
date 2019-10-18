{ obelisk ? import ./.obelisk/impl {
    system = builtins.currentSystem;
    iosSdkVersion = "10.2";
    config.android_sdk.accept_license = true;
  }
}:
with obelisk;
project ./. ({ pkgs, ... }: {
  android.applicationId = "systems.obsidian.obelisk.examples.minimal";
  android.displayName = "Obelisk Minimal Example";
  ios.bundleIdentifier = "systems.obsidian.obelisk.examples.minimal";
  ios.bundleName = "Obelisk Minimal Example";

  packages = {
    api = ./api;
  };

  overrides = self: super: let
    record-hasfield = pkgs.fetchFromGitHub {
      owner = "ndmitchell";
      repo = "record-hasfield";
      rev = "1a80ab42c5d966b6a439633621f2524c84e93bc5";
      sha256 = "1xv9frkbjbnxlyngs9hr5yy9pqw0gy0pqnzbng9crbywwqpbkh7h";
    };
    clay = pkgs.fetchFromGitHub {
      owner = "sebastiaanvisser";
      repo = "clay";
      rev = "767efdff4e52f99c5bfe5932bbd3c19317215cd3";
      sha256 = "0j2wc58zfh0hc8dja3kkmy5mbhszlibkjvi9fsgz47qgi9c64jfm";
    };
    record-dot-preprocessor = pkgs.fetchFromGitHub {
      owner = "ndmitchell";
      repo = "record-dot-preprocessor";
      rev = "50590d4474c59a3175d8af943a83de641a6c3c53";
      sha256 = "1ywxwnhixic63n7c5wgky7dws33bb5949nqfh9miaim6l5rz56v4";
    };
  in
  {
    record-hasfield = self.callCabal2nix "record-hasfield" record-hasfield {};
    record-dot-preprocessor = self.callCabal2nix "record-dot-preprocessor" record-dot-preprocessor {};
    clay = pkgs.haskell.lib.dontCheck (self.callCabal2nix "clay" clay {});
    api = super.api.overrideAttrs(oa: { buildInputs = oa.buildInputs ++ [ pkgs.lzma ]; });
  };
})
