#!/bin/bash -eu

CPU_NAMES="arm|arm64|x64|riscv64"
ENV_NAMES="musl"
STEP_REGEX="[0-9]"

START_STEP=0

if [[ $# == 0 ]]
then
  echo "PDFium build script.
https://github.com/bblanchon/pdfium-binaries

Usage $0 [options] cpu [env]

Arguments:
   cpu      = Target CPU ($CPU_NAMES)
   env      = Target environment ($ENV_NAMES)

Options:
  -b branch = Chromium branch (default=main)
  -s 0-10   = Set start step (default=0)
  -d        = debug build"
  exit
fi

while getopts "bdms:" OPTION
do
  case $OPTION in
    b)
      export PDFium_BRANCH="$OPTARG"
      ;;

    d)
      export PDFium_IS_DEBUG=true
      ;;

    s)
      START_STEP="$OPTARG"
      ;;

    *)
      echo "Invalid flag -$OPTION"
      exit 1
  esac
done
shift $(($OPTIND -1))

if [[ $# -lt 1 ]]
then
  echo "You must specify target CPU"
  exit 1
fi

if [[ $# -gt 2 ]]
then
  echo "Too many arguments"
  exit 1
fi


if [[ ! $1 =~ ^($CPU_NAMES)$ ]]
then
  echo "Unknown CPU: $1"
  exit 1
fi

if [[ $# -eq 2 ]]
then
  if  [[ ! $2 =~ ^($ENV_NAMES)$ ]]
  then
    echo "Unknown environment: $2"
    exit 1
  fi
fi

if [[ ! $START_STEP =~ ^($STEP_REGEX)$ ]]
then
  echo "Invalid step number: $START_STEP"
  exit 1
fi

export PDFium_TARGET_OS=linux
export PDFium_TARGET_CPU=$1
export PDFium_TARGET_ENVIRONMENT=${2:-}

set -x

ENV_FILE=${GITHUB_ENV:-.env}
PATH_FILE=${GITHUB_PATH:-.path}

[ $START_STEP -le 0 ] && . steps/00-environment.sh
source "$ENV_FILE"

[ $START_STEP -le 1 ] && . steps/01-install.sh
PATH="$(tr '\n' ':' < "$PATH_FILE")$PATH"
export PATH

[ $START_STEP -le 2 ] && . steps/02-checkout.sh
[ $START_STEP -le 3 ] && . steps/03-patch.sh
[ $START_STEP -le 4 ] && . steps/04-install-extras.sh
[ $START_STEP -le 5 ] && . steps/05-configure.sh
[ $START_STEP -le 6 ] && . steps/06-build.sh
[ $START_STEP -le 7 ] && . steps/07-stage.sh
[ $START_STEP -le 8 ] && . steps/08-licenses.sh
[ $START_STEP -le 9 ] && . steps/09-test.sh
[ $START_STEP -le 10 ] && . steps/10-pack.sh
