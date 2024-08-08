#!/usr/bin/env sh

if [ ! -f faultcrosser.rb ]
then
  echo "faultcrosser.rb not found! Are you in faultcrosser root directory?"
  exit 1
fi

if [ ! -d src ]
then
  echo "src directory not found! Are you in faultcrosser root directory?"
  exit 1
fi

mkdir -p examples/twophase && cd examples/twophase || exit

ln -s ../../faultcrosser.rb .
ln -s ../../src .
