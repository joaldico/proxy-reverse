#!/usr/bin/env bash
# Instala un GitHub Actions runner en esta máquina.
# Etiquetas por defecto: self-hosted, Linux, X64
#
# Uso (en la EC2):
#   export RUNNER_URL="https://github.com/joaldico"   # o una org
#   export RUNNER_TOKEN="..."                         # Settings → Actions → Runners → New
#   export RUNNER_NAME="ec2-prod"
#   ./scripts/install-runner.sh
set -euo pipefail

RUNNER_VERSION="${RUNNER_VERSION:-2.323.0}"
RUNNER_DIR="${RUNNER_DIR:-$HOME/actions-runner}"
RUNNER_URL="${RUNNER_URL:?Falta RUNNER_URL (https://github.com/ORG o /USER/REPO)}"
RUNNER_TOKEN="${RUNNER_TOKEN:?Falta RUNNER_TOKEN}"
RUNNER_NAME="${RUNNER_NAME:-ec2-prod}"
RUNNER_LABELS="${RUNNER_LABELS:-self-hosted,Linux,X64}"

mkdir -p "$RUNNER_DIR"
cd "$RUNNER_DIR"

if [[ ! -f ./config.sh ]]; then
  curl -fsSL -o actions-runner.tar.gz \
    "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"
  tar xzf actions-runner.tar.gz
  rm -f actions-runner.tar.gz
fi

./config.sh --unattended \
  --url "$RUNNER_URL" \
  --token "$RUNNER_TOKEN" \
  --name "$RUNNER_NAME" \
  --labels "$RUNNER_LABELS" \
  --work _work \
  --replace

sudo ./svc.sh install
sudo ./svc.sh start

echo "Runner ${RUNNER_NAME} registrado con labels: ${RUNNER_LABELS}"
