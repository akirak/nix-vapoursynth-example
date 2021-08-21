# Provide a vspipe executable with a custom XDG_CONFIG_HOME directory which
# contains a configuration file for selected plugins
{ runCommandNoCC, makeWrapper, vapoursynth, writeTextFile, plugins }:
let
  configFile = writeTextFile {
    name = "vapoursynth-config-file";
    text = ''
      SystemPluginDir=${plugins}
    '';
  };
in
runCommandNoCC "vapoursynth-with-plugins"
{
  name = "vapoursynth-with-plugins";
  version = "0";

  propagatedBuildInputs = [
    vapoursynth
  ];

  nativeBuildInputs = [
    makeWrapper
  ];
} ''
  mkdir -p $out/bin
  mkdir -p $out/share/vapoursynth-with-plugins/xdg-config/vapoursynth
  cp ${configFile} $out/share/vapoursynth-with-plugins/xdg-config/vapoursynth/vapoursynth.conf

  makeWrapper ${vapoursynth}/bin/vspipe $out/bin/vapoursynth \
    --set XDG_CONFIG_HOME $out/share/vapoursynth-with-plugins/xdg-config
''
