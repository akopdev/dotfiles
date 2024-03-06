# Dotfiles

![Running dotfiles on Linux](preview.png)

My highly personalized productivity setup for Linux and Mac OS with [Rose Pine](https://rosepinetheme.com/) vibes. 

The main idea is to have a highly portable setup, that can be run the same way on different devices, including tablets and remote servers. 

## System requirements

As I'm using [homebrew package manager](https://brew.sh) for maintaining packages, **only MacOS and Debian** are currently supported. 

> Using Homebrew in Linux environment may look controversial, however, I find it less trade-off when it comes to maintaining modern versions of 
> all packages on both OSX and Unix.

## Install

For the first-time install use a simple script that will download and install all required packages. It covers most  and can be considered as 
a primary way of installation.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/akopdev/dotfiles/HEAD/install.sh)"
```

## Update

If you have already installed dotfiles, you can frequently run an update script that will bring the latest changes to your machine. 

```sh 
dotfiles update
```

> As Homebrew is currently not supporting version definitions, you will always get the latest available version of the package directly from the server. 
> It is impossible to guarantee that all existing software is compatible with each other, so I suggest not to run it too often.

## Client setup

Currently, I'm using `Alacritty` as a cross-platform terminal emulator, that you need to set up manually on your host machine. Custom fonts can be found in the `fonts` directory.

1. Install [Alacritty](https://alacritty.org/)
2. Install fonts
3. Install optional packages, like `kubectl`, `helm`, etc.

For Windows users, it is required manually install alacritty configs.

1. Create a folder `%APPDATA%\alacritty\`
2. Copy all files from `alacritty` directory to `%APPDATA%\alacritty\`
3. Rename `windows.yml` to `alacritty.yml`
4. Replace filenames in `include` section with the absolute path to the files.


