# TSYS Group - Engineering Documentation - Visual Studio Code Environment Setup Guide

- [TSYS Group - Engineering Documentation - Visual Studio Code Environment Setup Guide](#tsys-group---engineering-documentation---visual-studio-code-environment-setup-guide)
  - [Introduction](#introduction)
    - [Environmental considerations/assumptions](#environmental-considerationsassumptions)
    - [External Software Programs/Services Used](#external-software-programsservices-used)
    - [Short version](#short-version)
  - [Requirements and dependencies](#requirements-and-dependencies)
    - [Languages Used](#languages-used)
    - [Deployment Targets](#deployment-targets)
  - [General setup](#general-setup)
  - [Plugins - Team-*](#plugins---team-)
    - [General Tooling](#general-tooling)
    - [Docker / k8s](#docker--k8s)
    - [Git](#git)
    - [(Cross) Compile / (Remote) Debug / (Remote) development](#cross-compile--remote-debug--remote-development)
    - [Markdown (and documentation in )](#markdown-and-documentation-in-)
    - [Data](#data)
    - [Bash](#bash)
  - [Plugins - Team-SWEng](#plugins---team-sweng)
    - [API (rest) development](#api-rest-development)
    - [Web App development](#web-app-development)
    - [YAML](#yaml)
    - [Rust](#rust)
    - [C/C++](#cc)
      - [Arduino/Seeduino](#arduinoseeduino)
      - [CUDA](#cuda)
    - [Java](#java)
    - [PHP](#php)
    - [Python](#python)
  - [Plugins - Team-MechEng](#plugins---team-mecheng)
    - [Octave](#octave)
    - [R](#r)
    - [Jupyter](#jupyter)
    - [STL](#stl)
    - [G-code](#g-code)
    - [Gerber](#gerber)

## Introduction

This is the TSYS Visual Studio Code setup guide. It covers how to setup VsCode for all aspects of TSSY Group.

We have a very complex total stack, but don't despair, you will only need a small subset of this.

Which subset of course depends on what part of the TSYS mission you are supporting!

### Environmental considerations/assumptions

- Charles setup is the most comprehensive, as he is the co-founder and (as of Q3 2021) (acting) CTO and needs to develop for all pieces of the stack/products.
- Do not just blindly follow this guide! Pick the pieces you need for your work. If you have any questions, ask in Discord or post to Discourse.

- Working against a remote server/container/k8s cluster over SSH via VsCode Remote
- VsCode Remote Dev is heavily utilized (almost if not exclusively)
- Source code resides in home directory on the server farm, but is edited "locally" on your workstation with VsCode (Remote)

- Using TSYS self hosted Gitea git instance
- Using TSYS self hosted Jenkins CI
- docker/kubectl commands are present and configured to run against the cluster (and you are connected to the VPN)

- Developing in Windows 10/Mac OSX/Linux with a GUI environment running native VsCode (CNW daily driver is a raspberry pi 4 with 8gb ram to help ensure lowest common denominator support/good performance)
- Using Chrome web browser (firefox/safari may work, but are not supported at all)

- Developing primarily at the "git push, magic happens" abstraction layer
- Need to occasionally inspect/debug the magic at various stages of the pipeline
- Need to frequently debug running code on a variety of targets (pi/arduino etc)

- All text documentation is written in Markdown and is posted to Git/Discourse as Markdown
- (tbd soon, actively experimenting)
  - All diagrams are created via text language
  - All diagrams are produced using
    - (blockdiag?
    - uml?
    - markdown extensions?
    - all (or some mix) of the above?
    - what extension(s)to use?)

### External Software Programs/Services Used

You'll need to setup some external tools and services to support the TSYS mission (in addition to VsCode).

Setup of external tools/services is outside the scope of this document. For guidance on tool/service selection and setup, please see the following links:

- <https://git.turnsys.com/TSGTechops/docs-techops/src/branch/master/src/Systems/Admin-Application/AppsAndServices.md>
- <https://git.turnsys.com/TSGTechops/docs-techops/src/branch/master/src/Systems/Admin-RandD/EngineeringWorkstatioNBuildBuide.md>

Once you've setup your needed external tools and services , return to this document and continue with setup of VsCode as needed to work with the tooling you installed.

### Short version

very soon (june 2021) you'll have two options for EZ stack deployment for your product development environment :

1) docker pull TSYSVSC and use with <https://code.visualstudio.com/docs/remote/containers>

2) Login to <https://desktop.turnsys.com> and get a full engineering stack for whatever product you are working on.

Read on to understand the pieces and particulars in case you want to build your own setup.

## Requirements and dependencies

Here is the tool and language requirements of all the TSYS engineering projects/programs/products.

### Languages Used

| Language                         | Used By      | Product Scope                      |
|----------------------------------|--------------|------------------------------------|
| bash                             | TSYS wide    | All                                |
| c/c++                            | Team-SwEng   | MorseFlyer                         |
| CUDA                             | Team MechEng | MorseFlyer (envelope/airframe)     |
| dockerfile/docker compose        | TSYS wide    | All                                |
| geo spatial data                 | Team SwEng   | MorseFlyer (avionics)              |
| Gerber                           | Team HwEng   | MorseSkynet, MorseFlyer (avionics) |
| Go                               | Team-SwEng   | HFNOC/HFNFC/RackRental             |
| helm charts                      | TSYS wide    | All                                |
| Java                             | Team SwEng   | MorseTrackerHUD,MorseTracker       |
| javascript                       | Team SwEng   | MorseTrackerHUD                    |
| Markdown                         | TSYS wide    | All                                |
| octave                           | Team MechEng | MorseFlyer (envelope/airframe)     |
| OpenFAAS                         | Team-SwEng   | RackRental.net                     |
| PHP                              | TEam-SwEng   | RackRental.net , HFNOC/HFNFC       |
| python (Jupyter and stand alone) | Team MechEng | MorseFlyer (envelope/airframe)     |
| R                                | Team MechEng | MorseFlyer (envelope/airframe)     |
| Ruby                             | Team-SwEng   | All (as part of SDLC testing)      |
| Rust                             | Team-SwEng   | HFNOC/HFNFC/RackRental             |
| tcl/tk                           | Team HwEng   | MorseSkynet                        |
| Xilinx                           | Team HwEng   | MorseSkynet                        |
| YAML                             | TSYS wide    | All                                |

### Deployment Targets

| Target                                              | Used By     | Product Scope                      |
|-----------------------------------------------------|-------------|------------------------------------|
| Arduino (cross compiled)                            | Team-SwEng  | MorseFlyer (Avionics)              |
| FreeRTOS (cross compiled)                           | Team-SwEng  | MorseFlyer (Avionics)              |
| Jenkins build pipelines                             | All teams   | All                                |
| OpenMCT farm (java/micro services)                  | Team-SwEng  | MorseTracker/MorseTrackerHUD       |
| Raspberry Pi (cross compiled)                       | Team-SwEng  | MorseFlyer (Avionics)              |
| Subo pi farm (multi arch) Docker / k3s (and balena) | Team-SwEng  | MorseFlyer (Avionics), MorseSkynet |
| TSYS K3S sandbox/dev/prod clusters                  | All teams   | All                                |
| TSYS Web Farm (lots of PHP (wordpress etc))         | Team-WebEng | RackRental.net, HFNOC, HFNFC       |

## General setup

These are steps you need to take before starting development in earnest.

Linux (or at least a mostly linux (WSL/mobaxterm)) environment is presumed for all the below.

You may well find GUI replacements and use them, especially on Windows/MACOSX. They are not supported in any way.

- Setup gitea
  - Login once to <https://git.turnsys.com> so you can be added to the appropriate repos/teams/orgs.
  - Customize any profile etc settings that you wish.
  - Obtain API key to use with gitea-issues plugin
- Setup SSH
  - Setup SSH key
  - Add SSH public key to gitea
- Setup git
  - For all git users:
    - $ git config --global user.name "John Doe"
    - $ git config --global user.email johndoe@example.com
    - Setup git lg : git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
  - for zsh users (and you really should use zsh/oh-my-zsh :)
    - git config --add oh-my-zsh.hide-status 1
    - git config --add oh-my-zsh.hide-dirty 1

## Plugins - Team-*

The plugins documented here are known to work, and are in active/frequent use by Charles as CTO as he hacks on the stack.
Other options exist for almost all the below. If you find something that works better for you, use it!

Consider the below as a suggested/supported baseline.

### General Tooling

- Code Spell Checker <https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker>
- Vim <https://marketplace.visualstudio.com/items?itemName=vscodevim.vim>

### Docker / k8s

- Docker:
  - <https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker>
  - <https://code.visualstudio.com/docs/containers/overview>
- Bridge to K8s <https://marketplace.visualstudio.com/items?itemName=mindaro.mindaro> <https://code.visualstudio.com/docs/containers/bridge-to-kubernetes>

### Git

- Git Extension Pack <https://marketplace.visualstudio.com/items?itemName=donjayamanne.git-extension-pack>
- Git Tree Compare <https://marketplace.visualstudio.com/items?itemName=letmaik.git-tree-compare>
- Git Tags <https://marketplace.visualstudio.com/items?itemName=howardzuo.vscode-git-tags>
- Gitea-VsCode <https://marketplace.visualstudio.com/items?itemName=ijustdev.gitea-vscode>

### (Cross) Compile / (Remote) Debug / (Remote) development

This section is a work in progress. Below is the current guides/plugins that are being tested. Roughly in decreasing order of confirmed stability/active usage.
YMMV, DD , Buyer Beware etc etc etc.

- <https://code.visualstudio.com/docs/remote/remote-overview>
- <https://code.visualstudio.com/docs/remote/ssh>
- <https://dimamoroz.com/2021/03/09/intel-nuc-for-development/>
- <https://github.com/Ed-Yang/rpidebug>
- <https://enes-ozturk.medium.com/remote-debugging-with-gdb-b4b0ca45b8c1>
- <https://enes-ozturk.medium.com/cross-compiling-with-cmake-and-vscode-9ca4976fdd1>
- <https://gist.github.com/aakashpk/e90d4651b074248b4823f6d2dc3373a0>
- <https://marketplace.visualstudio.com/items?itemName=webfreak.debug>
- <https://code.visualstudio.com/docs/cpp/config-linux>

### Markdown (and documentation in )

- Markdown All in One  <https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-oneoo>
- Markdown Preview Enhanced <https://marketplace.visualstudio.com/items?itemName=shd101wyy.markdown-preview-enhanced>
- markdownlint <https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint>
- Excel to markdown table <https://marketplace.visualstudio.com/items?itemName=csholmq.excel-to-markdown-table>
- MdTableEditor < <https://marketplace.visualstudio.com/items?itemName=clover.md-table-editor>>
- Markdown Table Formatter https://marketplace.visualstudio.com/items?itemName=fcrespo82.markdown-table-formatter
- Gitdoc <https://marketplace.visualstudio.com/items?itemName=vsls-contrib.gitdoc>
- Draw.io integration <https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio>
- PlantUML
  - <https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml>
  - <https://www.freecodecamp.org/news/inserting-uml-in-markdown-using-vscode/>
- Latex Workshop <https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop>

### Data

- <https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools>
- <https://marketplace.visualstudio.com/items?itemName=RandomFractalsInc.vscode-data-preview>
- <https://marketplace.visualstudio.com/items?itemName=RandomFractalsInc.geo-data-viewer>
- <https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv>

### Bash

- <https://marketplace.visualstudio.com/items?itemName=mads-hartmann.bash-ide-vscode>

## Plugins - Team-SWEng

### API (rest) development

- <https://marketplace.visualstudio.com/items?itemName=humao.rest-client>

### Web App development

- <https://marketplace.visualstudio.com/items?itemName=iceworks-team.iceworks>

### YAML

- <https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml>

### Rust

- <https://marketplace.visualstudio.com/items?itemName=rust-lang.rust>

### C/C++

- <https://ludwiguer.medium.com/configure-visual-studio-code-to-compile-and-run-c-c-3cef24b4f690>
- <https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-extension-pack0>
- <https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner>

#### Arduino/Seeduino

 -_<https://marketplace.visualstudio.com/items?itemName=vsciot-vscode.vscode-arduino>

#### CUDA

TBD. Pull requests welcome.

### Java

- <https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack>

### PHP

- <https://github.com/cytopia/devilbox/blob/50ab236ea9780e6c3ba35d357a451d48aba9a5d2/docs/intermediate/configure-php-xdebug/linux/vscode.rst>

### Python

- <https://marketplace.visualstudio.com/items?itemName=ms-python.python>

## Plugins - Team-MechEng

### Octave

TBD. Pull requests welcome.

### R

TBD. Pull requests welcome.

### Jupyter

- <https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter>

### STL

- <https://marketplace.visualstudio.com/items?itemName=xdan.stlint-vscode-plugin>
- <https://marketplace.visualstudio.com/items?itemName=md2perpe.vscode-3dviewer>
- <https://marketplace.visualstudio.com/items?itemName=slevesque.vscode-3dviewer>

### G-code

TBD. Pull requests welcome.

### Gerber

TBD. Pull requests welcome.
