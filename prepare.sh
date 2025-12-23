#!/bin/bash

git clone -b current --single-branch https://github.com/vyos/vyos-build
cp custom.toml vyos-build/data/build-flavors/
cp entrypoint.sh vyos-build/
