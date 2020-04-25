
#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. $DIR/common.sh

if [[ "$http_proxy" != "" ]]; then
    echo "Proxy set, creating build_args to use it"
    export build_args="--build-arg http_proxy=$http_proxy --build-arg https_proxy=$http_proxy"
fi

if [[ "$build_cores" == "" ]]; then
    export build_cores=16
fi

docker build --pull --rm --tag amarok-builder:latest $build_args -f Dockerfile .

docker image prune -f

docker run --rm -t -v $DIR/build:/build --env build_cores=$build_cores --name amarok-builder amarok-builder:latest ./build.sh

docker run --rm -t -v $DIR/build:/build --name amarok-builder amarok-builder:latest chown -R $UID:$UID /build/

cp -a DEBIAN $DIR/build/

VERSION=$(cat "$DIR/build/version")
rm -f "$DIR/build/version"

sed -i "s/VERSION_FILL/$VERSION/" $DIR/build/DEBIAN/control

dpkg-deb --build $DIR/build/

mv $DIR/build.deb $DIR/amarok-$VERSION-focal-amd64.deb
