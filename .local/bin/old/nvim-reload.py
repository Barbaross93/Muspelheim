#!/usr/bin/env python3
#
# theme-switcher
#
# (c) 2017 Daniel Jankowski


import os

from neovim import attach


def get_all_instances():
    instances = []

    # get the content of /tmp
    directory_content = os.listdir('/tmp')
    for directory in directory_content:
        # check if it contains directories starting with nvim
        if directory.startswith('nvim'):
            # check if the nvim directories contains a socket
            dc = os.listdir('/tmp/' + directory)
            if '0' in dc:
                instances.append('/tmp/' + directory + '/0')
    return instances


def reload(instance):
    # connect over the socker
    nvim = attach('socket', path=instance)

    # execute the reload command
    nvim.command('source ~/.config/nvim/init.vim')
    #nvim.command('AirlineTheme everforest')


def main():
    # search for neovim instances
    instances = get_all_instances()

    # connect to instances and reload them
    for instance in instances:
        reload(instance)
    pass


if __name__ == '__main__':
    main()
