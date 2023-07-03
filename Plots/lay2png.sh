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
mcr=${lay%.lay}.mcr
png=${lay%.lay}.png

echo ${lay} ${mcr} ${png}

exit

cat > lay2png.mcr <<EOF
#!MC 1410
$!Pick SetMouseMode
  MouseMode = Select
$!Page Name = 'Untitled'
$!PageControl Create
$!Pick SetMouseMode
  MouseMode = Select
$!OpenLayout  "/Users/mikepark/hlpw/box/Plots/adapt-rans-cd-rqcr.lay"
$!FrameLayout ShowBorder = Yes
$!FrameLayout ShowBorder = No
$!PrintSetup Palette = Color
$!ExportSetup ImageWidth = 1600
$!ExportSetup UseSuperSampleAntiAliasing = Yes
$!ExportSetup ExportFName = '/Users/mikepark/hlpw/box/Plots/untitled.png'
$!Export 
  ExportRegion = AllFrames
EOF