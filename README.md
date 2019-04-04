# smake

`smake` is a simple Makefile generator which requires little to no configuration.

<!-- toc -->

- [Install](#install)
- [Usage](#usage)
- [Making a smake-compatible project](#making-a-smake-compatible-project)

<!-- tocstop -->

## Install

Just put the `smake` script somewhere in your `PATH`.

``` shell
curl 'https://raw.githubusercontent.com/mortie/smake/master/smake' | sudo tee /usr/local/bin/smake
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
* Each Smake project produces exactly one executable or library.
