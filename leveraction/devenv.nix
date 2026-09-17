{ pkgs, config, ... }:

{
  # PlatformIO does not have a dedicated devenv language option; use its Nix package.
  # devenv.sh/packages/
  packages = with pkgs; [
    platformio
    gcc-arm-embedded
    stlink
    opencode
  ];

  # Keep PlatformIO's project-local data inside the repository.
  env = {
    PLATFORMIO_CORE_DIR = "${config.env.DEVENV_ROOT}/.pio-core";
  };

  # See full reference at https://devenv.sh/reference/options/
}
