VENV=.venv
PYTHON=$(VENV)/bin/python

all: build-clean build install-package harmony-cmd
	@echo "Default Make target!"

# Only create venv if it does not exist already
create-venv:
	@if [ ! -d "$(VENV)" ]; then python3 -m venv $(VENV); fi

# Run build frontend
build: build-clean
	pyproject-build

build-extract:
	mkdir -p extract
	tar -xzf dist/*.tar.gz -C extract
	unzip -l dist/*.whl

# Clean build artifacts
build-clean:
	@rm -rf dist src/*.egg-info extract

# Measure performance of harmonic mean
profile-hm:
	$(PYTHON) -m timeit \
		--setup 'from imppkg.harmonic_mean import harmonic_mean' \
		--setup 'from random import randint' \
		--setup 'nums = [randint(1, 1_000_000) for _ in range(1_000_000)]' \
		'harmonic_mean(nums)'

# Install current package
install-package:
	$(PYTHON) -m pip install .

# Run harmony command line tool
# also works without PATH when VENV is active: 
# 	harmony 0.65 0.7
harmony-cmd:
	$(VENV)/bin/harmony 0.65 0.7
	harmony 0.65 0.7

# Run tests
test:
	$(PYTHON) -m pytest 

# Run coverate
coverage:
	$(PYTHON) -m pytest --cov

# Tox coverage: multiple python versions
# tox -- {options}
# -p: run environments in parallel
tox-full:
	tox -p -e py39,py310,typecheck,format,lint

tox-test:
	tox -p -- --cov

tox-typecheck:
	tox -e typecheck

tox-format-check:
	tox -e format -- --check --diff src test

tox-format-run:
	tox -e format -- src test

tox-lint:
	tox -e lint -- src test

tox-clean:
	rm -rf .tox

clean-all: build-clean tox-clean
	rm -rf build
	rm -rf .coverage .pytest_cache __pycache__/ test/__pycache__/

.PHONY: clean-all build-clean \
	test coverage tox-coverage
