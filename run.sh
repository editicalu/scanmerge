#!/bin/bash
# This script is used to stitch together ADF scans of recto verso papers.
# 
# Files made by the first scan should reside in a folder called A. The second side should be called B. It is important that both files should be sorted alphabetically on the scanning order. Make sure that this format is respected by your scanning program. 
#
# It depends on the pdfjoin program, which is usually included in any TeX setup.

rm A/.gitkeep
rm B/.gitkeep

RAWA=$(ls A -1)
RAWB=$(ls B -r -1)

# Split on newline into array
FILESA=(${RAWA//$'\n'/ })
FILESB=(${RAWB//$'\n'/ })

FILECOUNT=${#FILESA[@]}
# off by 1 error
let FILECOUNT--

cd result
for index in $(seq 0 $FILECOUNT)
do
	# Merge the first scan from the recto side and the last scan from the verso side together.
	pdfjoin "../A/${FILESA[$index]}" "../B/${FILESB[$index]}" &
done
wait

cd ..

