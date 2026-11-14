# Olive powerline: user@host | dir | git
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  typeset -g POWERLEVEL9K_MODE=nerdfont-complete
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs)
  typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=false
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

  # стрелки
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\uE0B0'
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=$'\uE0B1'
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\uE0B2'
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=$'\uE0B3'
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=$'\uE0B0'
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_END_SEPARATOR=' '
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=$'\uE0B2'

  # user@host: тёмный сегмент
  typeset -g POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'
  typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND='#161d1c'
  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND='#dde4e2'
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND='#ffb4ab'
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND='#161d1c'

  # директория: сине-бирюзовый сегмент
  typeset -g POWERLEVEL9K_DIR_BACKGROUND='#b9a9e8'
  typeset -g POWERLEVEL9K_DIR_FOREGROUND='#161d1c'
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND='#161d1c'
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND='#161d1c'
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=false
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=

  # git: олив
  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND='#b0ccc8'
  typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='#afc9e7'
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='#afc9e7'
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND='#ffb4ab'
  typeset -g POWERLEVEL9K_VCS_LOADING_BACKGROUND='#899391'
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND='#161d1c'
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='#161d1c'
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='#161d1c'
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_FOREGROUND='#161d1c'
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND='#161d1c'

  # справа: ошибка, время, фоновые задачи
  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_ERROR=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND='#ffb4ab'
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND='#161d1c'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='#252b2a'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='#dde4e2'
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='#252b2a'
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='#b9a9e8'

  (( ! $+functions[p10k] )) || p10k reload
}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
