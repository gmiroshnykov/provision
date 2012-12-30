#!/usr/bin/env bash
vagrant ssh -c 'sudo dd if=/dev/zero of=/EMPTY bs=1M'
vagrant ssh -c 'sudo rm -f /EMPTY'
vagrant package
