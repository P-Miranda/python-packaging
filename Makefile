VENV=.venv

all:
	@echo "Default Make target! (does nothing currently)"

# Only create venv if it does not exist already
create-venv:
	@if [ ! -d "$(VENV)" ]; then python3 -m venv $(VENV); fi

# Run build frontend
build: build-clean
	pyproject-build

# Clean build artifacts
build-clean:
	@rm -rf dist *.egg-info
