#!/bin/bash
# Preventing maxima from spamming your home directory with gnuplot and maxout files
echo "maxima_tempdir:\"/tmp\";" >> ~/.maxima/maxima-init.mac
