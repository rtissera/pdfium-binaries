#!/bin/bash -eux

PATH_FILE=${GITHUB_PATH:-$PWD/.path}
SOURCE="${PDFium_SOURCE_DIR:-pdfium}"
CPU="${PDFium_TARGET_CPU:?}"

pushd "$SOURCE"

if [[ -n "${CODEX_BUILD:-}" ]]; then
  echo "CODEX_BUILD=1 -> skipping build/install-build-deps.sh"
else
  build/install-build-deps.sh
fi

gclient runhooks
build/linux/sysroot_scripts/install-sysroot.py "--arch=$CPU"

popd
