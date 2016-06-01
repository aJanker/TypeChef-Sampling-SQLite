#!/bin/sh

ABSPATH=$(cd "$(dirname "$0")"; pwd)

filesToProcess() {
  local listFile=sqlite_files
  cat $listFile
}


flags=" --bdd --dimacsFeaturePrefix \"\"  --disablePC --reuseAST \
        -I /usr/local/include \
        -I /usr/lib/gcc/x86_64-linux-gnu/4.8/include-fixed \
        -I /usr/lib/gcc/x86_64-linux-gnu/4.8/include \
        -I /usr/include/x86_64-linux-gnu \
        -I /usr/include \
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
         sbatch -p chimaira  -A spl -n 1 -c 2 --exclude=chimaira17 --time=06:00:00  --mem_bind=local -o /home/janker/chimaira_update/run-%j  /scratch/janker/sqlite/cRefactor-SQLiteTH3Evaluation/sampling.sh  $ABSPATH/sqlite$i.c $flags
         done

