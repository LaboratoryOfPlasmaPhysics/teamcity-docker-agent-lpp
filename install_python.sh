#!/usr/bin/env bash
set -euo pipefail

curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

uv python install \
  3.10 3.11 3.12 \
  3.13 3.13t \
  3.14 3.14t \
  3.15 3.15t

uv python install 3.14 --default --preview-features python-install-default

uv pip install --python 3.14 --system --break-system-packages \
  git+https://github.com/LaboratoryOfPlasmaPhysics/teamcity_rest_client
