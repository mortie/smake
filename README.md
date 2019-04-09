# smake

`smake` is a simple Makefile generator which requires little to no configuration.
I view it sort of as a version of make with a new, more modern set of implicit
goals.

<!-- toc -->

- [Install](#install)
- [Usage](#usage)
- [Making a smake-compatible project](#making-a-smake-compatible-project)
- [The Smakefile](#the-smakefile)
  * [`PROJNAME`](#projname)
  * [`PROJTYPE`](#projtype)
  * [`PKGS`](#pkgs)
  * [`DEPENDS`](#depends)
  * [`WARNINGS`](#warnings)
  * [`CONFIG`](#config)
  * [`CCOPTS`/`LDOPTS`](#ccoptsldopts)
- [Build configurations](#build-configurations)

<!-- tocstop -->

## Install

Just put the `smake` script somewhere in your `PATH`.

``` shell
curl 'https://raw.githubusercontent.com/mortie/smake/master/smake' | sudo tee /usr/local/bin/smake && sudo chown +x /usr/local/bin/smake
```

## Usage

The `smake` command works very similarly to `make`. Run `smake -h` for help
output.

## Making a smake-compatible project

Smake makes a few assumptions about your project:

* All C files must end in `.c`, all C++ files in `.cc`.
* All headers must end in `.h`.
* All source code and private headers should go in `src`.
* All public headers, if applicable, should go in `include`.
* Each Smake project produces exactly one executable or library
  (though a project can depend on other smake projects in other directories).

## The Smakefile

When running `smake`, it will look for a file called `Smakefile` in the current
directory, like `make` looks for `Makefile`. This file uses Make's syntax, and
is imported from the generated Makefile. The `smake` tool itself also reads it
to extract a few values from it.

Any make code is valid in the Smakefile, so you can define your own targets or
do whatever you want to do, but the most common use case is to set variable.

You may want to take a look at a
[generated Makefile](https://github.com/mortie/smake/blob/master/examples/complex/Makefile)
to get a feel for what variables and target exists and how they interact with
each other.

### `PROJNAME`

This is the name of your project, determining the name of the
executable/library which will be generated.

Default: For convenience when experimenting or prototyping, `PROJNAME` defaults
to the name of the current directory, but any serious project should set it
explicitly. A warning will be printed if it's not set.

### `PROJTYPE`

The type of the project. The possible values are:

* `exe`: An executable.
* `solib`: A shared library.
* `alib`: A static library.
* `lib`: A library where both a `.a` and a `.so` is generated.

Default: `exe`

### `PKGS`

A list of `pkg-config` packages you depend on.

### `DEPENDS`

A list of paths to other smake projects you depend on.

### `WARNINGS`

Warning flags.

Default: `-Wall -Wextra -Wno-unused-parameter`

### `CONFIG`

The current build configuration. Treat this as a read-only property; it's meant
to be set when running `smake`.

Default: `release`

### `CCOPTS`/`LDOPTS`

CCOPTS is flags for the C or C++ compiler, LDOPTS for the linker.

CCOPTS defaults: `-Iinclude`, and `-isystem` flags for any dependencies you may
have

LDOPTS defaults: `-L` flags for any library dependencies you may have

## Build configurations

Smake introduces the concept of build configurations. To define a new build
configuration, let's call it `myconfig`, set the variables `CCOPTS_myconfig`
and `LDOPTS_myconfig`. `$(CCOPTS_$(CONFIG))` is included in the `CFLAGS`/`CXXFLAGS`
variables, `$(LDOPTS_$(CONFIG))` is included in `LDFLAGS`, so when someone runs
your project with `smake CONFIG=myconfig` (or `make CONFIG=myconfig`), your
new build options will be used.

Build configs are built into the directory `$(BUILDDIR)/$(CONFIG)` (that is,
`build/$(CONFIG)`), so cleaning before building with a new config is generally
not necessary.

A build config for a testing build using [Snow](http://github.com/mortie/snow/)
would for example generally just consist of `CCOPTS_testing = -DSNOW_ENABLED`.
