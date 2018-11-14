#!/bin/sh

CURDIR=$(pwd)
RUNLIB=${CURDIR}/../../lib
export LD_LIBRARY_PATH=${RUNLIB}

./qyundaemon -c ${CURDIR}/../conf

