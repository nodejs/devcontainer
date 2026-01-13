# Image variants using Nix and direnv

`.envrc` files are consumed by [nix-direnv][], and will install software and
environment variables defined in the [`shell.nix`][] in the nodejs/node repository.

To add an image variant, add a new file starting with `use nix` with the flags such as:

- [`--impure`][]: to make sure user can still access non-Nix software.
- [`-I nixpkgs=/home/developer/nodejs/node/tools/nix/pkgs.nix`][`-I`]:
  that defines which version of the [NixOS/nixpkgs][] repository it should load.
- [`--arg <key> <nix-value>`][`--arg`]: Override the default values defines in the
  [`shell.nix`][] with some custom value. E.g., pass
  `--arg extraConfigFlags '["--enable-asan" "--enable-ubsan"]'` to
  enable ASAN and UBSAN.
- [`--argstr <key> <string-value>`][`--argstr`]: Useful to avoid the double quoting,
  e.g. instead of `--arg icu '"small"'`, it is equivalent to pass `--argstr icu small`.

It is possible to add custom environment variables, or to override Nix-defined ones by
adding `export NAME_OF_THE_VAR=value` lines at the end of the file, however it is
preferred to keep all environment variable definitions in one place.

[nix-direnv]: https://github.com/nix-community/nix-direnv
[`shell.nix`]: https://github.com/nodejs/node/blob/HEAD/shell.nix
[NixOS/nixpkgs]: https://github.com/NixOS/nixpkgs
[`--impure`]: https://nix.dev/manual/nix/2.33/command-ref/nix-shell.html#opt-impure
[`-I`]: https://nix.dev/manual/nix/2.33/command-ref/nix-shell.html#opt-I
[`--arg`]: https://nix.dev/manual/nix/2.33/command-ref/nix-shell.html#opt-arg
[`--argstr`]: https://nix.dev/manual/nix/2.33/command-ref/nix-shell.html#opt-argstr
