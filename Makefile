VENV=.venv

all:
	@echo "Default Make target! (does nothing currently)"

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
	python -m timeit \
		--setup 'from harmonic_mean import harmonic_mean' \
		--setup 'from random import randint' \
		--setup 'nums = [randint(1, 1_000_000) for _ in range(1_000_000)]' \
		'harmonic_mean(nums)'
