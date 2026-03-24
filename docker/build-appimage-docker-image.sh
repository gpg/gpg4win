#! /bin/bash

cd $(dirname $0)

docker build --pull -t g10-build-appimage-kleopatra:centos7 appimage
