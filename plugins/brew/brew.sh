#!/bin/env bash

export LINUX_BREW_PATH="/home/linuxbrew/.linuxbrew";
export MAC_BREW_PATH="/usr/local/Homebrew";

if  [[ ! -d "${LINUX_BREW_PATH}" && ! -d "${MAC_BREW_PATH}" ]]; then
	echo "Installing brew";
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/brew_install.sh;
	chmod +x /tmp/brew_install.sh;
	/tmp/brew_install.sh;
	rm -rf /tmp/brew_install.sh;
fi

[[ -f "${LINUX_BREW_PATH}/bin/brew" ]] && eval "$(${LINUX_BREW_PATH}/bin/brew shellenv)";
[[ -f "${MAC_BREW_PATH}/bin/brew" ]] && eval "$(${MAC_BREW_PATH}/bin/brew shellenv)";

[[ -d "$(brew --prefix)/etc/bash_completion.d" ]] || brew install bash-completion@2
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
