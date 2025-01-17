#!/bin/env bash

STARSHIP_VERSION=${STARSHIP_VERSION:-"latest"};
STARSHIP_CONFIG_DIR="${FILES_USER_CONFIG}/starship";

if ! [[ -f "$(which starship 2>&1)" ]] && [[ -d "${HOME}/.asdf" ]]; then
    asdf plugin add starship;
    asdf install starship ${STARSHIP_VERSION};
    asdf local starship ${STARSHIP_VERSION};
fi

if [[ -f "$(which starship 2>&1)" ]]; then
	export STARSHIP_CACHE="${STARSHIP_CONFIG_DIR}/cache";
	export STARSHIP_CONFIG="${STARSHIP_CONFIG_DIR}/starship.toml";

	files_debug_log "[starship] installing default config";
       [[ -f "${STARSHIP_CONFIG}" ]] || ln -sf  "${FILES_PLUGIN_ROOT}/defaults.d/starship.toml" ${STARSHIP_CONFIG};

	starship_run() {
		local shell=${1:-bash};
		eval "$(starship init ${1} --print-full-init)";
		export PROMPT_COMMAND='PS1=$(starship prompt)';
	}

	starship_install() {
		local target=${1};
		local shell=${2:-bash};

		if [[ -f "${target}" ]] && [[ -z "$(cat ${target} | grep 'starship_run')" ]]; then
			echo "starship_run ${shell}" >> ${target};
		fi
	}

    starship_set_window_title(){
        echo -ne "\033]0; $(basename "$PWD") \007"
    }

    starship_precmd_user_func="starship_set_window_title"

	[[ -f "${HOME}/.bashrc" ]] && starship_install "${HOME}/.bashrc";
	[[ -f "${HOME}/.bash_profile" ]] && starship_install "${HOME}/.bash_profile";
	[[ -f "${HOME}/.profile" ]] && starship_install "${HOME}/.profile";
fi
