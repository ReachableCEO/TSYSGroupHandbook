# TSYS Group - IT Documentation - R&D - Workstation Build Guide

- [TSYS Group - IT Documentation - R&D - Workstation Build Guide](#tsys-group---it-documentation---rd---workstation-build-guide)
  - [Introduction](#introduction)
  - [Workstation details - RPI4 8Gb](#workstation-details---rpi4-8gb)
    - [Out of box tweaks and basic setup](#out-of-box-tweaks-and-basic-setup)
    - [Software Packages To Install](#software-packages-to-install)
      - [magic mouse 2 driver](#magic-mouse-2-driver)
      - [Nodejs](#nodejs)
      - [Rust](#rust)
      - [go](#go)
      - [mdbook](#mdbook)
      - [Recoll (local search)](#recoll-local-search)
      - [Bitwarden CLI](#bitwarden-cli)
      - [Krita](#krita)
      - [Backslide](#backslide)
      - [Docker](#docker)
      - [RedNotebook (install from source, it just runs in place)](#rednotebook-install-from-source-it-just-runs-in-place)
      - [OpenWebRx](#openwebrx)
      - [csv2md](#csv2md)
      - [helm](#helm)
      - [kubectl / k3s](#kubectl--k3s)
      - [docker](#docker-1)
      - [docker-compose](#docker-compose)
      - [metasploit](#metasploit)
      - [scap workbench](#scap-workbench)
      - [Bitscope](#bitscope)
      - [docker based dev environment/pipeline](#docker-based-dev-environmentpipeline)
      - [Mainline repo packages](#mainline-repo-packages)
    - [Configuration Tweaks](#configuration-tweaks)
      - [chrome setup](#chrome-setup)
      - [passwords/bitwarden](#passwordsbitwarden)
      - [web apps](#web-apps)
      - [zsh](#zsh)
      - [konsole setup](#konsole-setup)
      - [xfce tweaks](#xfce-tweaks)
      - [VsCode](#vscode)
    - [CTO Stuff](#cto-stuff)
      - [Upstream vendor software to checkout](#upstream-vendor-software-to-checkout)
        - [Projects](#projects)
        - [Special considerations for upstream](#special-considerations-for-upstream)
  - [Workstation details - x86-64 vm](#workstation-details---x86-64-vm)
  - [Workstation details - iPAD](#workstation-details---ipad)
    - [Remaining projects](#remaining-projects)
      - [SSH / GPT private key HSM](#ssh--gpt-private-key-hsm)
      - [TurboVNC (3d accelerated) on rpi as client](#turbovnc-3d-accelerated-on-rpi-as-client)
      - [Select an Investigative notebook](#select-an-investigative-notebook)
      - [Research source material organization](#research-source-material-organization)
      - [activitywatch](#activitywatch)
      - [Get photo processing workflow setup](#get-photo-processing-workflow-setup)
      - [switch mail from (just) thunderbird to thunderbird/(neo)mutt/notmuch/task warrior](#switch-mail-from-just-thunderbird-to-thunderbirdneomuttnotmuchtask-warrior)

## Introduction

In 01/2021 , Charles purchased a Raspberry Pi 4 as his daily driver with the intent of evaluating it for use as the standard issue equipment for TSYS personnel. This document is the results of his 
experiments with it from 01/2021 to (as of time of writing) August 1st 2021. 

Charles is the founder, CEO and acting CTO of TSYS Group. In his role, he does everything from business ops, to system administration to software/hardware engineering tasks. As such he was best 
positioned to evaluate the rPI for all workloads.

The RPi4 has been approved as one of the standard/supported workstation for TSYS personnel across all teams/products.

The software mentioned in this document is a long list, reflecting the myriad of tasks/projects Charles may engage with on a daily basis.  Most likely, you'll only need a subset of these tools, 
don't despair! Feel free to install all of them or a subset as you wish based on your mission objectives.

We hope this document is useful to everyone at TSYS who wants to maximize their productivity. TSYS fully supports Debian/Ubuntu GNU Linux for workstation use, both on rPI4 and x86 virtual/physical 
systems. 

We do occasionally test Mac OSX and Windows 10, but they aren't officially supported.  

Our experiments and daily use show that 85% or more of TSYS daily driver/workstation use (email/coding/research/browsing/document creation/discord/media editing/etc) can be done on an rPI4. 

The few gaps can be done via an RDP session to an x86 system for the few things that have x86 dependencies or need 64bit os (64bit on pi isn't yet fully ready in our opinion as of August 2021).

## Charles Workstation details - RPI4 8Gb

- Operating System: RaspberryPi Os
- Hardware:
  - Raspberry Pi 4 with 8gb RAM
  - Accessories :
    - Case : Argone One case <https://www.argon40.com/argon-one-m-2-case-for-raspberry-pi-4.html>
    - Monitors: Dual Dell 24" monitors (IPS) <https://www.dell.com/support/home/en-us/product-support/product/dell-st2421l/overview>0
    - Chair: Ikea MARKUS Office Chair: <https://www.ikea.com/us/en/p/markus-office-chair-vissle-dark-gray-90289172/>
    - Keyboard: Matias Backlight Keyboard <https://www.matias.ca/aluminum/backlit/>
    - Mouse: Apple Magic Mouse 2 Black
    - Tablet: iPad Mini 5th Gen (see iPAD section for more)
    - Headphones: JBL Over Ear (<https://www.jbl.com.au/TUNE750BTNC.html>)
    - Tp-link 7 port USB 3.0 Powered Hub (for plugging in thumb drives, data acquisition devices / other random usb bits) <https://www.tp-link.com/us/home-networking/usb-hub/uh700/>
    - IOGear card reader <https://www.iogear.com/product/GFR281/>
    - Security Dongle: Yubikey 4 OTP+U2F+CCID

### Out of box tweaks and basic setup

1) Put Rasberry Pi 4 into Argone One Case (running it without case will cause it to overheat quickly)
2) Flash latest stable Raspbian 32bit to SD card and boot pi
3) connect usb keyboard and mouse
4) Run through first boot setup wizard
5) Setup pin+yubi long string for password for the pi user
6) Connect to wifi
5) Pair and trust Matias Backlight Keyboard
6) Pair and trust Apple Magic Mouse
7) fix date/time via ntpdate (ntpdate 10.251.37.5)
8) apt-get update ; apt-get -y full-upgrade
9) add vi mode to /etc/profile (heathens by default!)
10) clone dotfiles repo
11) enable i2c access via raspi-config
12) setup fan daemon <https://gitlab.com/DarkElvenAngel/argononed.git>
13) setup virtual desktops

- Desktop 1: Browsing/Editing/Shell (chrome / VsCode / Konsole / Remmina )
- Desktop 2: Comms (discourse/discord/irc etc/thunderbird/mutt)
- Desktop 3: Long Running: (calibre/recol/etc)

14) (coming soon) run curl htp://dl.turnsys.net/buildFullWorkstation.sh

### Software Packages To Install

#### magic mouse 2 driver

https://github.com/rohitpid/Linux-Magic-Trackpad-2-Driver 

#### Nodejs

```console
curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sud apt-get -y install nodejs
sudo apt-get update && sudo apt-get install yarn
```

#### Rust

```console
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

#### go

<https://pimylifeup.com/raspberry-pi-golang/>

#### mdbook

```console
cargo install mdbook
```

#### Recoll (local search)

```console
cat recoll-rbuster.list 
deb [signed-by=/usr/share/keyrings/lesbonscomptes.gpg] http://www.lesbonscomptes.com/recoll/raspbian/ buster main
deb-src [signed-by=/usr/share/keyrings/lesbonscomptes.gpg] http://www.lesbonscomptes.com/recoll/raspbian/ buster main
```

#### Bitwarden CLI

```console
sudo npm install -g @bitwarden/cli
```

#### Krita

```console
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak -y install flathub org.kde.krita
```

#### Backslide

```console
sudo npm install -g backslide
sudo npm i -g decktape
sudo add chrome-aws-lambda
```

#### RedNotebook (install from source, it just runs in place)

<https://rednotebook.sourceforge.io/downloads.html>
<https://www.linuxlinks.com/raspberry-pi-4-chronicling-desktop-experience-dear-diary/>

#### OpenWebRx

on pi:

wget -O - <https://repo.openwebrx.de/debian/key.gpg.txt> | apt-key add
echo "deb <https://repo.openwebrx.de/debian/> buster main" > /etc/apt/sources.list.d/openwebrx.list
apt-get update
apt-get install openwebrx

or (on x86)

wget -O - https://repo.openwebrx.de/debian/key.gpg.txt | apt-key add
echo "deb https://repo.openwebrx.de/ubuntu/ hirsute main" > /etc/apt/sources.list.d/openwebrx.list
apt-get update
apt-get install openwebrx

#### csv2md

```console
npm install -g csv2md
```

#### metasploit

```console
git clone https://github.com/rapid7/metasploit-framework.git
cd metasploit-framework
sudo gem install wirble sqlite3 bundler nokogiri bundle
bundle install
```

#### scap workbench

Follow the readme

#### Bitscope

on pi

```console
wget http://bitscope.com/download/files/bitscope-dso_2.8.FE22H_armhf.deb
wget http://bitscope.com/download/files/bitscope-logic_1.2.FC20C_armhf.deb
wget http://bitscope.com/download/files/bitscope-meter_2.0.FK22G_armhf.deb
wget http://bitscope.com/download/files/bitscope-chart_2.0.FK22M_armhf.deb
wget http://bitscope.com/download/files/bitscope-proto_0.9.FG13B_armhf.deb
wget http://bitscope.com/download/files/bitscope-console_1.0.FK29A_armhf.deb
wget http://bitscope.com/download/files/bitscope-display_1.0.EC17A_armhf.deb
wget http://bitscope.com/download/files/bitscope-server_1.0.FK26A_armhf.deb

sudo dpkg -i *.deb
sudo apt-get -y -f install

```

on x86

TBD

#### docker based dev environment/pipeline

##### docker

```console
curl -sSL https://get.docker.com | sh
```

##### helm


```console
sudo snap install helm --classic
```

##### kubectl / k3s

```console
    curl -sfL https://get.k3s.io | sh -
```

##### docker-compose

##### Todo

- local k0s (for gitops testing)
- (container) local docker reg
- (container) local jenkins
- (container) local all the apps for developing

#### Mainline repo packages

```console
apt-get -y install \
kicad librecad freecad gimp blender shellcheck jq net-tools\
ruby-full offlineimap zsh vim thunderbird enigmail highlight\
kleopatra zsh-autosuggestions zsh-syntax-highlighting screen \
mtr cifs-utils grass cubicsdr arduino jupyter-notebook \
dia basket vym code wings3d flatpak wireguard gnuplot \
pandoc python3-blockdiag  texlive-fonts-extra clang \
spice-client-gtk spice-html5 virt-viewer gnome-system-monitor \
glances htop dstat apt-file kleopatra konsole telnet clang \
ripgrep recoll poppler-utils  abiword wv antiword  unrtf  \
libimage-exiftool-perl xsltproc davmail kphotoalbum opensc \
yubikey-manager yubikey-personalization yubikey-personalization-gui \
openshot kdenlive pitivi inkscape scribus scdaemon seafile-gui qgis \
octave nodejs libreoffice calligra netbeans sigrok \
nodejs audacity wireshark nmap tcpdump ndiff etherape ghostscript \
lepton-eda ngspice graphicsmagick codeblocks scilab calibre paraview \
gnuradio build-essential libimobiledevice-utils libimobiledevice-dev \
libgpod-dev python3-numpy python3-pandas python3-matplotlib \
curl git make binutils bison gcc build-essential openjdk-11-jre-headless \
debootstrap cutecom minicom ser2net conman xsane gocr  tesseract-ocr \
fonts-powerline build-essential zlib1g zlib1g-dev libxml2 libxml2-dev \
libxslt-dev locate libreadline6-dev libcurl4-openssl-dev git-core libssl-dev \
libyaml-dev openssl autoconf libtool ncurses-dev bison curl wget postgresql \
postgresql-contrib libpq-dev libapr1 libaprutil1 libsvn1 libpcap-dev ruby-dev \
openvas git-core postgresql curl nmap gem libsqlite3-dev cmake ninja-build libopenscap-dev \
qt5-default libqt5widgets5 libqt5widgets5 libqwt-headers libqt5xmlpatterns5-dev asciidoc \
lmms virt-manager gqrx-sdr multimon-ng rtl-sdr fldigi grads cdo xygrib xygrib-maps evince \
openwebrx xscreensaver blueman bluetooth pulseaudio-module-bluetooth blueman texlive-fonts-extra \
texlive-fonts-recommended 
```

### Configuration Tweaks


#### zsh

- Use oh-my-zsh
- Use powerlevel10k

#### konsole setup

- settings -> edit current profile ->
  - apperance (set to dark pastels)
  - font (set to noto mono)
  - mouse  
    - copy/paste
      - copy on select
      - paste from clipboard (default is paste from selection)
      - un-set copy text as html

- settings - configure shortcuts
  - next tab ctrl+tab
  - previous ctrl+shift+tab

#### xfce tweaks

- Set focus follows mouse (settings/window manager/focus)
- (dark mode)? (only works for gtk apps)
- need to set other apps individually to dark mode

#### VsCode

fenix appears to include it in the default image, but it doesn't launch from the menu and shell says code not found. Search for code and it will pull up an entry with VsCode logo labeled as Text Editor. Use that.

to see how I set it up VsCode for a myriad of tasks, see the VsCode guide for tsys at:

<https://git.turnsys.com/TSGTechops/docs-techops/src/branch/master/src/Systems/Admin-RandD/TSYS-DevEnv-VsCode.md>



### CTO Stuff

#### mbed studio
#### eclipse
#### android studio
#### dbeaver
#### postman
#### sweethome3d
#### ghidra

#### Upstream vendor software to checkout

This is a massive work in progress , is mostly for Charles own notes only, really only applicable for large upstream packages that TSYS needs to support 
long term/sync regularly with upstream, or part of a broader protfolio initiative etc.

Unless you have been specfically directed todo so in your roject readme, you don't need todo the below. In almost all cases , the work below is abstracted
for/from you into our artifact repository and build process.

##### Projects

- openwrt
- openmct
- raspi kernel
- FreeRTOS
- freedombox
- serval
- genode
- balena

##### Special considerations for upstream


## Workstation details - iPAD

- Operating System: iPAD OS
- Hardware: iPAD Mini 5th Generation
- Accessories:
  - Lightining to USB3
  - Lightining to HDMI
  - I use same KB/Mouse that I do with the rPI
- Key Applications
  - Working Copy
  - Buffer Text Editor
  - Blink.sh
  - Jump remote Desktop
  - GitJournal
  - Microsoft Todo
  - Neat
  - Discourse
  - FreeScout
  - ErpNext

### Remaining projects

These items remain todo and document. They are listed in decreasing order of importance.


#### SSH / GPT private key HSM

- kleopatra
  - yubikey ssh key
  - yubikey gpg key

  (not strictly related but in same family)
  - xca (build from source)

#### TurboVNC (3d accelerated) on rpi as client

#### Select an Investigative notebook

- <https://github.com/kpcyrd/sn0int>
- <https://www.spiderfoot.net/>
- <https://github.com/smicallef/spiderfoot?ref=d>
- modelio <https://www.modelio.org/>
- <https://gephi.org/>

#### Research source material organization

- zotero
- docear <https://opensource.com/life/16/8/organize-your-scholarly-research-docear>

#### activitywatch

Effortless self instrumentation. Performed initial attempts/exploration. It builds (I think)

#### Get photo processing workflow setup

- currently exploring kphotoablbum  
- Browser based Sharing / browsing via Photoprism (or perhaps piwgio ultimately, with photoprism as part of a processing work flow)?
- need something to sync to "cloud" with auto capture from phone
- reference material:
  - <https://photoprism.app/>
  - <https://kn100.me/declouding-replacing-google-photos-part-1/>
  - <https://willem.com/blog/2020-08-31_free-from-the-icloud-escaping-apple-photos/>

#### switch mail from (just) thunderbird to thunderbird/(neo)mutt/notmuch/task warrior

This has been an ongoing on-again/off-again adventure....
