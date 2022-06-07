#!/usr/bin/env python3

import sys
from imppkg.harmonic_mean import harmonic_mean
from termcolor import cprint


def main():
    arg_list = []
    for arg in sys.argv[1:]:
        arg_list.append(float(arg))
    cprint(harmonic_mean(arg_list), 'green', 'on_cyan', attrs=['bold'])


if __name__ == "__main__":
    main()
