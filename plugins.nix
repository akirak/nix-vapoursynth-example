{ symlinkJoin, ffms }:
symlinkJoin {
  name = "vapoursynth-plugins";
  version = "0";
  preferLocalBuild = true;
  paths = [
    ffms
  ];
}
