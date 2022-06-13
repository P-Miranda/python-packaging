#!/usr/bin/env python3

import sys
from imppkg.harmonic_mean import harmonic_mean
from termcolor import colored


def _parse_nums(inputs: list[str]) -> list[float]:
    try:
        nums = [float(num) for num in inputs]
    except ValueError:
        nums = []
    return nums


def _calculate_results(nums: list[float]) -> float:
    result = 0.0
    try:
        result = harmonic_mean(nums)
    except ZeroDivisionError:
        pass
    return result


def _format_output(result: float) -> str:
    return colored(str(result), "red", "on_cyan", attrs=["bold"])


def main():

    nums = _parse_nums(sys.argv[1:])

    result = _calculate_results(nums)

    print(_format_output(result))
