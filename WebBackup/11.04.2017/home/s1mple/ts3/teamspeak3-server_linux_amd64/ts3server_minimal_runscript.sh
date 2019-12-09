#!/bin/sh

export LD_LIBRARY_PATH=".:$LD_LIBRARY_PATH"

D1=$(readlink -f "$0")
D2=$(dirname "${D1}")
cd "${D2}"
./ts3server $@


