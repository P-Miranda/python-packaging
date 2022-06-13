import sys
import pytest
from termcolor import colored
from imppkg.harmony import main


@pytest.mark.parametrize(
    "inputs, expected",
    [
        (["3", "3", "3"], 3.0),
        ([], 0.0),
        (["foo", "bar"], 0.0),
    ],
)
def test_harmony_parametrized(inputs, monkeypatch, capsys, expected):
    monkeypatch.setattr(sys, "argv", ["harmony"] + inputs)
    main()
    assert capsys.readouterr().out.strip() == colored(expected, "red", "on_cyan", attrs=["bold"])


def test_len():
    fruits = ["apple"]
    assert len(fruits) == 1


def test_append():
    fruits = ["apple"]
    fruits.append("banana")
    assert fruits == ["apple", "banana"]
