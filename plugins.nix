{ runCommandNoCC, ffms, vapoursynth-eedi3 }:
runCommandNoCC "vapoursynth-plugins"
{
  propagatedBuildInputs = [
    ffms
    vapoursynth-eedi3
  ];
} ''
  mkdir -p $out

  for d in ${ffms} ${vapoursynth-eedi3}; do
      for f in $d/lib/vapoursynth/*; do
          ln -s -t $out $f
      done
  done
''
