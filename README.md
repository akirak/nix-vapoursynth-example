# An example for using VapourSynth in Nix

This is an example of integrating
[VapourSynth](https://github.com/vapoursynth/vapoursynth) in Nix. It uses
[plugins defined in Nix](https://github.com/akirak/nix-vapoursynth-plugins),
which means you don't have to install plugins globally to your computer or
create a global configuration file.

## Usage

The following is an example command line using `nix run` to run this Nix application
and `ffmpeg` as a sink:

```sh
nix run github:akirak/nix-vapoursynth-example#vspipe -- --y4m -a filename=YOUR_FILE.xxx script.vpy | ffmpeg -i pipe: OUTFILE.mkv
```

It uses `script.vpy` in `vscripts` directory in this repository. This script
accepts the input file as an argument, but VapourSynth usually lets you give a
file name literally.

<!-- For more options, refer to the following resources: FIXME -->
