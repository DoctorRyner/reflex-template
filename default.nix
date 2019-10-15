{ obelisk ? import ./.obelisk/impl {
    system = builtins.currentSystem;
    iosSdkVersion = "10.2";
    # You must accept the Android Software Development Kit License Agreement at
    # https://developer.android.com/studio/terms in order to build Android apps.
    # Uncomment and set this to `true` to indicate your acceptance:
    # config.android_sdk.accept_license = false;
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
    record-dot-preprocessor = pkgs.fetchFromGitHub {
      owner = "ndmitchell";
      repo = "record-dot-preprocessor";
      rev = "50590d4474c59a3175d8af943a83de641a6c3c53";
      sha256 = "1ywxwnhixic63n7c5wgky7dws33bb5949nqfh9miaim6l5rz56v4";
    };
    xz = pkgs.fetchFromGitHub {
      owner = "xz-mirror";
      repo = "xz";
      rev = "de1f47b2b40e960b7bc3acba754f66dd19705921";
      sha256 = "1ywxwnhixic63n7c5wgky7dws33bb5949nqfh9miaim6l5rz66v4";
    };
    clay = pkgs.fetchFromGitHub {
      owner = "sebastiaanvisser";
      repo = "clay";
      rev = "2795065ecf671b91382aa2bfff18d826037798b5";
      sha256 = "1hqzm8vqvxj0ik6l52mr4vhn7jia4i4ynky4m6219wf6z608rzrj";
    };
    hspec = pkgs.fetchFromGitHub {
      owner = "hspec";
      repo = "hspec";
      rev = "37b7bedc9d35543ae7ecbb07ade06cb6b26b54a0";
      sha256 = "0xkdgl1hf85j7isz1xi60zqv3vg7apm2psvrkx7k8y5v55ivp2iv";
    };
  in
  {
    record-hasfield = self.callCabal2nix "record-hasfield" record-hasfield {};
    record-dot-preprocessor = self.callCabal2nix "record-dot-preprocessor" record-dot-preprocessor {};
    clay = self.callCabal2nix "clay" clay {};
    hspec = self.callCabal2nix "hspec" hspec {};
    api = super.api.overrideAttrs(oa: { buildInputs = oa.buildInputs ++ [ pkgs.lzma ]; });
  };
})
