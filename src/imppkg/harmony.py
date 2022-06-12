#!/usr/bin/env python3

import sys
from imppkg.harmonic_mean import harmonic_mean
from termcolor import cprint


def main():
    result = 0.0

    try:
        nums = [float(num) for num in sys.argv[1:]]
    except ValueError:
        nums = []

    try:
        result = harmonic_mean(nums)
    except ZeroDivisionError:
        pass

    cprint(result, 'red', 'on_cyan', attrs=['bold'])
