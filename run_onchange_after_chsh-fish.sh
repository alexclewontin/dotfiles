#!/bin/bash

fish="$(command -v fish)" || exit 0

# Homebrew does not register fish in /etc/shells, and chsh refuses shells that
# are not listed there.
grep -qxF "$fish" /etc/shells || echo "$fish" | sudo tee -a /etc/shells >/dev/null

# ponytail: $SHELL is the login shell as of session start, close enough since
# chezmoi only reruns this script when its contents change.
[ "$SHELL" = "$fish" ] || chsh -s "$fish"
