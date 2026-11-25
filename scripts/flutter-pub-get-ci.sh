#!/usr/bin/env bash
# Authenticate only Git requests to the private Flutter design-system repository.
set -euo pipefail

if [[ -z "${DESIGN_SYSTEM_READ_TOKEN:-}" ]]; then
  echo "::error::Flutter dependency access requires the DESIGN_SYSTEM_READ_TOKEN secret on a trusted Kyron build."
  echo "For a fork contribution, review the changes and run Flutter CI from a KyronLabs/kyron branch."
  exit 1
fi

# GitHub HTTPS Basic authentication uses the token as the password. Mask
# the derived header before invoking Git. Keep it out of persistent config.
authorization=$(printf '%s' "x-access-token:$DESIGN_SYSTEM_READ_TOKEN" | base64 -w0)
printf '::add-mask::%s\n' "$authorization"
unset DESIGN_SYSTEM_READ_TOKEN

# URL-scoping keeps the header off unrelated GitHub repositories and hosts.
GIT_CONFIG_COUNT=1 \
GIT_CONFIG_KEY_0='http.https://github.com/KyronLabs/design-system.git.extraheader' \
GIT_CONFIG_VALUE_0="Authorization: Basic $authorization" \
flutter pub get
