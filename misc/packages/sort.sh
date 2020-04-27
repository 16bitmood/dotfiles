#!/bin/bash
reflector --latest 50 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist