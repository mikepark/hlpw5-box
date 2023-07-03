#!/usr/bin/env bash

set -e # exit on first error
set -u # Treat unset variables as error
set -x # echo commands

if [ $# -lt 1 ]
then
  for lay in *.lay
  do
    ${0} ${lay}
  done
  exit
fi

lay=$1
png=${lay%.lay}.png

echo ${lay} ${png}

mcr=lay2png.mcr

cat > ${mcr} <<EOF
#!MC 1410
\$!OpenLayout  '${lay}'
\$!FrameLayout ShowBorder = No
\$!ExportSetup ImageWidth = 1600
\$!ExportSetup UseSuperSampleAntiAliasing = Yes
\$!ExportSetup ExportFName = '${png}'
\$!Export 
  ExportRegion = AllFrames
EOF

/Applications/Tecplot\ 360\ EX\ 2022\ R2/Tecplot\ 360\ EX\ 2022\ R2.app/Contents/MacOS/Tecplot\ 360\ EX\ 2022\ R2 \
  -b ${mcr}

rm ${mcr} batch.log


