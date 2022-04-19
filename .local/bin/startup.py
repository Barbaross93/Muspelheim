#!/bin/python

# Move the default ~/.python_history file

import atexit
import os
import readline

histfile = os.path.join(
    os.path.expanduser(os.environ["XDG_DATA_HOME"]), "python", "python_history"
)

try:
    readline.read_history_file(histfile)
    h_len = readline.get_current_history_length()
except FileNotFoundError:
    open(histfile, "wb").close()
    h_len = 0


def save(prev_h_len, histfile):
    new_h_len = readline.get_current_history_length()
    readline.set_history_length(1000)
    readline.append_history_file(new_h_len - prev_h_len, histfile)


atexit.register(save, h_len, histfile)
