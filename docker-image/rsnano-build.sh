#! /bin/bash

if [ -d "/home/rustnanodev/rsnano-node/build_rsnano" ] 
then
    rm -rf /home/rustnanodev/rsnano-node/build_rsnano 
fi

mkdir /home/rustnanodev/rsnano-node/build_rsnano

cd /home/rustnanodev/rsnano-node/build_rsnano
cmake -G "Unix Makefiles" -DNANO_TEST=ON -DCMAKE_BUILD_TYPE=Debug ..
make nano_node build_tests -j4
