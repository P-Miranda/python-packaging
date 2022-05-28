# Python Packaging
Example repository to test Python packaging workflow and other things related 
with Python projects.

## Sources
This project follows multiple sources, including:
- [Python Official Site](https://www.python.org/)
- [Python Packaging Authority](https://packaging.python.org/en/latest/)
- [Publishing Python
  Packages](https://www.manning.com/books/publishing-python-packages) book by
  Dane Hillard.
- [Jacob
  Kaplan-Moss](https://jacobian.org/2019/nov/11/python-environment-2020/) blog
  post.
- [Pierre Walch Sane Python
  Environment](https://pwal.ch/posts/2019-11-10-sane-python-environment-2020-part-1-isolation/)
  blog post series.

* * *
## Setup Environment

### Isolation Principle
The linux system comes with a default python version and installed packages.
You could use this version for your projects and scripts, *BUT* this can cause
issues:
Possibility 1: a system update comes along that updates the python version or
packages and breaks your projects. (rare and low impact)
Possibility 2: you install or update some packages that causes
incompatibilities with the system installation. (often(?) could happen anytime
you install a package, high impact: it could break your system)
Possibility 3: packages that you install for multiple projects start to enter
in conflict with each other (almost certain: if you work with python a lot;
high impact: your system could break, your projects won't work)

These examples are just a illustration to show why you should create isolation
between usages of python. At the very least between projects and system.

**Actionable recommendation:** don't install packages in the global system
python environment

### Tools

### Pyenv: Manage python versions
The isolation principle leads to the first tool:
[**pyenv**](https://github.com/pyenv/pyenv). Pyenv allows to manage multiple
python versions.

- Install pyenv dependencies
- Install pyenv
- Install the python versions that you need
    - at least (one of the) latest stable releases
- Set a pyenv versions as the global python versions used when running python
  in your system 

### pipx: run python applications in isolated environments

Python development can be enhanced with multiple python applications (note
applications, not packages). [Pipx](https://pypa.github.io/pipx/) installs
applications in an isolated environment and makes then avaliable from the shell.

- Install pipx
- Install the python applications that you need
    - eg: flake8, black, isort
- Install python build took: `pipx install build`

### Virtual Environments
This is the project level isolation. For each project, create a virtual
environment to isolate python packages.

You can use the default [venv](https://docs.python.org/3/library/venv.html) tool
to create a simple virtual environment:
```
python3 -m venv .venv --prompt venv-NAME
```
Activate virtual environment:
```
source /path/to/venv/bin/activate
```
Deactivate virtual environment:
```
deactivate
```

**NOTE:** if you want to run you python program as an executable:
`./my_python.py`, you should add the following line at the start of the file:
```python
#!/usr/bin/env python3
```
- see [this
  post](https://unix.stackexchange.com/questions/29608/why-is-it-better-to-use-usr-bin-env-name-instead-of-path-to-name-as-my/29620#29620)
  for more information

There are tools that facilitate the automatic activation of virtual
environments. I still haven't found one that I like, so I'm doing manual
activation for now.

The setup that I currenly use is a `bash` function that I added to my `~/.bashrc`:
```Bash
# Activate python virtual environment
# ve [no args]: try default venv paths
# ve [arg1]: source virtual environment in [arg1]
function ve() {
    default_venvs=(".venv" "venv" ".env" "env")
    if [ $# -eq 0 ]; then
        for vdir in "${default_venvs[@]}"; do
            if [ -d "$vdir" ]; then
                source $vdir/bin/activate
                return
            fi
        done
    elif [ "$1" = "custom" ]; then
        source path/to/custom/.venv/bin/activate
    else
        source $1/bin/activate
    fi
}
export -f ve
```
With this function you can run the command in the terminal: `ve [arg1]`.

Without arguments (command: `ve`), the function tries to activate a virtual
environment in a directory with standard name: [venv, .venv, env, .env].

With an argument it tries to check if it is a `custom` argument that activates
a specific virtual enviroment. Otherwise tries to use the argument as a path to
a virtual environment to activate.

### Build Backend
A build backend is a Python object that provides several required and optional
hooks that implement packaging behavior. The core build backend interface is
defined in [PEP
517](https://www.python.org/dev/peps/pep-0517/#build-backend-interface ).

Probably the most used build backend is
[Setuptools](https://setuptools.pypa.io/en/latest/index.html)

### Build Frontend
A build frontend is a tool you run to initiate building a package from source
code. The build frontend provides a user interface and integrates with the
build backend via the hook interface.

Build is a simple, correct [PEP 517](https://peps.python.org/pep-0517/) build
frontend.

- [Github repository](https://github.com/pypa/build)

- Install build using pipx: `pipx install flake8`

- Run build frontend: `pyproject-build`

### Other Build Tools
Other alternative build tools for python projects include:
- [Poetry](https://python-poetry.org/)
- [Flit](https://flit.pypa.io/en/latest/)

### Flake8 linter
Static linter that aggregates multiple python tools: pycodestyle, pyflakes,
mccabe, and third-party plugins to check the style and quality of some python
code. 

- [Github repository](https://github.com/PyCQA/flake8)

- Install flake8 using pipx: `pipx install flake8`

### Black formatter
The uncompromising Python code formatter. 
Simple configuration/defaults. Does not break code. Follows PEP-8!

- [Github repository](https://github.com/psf/black)

- Install black using pipx: `pipx install black`

