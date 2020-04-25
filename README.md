# amarok-eoan-builder

Now with Focal build!

_Most users will just want to download a release from the releases page. The code is included below in case you'd like to build your own._

A simple, dumb and ugly builder that pulls a copy of master from https://github.com/KDE/amarok/ and compiles it (at this time they are not tagging nor branching for versions) _without_ polluting your system with dev packages.

It is solely aimed at Ubuntu 19.10 (eoan)/20.04 (focal) support, which is missing an amarok package.

- To build for 19.10, please switch to the 19.10-eoan branch.

It'll create a .deb for you with (hopefully!) correct dependancies to just install (e.g. apt install amarok-_version_.deb).

## Amarok

Amarok itself is suffering from lack of maintenance and KF5 changes with widgets. Please don't report Amarok bugs here, I'm not a maintainer of it.

However if you spot a dependancy I'm missing during the build please raise an issue or create a pull request - though the code does let you easily build your own with whichever dependancy you need ;-)

## Prerequisites

1) Install docker. This is often in your package management system.
2) Ensure you're in the docker group, e.g. `sudo usermod -a -G docker yourusername`. User group changes usually require a logout/login to apply.

## Usage

**BEWARE** There are a HUGE list of dependancies for this build. It could chew quite a bit of bandwidth and disk space.

See below for environment variables that can affect the build.

Building should be as simple as:

```
./build.sh
```

And once complete, you should find an `amarok-X.Y.Z.deb` suitable for Ubuntu 20.04 available.

### Environment variables

These should be set with export, e.g.

```
export build_cores=10
```

- `build_cores`: Manually choose the core count for builds, used in `make -j$build_cores install`. Default is 6.
- `http_proxy`: For caching files retrieved over HTTP.

# Copyright etc

All copyrights and trademarks belong to their respective owners.

The code in this repository is freely available for anyone to use or modify without any restriction, though no warranty or suitability or fitness for any use is given.
