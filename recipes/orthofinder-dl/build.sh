#!/bin/bash

mkdir -p $PREFIX/bin
mkdir -p $PREFIX/opt/orthofinder-dl

cp -R orthofinder/* $PREFIX/opt/orthofinder-dl

ln -s $PREFIX/opt/orthofinder-dl/orthofinder.py $PREFIX/bin/orthofinder-dl.py
