deploy: setup clone build

build:
    uv run mkdocs build -d public

serve: setup clone
    uv run mkdocs serve

clean:
    rm -rf planung public Wiki .venv

# Serve a local version of the wiki
# Expects the path to your local `Wiki` folder as an argument
local_serve *args:
    rm -rf Wiki
    cp -r {{ args }} ./
    uv run mkdocs serve

clone repo="planung":
    #!/bin/bash
    set -euo pipefail

    # Clone the folder or pull if it already exists.
    if [[ ! -d "{{ repo }}" ]]; then
        echo "Cloning repository"
        git clone --quiet git@github.com:Tiefgang/{{ repo }}.git
    else
        cd {{ repo }}
        git reset --quiet --hard
        git pull --quiet
        cd ..
    fi

    # Remove old files
    rm -rf Wiki

    # Copy wiki files to local folder
    cp -r {{ repo }}/Wiki ./

# Create virtual python env to install mkdocs + material theme.
# This command updates the packages on a second run.
setup:
    #!/bin/bash
    set -euo pipefail
    echo "Installing dependencies"
    uv sync
