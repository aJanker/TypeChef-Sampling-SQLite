#!/bin/sh

ABSPATH=$(cd "$(dirname "$0")"; pwd)

filesToProcess() {
  local listFile=sqlite_files
  cat $listFile
}


flags=" --serializeAST --bdd --dimacsFeaturePrefix \"\"  --disablePC  \
        -I ../TypeChef-GNUCHeader/x86_64-linux-gnu/4.8/include-fixed \
        -I ../TypeChef-GNUCHeader/x86_64-linux-gnu/4.8/include \
        -I ../TypeChef-GNUCHeader/usr_include/x86_64-linux-gnu \
        -I ../TypeChef-GNUCHeader/usr_include \
        -I $ABSPATH \
        -I $ABSPATH/sqlite \
        --platfromHeader $ABSPATH/platform.h \
        --openFeat $ABSPATH/openfeatures.txt \
        --featureModelDimacs $ABSPATH/sqlite.dimacs \
        --include $ABSPATH/partial_configuration.h \
        --recordTiming  --parserstatistics -A cfginnonvoidfunction -A doublefree -A xfree -A uninitializedmemory -A casetermination -A danglingswitchcode -A checkstdlibfuncreturn -A deadstore -A interactiondegree   "


filesToProcess|while read i; do
         echo "Analysing $ABSPATH/$i.c"
         echo "With settings: $flags"
         ../TypeChef-VAA/typechef.sh  $ABSPATH/sqlite$i.c $flags
         done

