#!/bin/bash

export SDL_VIDEO_X11_DGAMOUSE=0
qemu -fda /home/neil/code/uw/cs452/public/tools/share/bochs/grub.img -hda fat:${HOME}/code/uw/cs452-tracking/kernel -boot a -serial null -serial stdio
