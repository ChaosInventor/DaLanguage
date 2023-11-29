# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

set -e

# Bootstrappers are managed as git submodules
git submodule init
git submodule update

# Location of the repository root
REPO_ROOT=${REPO_ROOT:-..}
# Name of the build directory that should be used
BUILD_DIR=${BUILD_DIR:-build}
# Which directory under `Bootstrapping` to use
BOOTSTRAPPER_DIR=${BOOTSTRAPPER_DIR:-C}
# The command to run under `$BOOTSTRAPPER_DIR` to build the bootstrapper
BOOTSTRAPPER_BUILD=${BOOTSTRAPPER_BUILD:-make build/bin/Interpreters/proto}
# The bootstrapper's command, assumed to be under `$BOOTSTRAPPER_DIR`
BOOTSTRAPPER_CMD=${BOOTSTRAPPER_CMD:-build/bin/Interpreters/proto}

bootstrapper=$REPO_ROOT/Bootstrapping/$BOOTSTRAPPER_DIR/$BOOTSTRAPPER_CMD
proto=$REPO_ROOT/Bootstrapping/proto.dali
build_dir=$REPO_ROOT/$BUILD_DIR

build_bootstrapper()
{
    (
        set -e
        cd $REPO_ROOT/Bootstrapping/$BOOTSTRAPPER_DIR/
        $BOOTSTRAPPER_BUILD
    )
}

mkdir -p $build_dir

build_bootstrapper
$bootstrapper $proto < $proto > $build_dir/proto.out
