#!/bin/bash -eux

CPU="${PDFium_TARGET_CPU:?}"
TARGET_ENVIRONMENT="${PDFium_TARGET_ENVIRONMENT:-}"
SOURCE_DIR="$PWD/example"
CMAKE_ARGS=()
CAN_RUN_ON_HOST=false
EXAMPLE="./example"
SKIP_TESTS=false

export PDFium_DIR="$PWD/staging"

PREFIX=""
SUFFIX=""

case "$CPU" in
  arm)
    if [ "$TARGET_ENVIRONMENT" == "musl" ]; then
      PREFIX="arm-linux-musleabihf-"
    else
      PREFIX="arm-linux-gnueabihf-"
      SUFFIX="-10"
    fi
    ;;

  arm64)
    if [ "$TARGET_ENVIRONMENT" == "musl" ]; then
      PREFIX="aarch64-linux-musl-"
    else
      PREFIX="aarch64-linux-gnu-"
      SUFFIX="-10"
    fi
    ;;

  x64)
    if [ "$TARGET_ENVIRONMENT" == "musl" ]; then
      PREFIX="x86_64-linux-musl-"
    else
      CAN_RUN_ON_HOST=true
    fi
    ;;

  riscv64)
    if [ "$TARGET_ENVIRONMENT" == "musl" ]; then
      PREFIX="riscv64-linux-musl-"
    else
      PREFIX="riscv64-linux-gnu-"
      SUFFIX="-10"
    fi
    ;;

  *)
    echo "Unsupported CPU: $CPU"
    exit 1
    ;;
esac

CMAKE_ARGS+=(
  -D CMAKE_C_COMPILER="${PREFIX:-}gcc${SUFFIX:-}"
  -D CMAKE_CXX_COMPILER="${PREFIX:-}g++${SUFFIX:-}"
  "$SOURCE_DIR"
)

if [ $SKIP_TESTS == "false" ]; then
  mkdir -p build
  pushd build

  cmake "${CMAKE_ARGS[@]}"
  cmake --build .

  file $EXAMPLE

  if [ $CAN_RUN_ON_HOST == "true" ]; then
    $EXAMPLE "${PDFium_SOURCE_DIR}/testing/resources/hello_world.pdf" hello_world.ppm
  fi

  popd
fi;
