# ODROID Arch Linux Supplement

## Prerequisites

A working Arch Linux ARM installation on an ODROID device. See the official Arch
Linux ARM website for installation instructions specific to your ODROID model:
<https://archlinuxarm.org/platforms/odroid>

I use an ODROID N2+. See the Arch Linux ARM page for the ODROID N2+ here:
<https://archlinuxarm.org/platforms/armv8/odroid-n2>

## Installation Instructions

1. Login as root and run the following commands:

```bash
pacman -S git sudo
```

1. Login as your main user and run the following command to clone and run the
   script :

```bash
git clone https://github.com/MacMannes/odroid-arch-supplement.git && \
cd odroid-arch-supplement && \
./run.sh
```
