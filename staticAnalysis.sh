#!/bin/sh

ABSPATH=$(cd "$(dirname "$0")"; pwd)

filesToProcess() {
  local listFile=sqlite_files
  cat $listFile
}


flags=" --bdd   --disablePC \
        -I /usr/local/include \
        -I /usr/lib/gcc/x86_64-linux-gnu/4.6/include-fixed \
        -I /usr/lib/gcc/x86_64-linux-gnu/4.6/include \
        -I /usr/include/x86_64-linux-gnu \
        -I /usr/include \
        -I $ABSPATH \
        -I $ABSPATH/sqlite \
        --platfromHeader $ABSPATH/platform.h \
        --openFeat $ABSPATH/openfeatures.txt \
        --featureModelDimacs $ABSPATH/sqlite.dimacs \
        --include $ABSPATH/partial_configuration.h \
        --parserstatistics -A deadstore -A interactiondegree  "


filesToProcess|while read i; do
         echo "Analysing $ABSPATH/$i.c"
         echo "With settings: $flags"
         ../TypeChef/typechef.sh $ABSPATH/sqlite$i.c $flags
         done

