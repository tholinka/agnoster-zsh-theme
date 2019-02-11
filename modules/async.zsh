#!/usr/bin/env zsh

# async setup is entirely based off of alien, https://github.com/eendroroy/alien

### Segments of the full prompt, as done after async, in default order
typeset -aHg AGNOSTER_PROMPT_ASYNC_SEGMENTS=(
	prompt_status
	prompt_context
	prompt_virtualenv
	prompt_dir
	prompt_git
	prompt_end
)

function prompt_agnoster_async_dummy() {}

function prompt_agnoster_async_main() {
	RETVAL=$?
	CURRENT_BG='NONE'
	for prompt_segment in "${AGNOSTER_PROMPT_ASYNC_SEGMENTS[@]}"; do
		[[ -n $prompt_segment ]] && $prompt_segment
	done
}

function prompt_agnoster_lprompt_complete() {
	vcs_info

	PROMPT='%{%f%b%k%}`prompt_agnoster_async_main` '

	zle && zle reset-prompt
	async_stop_worker lprompt -n
}

function prompt_agnoster_async() {
	async_init
	async_start_worker lprompt -n
	async_register_callback lprompt prompt_agnoster_lprompt_complete
	async_job lprompt prompt_agnoster_async_dummy
}