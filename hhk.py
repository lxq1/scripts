#!/usr/bin/env python

import sys, os

def hhk_switch(options, args):
    xmodmap_default = '/etc/xdg/xfce4/xmodmaprc'
    xmodmap_hhkprojp = '$SCRIPTS/dot_files/dot_xmodmaprc_hhkprojp'
    xmodmap_hhklite2 = '$SCRIPTS/dot_files/dot_xmodmaprc_hhklite2'
    xmodmap_uskeymap = '$SCRIPTS/dot_files/dot_xmodmaprc_uskeyboard'
    xmodmap_original = '$SCRIPTS/dot_files/dot_xmodmaprc'

    if len(args) == 1:
        if args[0] == 'projp':
            syscmd = 'xmodmap %s' % xmodmap_hhkprojp
        elif args[0] == 'lite2':
            syscmd = 'xmodmap %s' % xmodmap_hhklite2
        elif args[0] == 'us':
            syscmd = 'xmodmap %s' % xmodmap_uskeymap
        else:
            syscmd = 'xmodmap %s' % xmodmap_original
    else:
        syscmd = 'xmodmap %s' % xmodmap_default

    os.system(syscmd)

def main():
    from optparse import OptionParser
    usage = "usage: %prog [off]"
    parser = OptionParser(usage)
    (options, args) = parser.parse_args()
    hhk_switch(options, args)

if __name__ == "__main__":
    main()

