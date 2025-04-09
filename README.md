# Dotfiles
This repository contains configuration files and installer for quick spinning up a personalised 
productivity workstation. It also includes custom scripts, designed to enhance my regular workflow.

## Motivation

On a daily basis, I’m continuously switching between my main machine running MacOS X and my 
work PC laptop with Windows 11. I also maintain small raspberry pi Homelab server running Debian, 
and occasionally code on a go with my iPad Pro.

I wanted to have a simple and yet effective enough tool/approach to be able to quickly deploy 
a fully functional workspace and synchronise changes across all my devices.

As for now, I can nuke my laptop and get a completely working environment back in less than 10 minutes. 
Awesome.


## Install

To install from scratch use installer.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/akopdev/dotfiles/HEAD/install.sh)"
```

Later, you can use `dotfiles update` to keep machine up-to-date.

## Three rules I follow

### Keep it simple

I’m trying to avoid fancy tools and third-party dependencies as much as possible. 
If a problem can be solved with commands and apps that come as a part of the standard system 
distribution, then I rely on them.

I use Homebrew as a cross-platform package manager (it is the default package manager on 
MacOS, and almost all packages are available for Debian/Ubuntu through Linuxbrew). Some 
Linux-specific apps can be installed by apt.

With the same idea in mind, I use bash scripts for simple automation instead of writing 
“yet another fancy tool.” You may be surprised how much you can do with simple bash scripts.

### Terminal over GUI

I’m using text interfaces pretty much everywhere I can. It is universal across all 
environments (local, remote, container), resource-efficient and lets me better focus on the task.

### Configurations as a code

Pretty much all customisations should live as code in the repository. It will be easy to 
track changes and revert back if needed. And yes, I regularly fall back to some old approach
as they might work for me better.

## Should you use this repo for yourself?

Well, I don’t think that you can just take and use this setup as it is. 

All code and settings, are adapted to my individual needs and requirements. And as they are
continuously changing over time, the code of this repo will remain to change.

However, I encourage you to check my code for inspiration. And if you find that some stuff 
can be done better, don’t hesitate to open an issue or drop me a line. 

I appreciate all kinds of feedback.
