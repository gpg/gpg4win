#! /bin/bash

cd $(dirname $0)

docker build -t g10-build-appimage-kleopatra:centos7 appimage
