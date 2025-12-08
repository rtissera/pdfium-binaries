#!/bin/bash -eux

PATH_FILE=${GITHUB_PATH:-$PWD/.path}
TARGET_ENVIRONMENT=${PDFium_TARGET_ENVIRONMENT:-}
TARGET_CPU=${PDFium_TARGET_CPU:?}
CURRENT_CPU=${PDFium_CURRENT_CPU:-x64}
MUSL_URL=${MUSL_URL:-https://musl.cc}

run_sudo() {
  if [[ -n "${CODEX_BUILD:-}" ]]; then
    echo "CODEX_BUILD=1 -> skipping: $*"
    return 0
  fi

  sudo "$@"
}

DepotTools_URL='https://chromium.googlesource.com/chromium/tools/depot_tools.git'
DepotTools_DIR="$PWD/depot_tools"
WindowsSDK_DIR="/c/Program Files (x86)/Windows Kits/10/bin/10.0.19041.0"

# Download depot_tools if not exists in this location
if [ ! -d "$DepotTools_DIR" ]; then
  git clone "$DepotTools_URL" "$DepotTools_DIR"
fi

echo "$DepotTools_DIR" >> "$PATH_FILE"

run_sudo apt-get update
run_sudo apt-get install -y cmake pkg-config

if [ "$TARGET_ENVIRONMENT" == "musl" ]; then
  case "$TARGET_CPU" in
    arm)
      MUSL_VERSION="arm-linux-musleabihf-cross"
      ;;

    arm64)
      MUSL_VERSION="aarch64-linux-musl-cross"
      ;;

    riscv64)
      MUSL_VERSION="riscv64-linux-musl-cross"
      ;;

    x64)
      MUSL_VERSION="x86_64-linux-musl-cross"
      ;;

    *)
      echo "Unsupported musl CPU $TARGET_CPU"
      exit 1
      ;;
  esac

  [ -d "$MUSL_VERSION" ] || curl -L "$MUSL_URL/$MUSL_VERSION.tgz" | tar xz
      echo "$PWD/$MUSL_VERSION/bin" >> "$PATH_FILE"
      run_sudo apt-get install -y g++

else
  case "$TARGET_CPU" in
    arm)
      run_sudo apt-get install -y libc6-i386 gcc-10-multilib g++-10-arm-linux-gnueabihf gcc-10-arm-linux-gnueabihf
      ;;

    arm64)
      run_sudo apt-get install -y libc6-i386 gcc-10-multilib g++-10-aarch64-linux-gnu gcc-10-aarch64-linux-gnu
      ;;

    riscv64)
      run_sudo apt-get install -y gcc-10-riscv64-linux-gnu g++-10-riscv64-linux-gnu
      ;;

    x64)
      run_sudo apt-get install -y g++
      ;;
    *)
      echo "Unsupported CPU $TARGET_CPU for linux glibc"
      exit 1
      ;;
  esac
fi
