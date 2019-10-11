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

  overrides = self: super: let
    record-hasfield = pkgs.fetchFromGitHub {
      owner = "ndmitchell";
      repo = "record-hasfield";
      rev = "1a80ab42c5d966b6a439633621f2524c84e93bc5";
      sha256 = "1xv9frkbjbnxlyngs9hr5yy9pqw0gy0pqnzbng9crbywwqpbkh7h";
    };
  in
  {
    record-hasfield = self.callCabal2nix "record-hasfield" record-hasfield {};
  };

})
