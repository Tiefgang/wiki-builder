build: setup clone
    #!/bin/bash
    set -euo pipefail

    source .venv/bin/activate
    mkdocs build

serve: setup clone
    #!/bin/bash
    set -euo pipefail

    source .venv/bin/activate
    mkdocs serve

# Serve a local version of the wiki
# Expects the path to the `Orga/Wiki` folder as an argument
local_serve *args:
    #!/bin/bash
    set -euo pipefail

    rm -r Wiki
    cp -r {{ args }} ./

    source .venv/bin/activate
    mkdocs serve

clone:
    #!/bin/bash
    set -euo pipefail

    # Clone the orga folder or pull if it already exists.
    if [[ ! -d "Orga" ]]; then
        echo "Cloning repository"
        git clone --quiet git@github.com:Tiefgang/Orga.git
    else
        cd Orga
        git reset --quiet --hard
        git pull --quiet
        cd ..
    fi

    # Remove old files
    rm -rf Wiki

    # Copy wiki files to local folder
    cp -r Orga/Wiki ./

# Create virtual python env to install mkdocs + material theme.
# This command updates the packages on a second run.
setup:
    #!/bin/bash
    set -euo pipefail

    if [[ ! -d ".venv" ]]; then
        echo "Setting up virtual environment"
        python3 -m venv .venv
    fi

    source .venv/bin/activate

    echo "Installing dependencies"
    pip install \
        --upgrade \
        --quiet \
        --requirement ./requirements.txt
