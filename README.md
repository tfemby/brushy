# Brushy - Desktop ebuild repo
This repo is primarily created to host ebuilds of packages I personally use.

If you have any issues with any ebuilds, feel free to open an issue. 

## Packages worthy of emerge
Most of the packages in this repo have been used by me and they seem to work
as intended. I've broken them down into general categories and my usecases for
each.

### Desktop
- app-editors/neovide
    - My neovim editor of choice.
- gui-apps/labwc-tweaks
- gui-apps/rofi-wayland
- x11-misc/rofi-emoji

### Perl
DBIx-Class is probably one of the better perl ORMs out there. Sadly the
main Gentoo tree only has some of the useful modules for it.
- dev-perl/DBD-Pg
    - This package currently in the main branch fails due to c23 changes.
- dev-perl/DBIx-Class-Schema-Loader
    - Generates perl code based on a DB's layout.
    - Most of the other dev-perl packages are dependencies for this.

### Python
Most of these packages are primarily used on my Raspberry Pi's.
- app-editors/thonny
- dev-lang/micropython
    - Used usually in conjuction with thonny. Allows me to dry-run
      code before flashing it onto a board.
- dev-python/RPi-GPIO
    - Old and barely works, still needed for gpiozero.
- dev-python/gpiozero
    - Currently supported by the Raspberry Pi team. Works with Pi 5.
    - colorzero, RPi-GPIO and spidev are dependencies.
- dev-python/mdns-publisher
    - Old and has been archived, need to find a replacement

### Raspberry Pi
- dev-embedded/rpi-eeprom

# Contributing
If you're inclined, give me some code to help improve a build 🙂 I can't
guarantee I'll add it for a variety of reasons.

Ebuilds in this repo follow the GPL-2 license. This is mostly because some
ebuilds are derivitives of already existing ebuilds from the gentoo repo or
the wayland-desktop repo. Contributing here means that you will need to accept
this license before submitting code.

