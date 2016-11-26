#!/bin/bash
# Preventing maxima from spamming your home directory with gnuplot and maxout files
touch ~/.maxima/maxima-init.mac
grep -q -F "maxima_tempdir:\"/tmp\";" ~/.maxima/maxima-init.mac || echo "maxima_tempdir:\"/tmp\";" >> ~/.maxima/maxima-init.mac
