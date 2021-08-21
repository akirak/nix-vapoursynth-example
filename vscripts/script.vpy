# -*- mode: python; -*-

from vapoursynth import core
# Add filters and plugins if necessary

# You need to pass the input file from the command line
# e.g. vspipe -a filename=xxxxx.mkv script.vpy outfile
video = core.ffms2.Source(source=filename)

# Alternatively, you can pass the input file literally
# video = core.ffms2.Source(source='xxxxx.mkv')

# You can apply functions and filters
video = core.eedi3m.EEDI3(video, 2)

# video = core.std.Transpose(video)

video.set_output()
