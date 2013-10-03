#!/bin/sh

TARGET=$1
MODE=$2
export AIR_PROJECT_ROOT=src/com/ttm/mobile
export BUILD_DIR=builds
export BIN_DIR=bin

echo $TARGET
echo $MODE

if [[ "$TARGET" == "ios" ]]; then
  if [[ "$MODE" == "debug" ]]; then
    scripts/./build_ios_debug.sh ipa-debug
  fi
  if [[ "$MODE" == "deploy" ]]; then
    scripts/./build_ios_deploy.sh ipa-ad-hoc
  fi
  if [[ "$MODE" == "simulator" ]]; then
    scripts/./build_ios_simulator.sh
  fi
fi
if [[ "$TARGET" == "android" ]]; then
  if [[ "$MODE" == "debug" ]]; then
    scripts/./build_android_debug.sh
  fi
  if [[ "$MODE" == "deploy" ]]; then
    scripts/./build_android_deploy.sh
  fi
fi

if [[ "$TARGET" == "self" ]]; then
  scripts/./CompileAndRunAS3-as.sh
fi