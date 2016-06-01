#!/bin/sh

ABSPATH=$(cd "$(dirname "$0")"; pwd)

filesToProcess() {
  local listFile=sqlite_files
  cat $listFile
}


flags=" --bdd --dimacsFeaturePrefix \"\"  --disablePC --reuseAST \
        -I $ABSPATH \
        -I $ABSPATH/sqlite \
        --platfromHeader $ABSPATH/platform.h \
        --openFeat $ABSPATH/openfeatures.txt \
        --featureModelDimacs $ABSPATH/sqlite.dimacs \
        --include $ABSPATH/partial_configuration.h \
        --parserstatistics --recordTiming  "


filesToProcess|while read i; do
         echo "Analysing $ABSPATH/$i.c"
         echo "With settings: $flags"
         ./sampling.sh  $ABSPATH/sqlite$i.c $flags
         done

