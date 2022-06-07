#!/usr/bin/env python3

import sys
from imppkg.harmonic_mean import harmonic_mean


def main():
    arg_list = []
    for arg in sys.argv[1:]:
        arg_list.append(float(arg))
    print(harmonic_mean(arg_list))


if __name__ == "__main__":
    main()
