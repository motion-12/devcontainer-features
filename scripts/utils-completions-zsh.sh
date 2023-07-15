#compdef utils
compdef _utils_add_zsh_completion utils

#compdef utils
# Define the completion function
function _utils_add_zsh_completion () {
  # Set the directories to search for completions
  utils_dir="./shared"
  src_dir="./src"

  local lastParam lastChar flagPrefix requestComp out directive comp lastComp noSpace
  local -a completions

  _arguments \
    '1: :->command' \
    '2: :->util' \
    '3: :->feature' \
    '*:: :->args'

  words=("${=words[1,CURRENT]}")
  lastParam=${words[-1]}
  lastChar=${lastParam[-1]}

  # echo "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

  case $state in
    (command)
      local commands=('add: Add a utility script to a feature' 'remove: Remove a utility script from a feature' 'sync: Copy the utility scripts into the features' 'completions: Print the completions for the add command')
      _describe 'command' commands
      ;;
    (util)
      if [ "${words[2]}" = "add" ]; then
        local util_names=($(ls $utils_dir | sed 's/\.sh$//'))
        _describe 'util name' util_names
      elif [ "${words[2]}" = "remove" ]; then
        local util_names=($(ls $utils_dir | sed 's/\.sh$//'))
        _describe 'util name' util_names
      fi
      ;;
    (feature)
      if [ "${words[2]}" = "add" ]; then
        local util_names=($(ls $src_dir))
        _describe 'util name' util_names
      elif [ "${words[2]}" = "remove" ]; then
        local util_names=($(ls $src_dir))
        _describe 'util name' util_names
      fi
      ;;
    (args)
      # No completions for arguments
      ;;
  esac
}

