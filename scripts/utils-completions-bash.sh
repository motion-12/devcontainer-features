# Define the completion function
_utils_add_bash_completion() {
  local cur prev utils_dir src_dir

  # Get the current and previous words
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"

  # Set the directories to search for completions
  utils_dir="./shared"
  src_dir="./src"

  case ${COMP_CWORD} in
  1)
    COMPREPLY=($(compgen -W "add remove sync completions help" -- "$cur"))
    return 0
    ;;
  2)
    case ${prev} in
    add)
      COMPREPLY=($(compgen -W "$(ls $utils_dir | sed 's/\.sh$//')" -- "$cur"))
      return 0
      ;;
    remove)
      COMPREPLY=($(compgen -W "$(ls $utils_dir | sed 's/\.sh$//')" -- "$cur"))
      return 0
      ;;
    sync)
      COMPREPLY=($(compgen -W "$(ls $src_dir)" -- "$cur"))
      return 0
      ;;
    esac
    ;;
  3)
    if [[ ${COMP_WORDS[1]} == "add" ]]; then
      COMPREPLY=($(compgen -W "$(ls $src_dir)" -- "$cur"))
      return 0
    elif [[ ${COMP_WORDS[1]} == "remove" ]]; then
      COMPREPLY=($(compgen -W "$(ls $src_dir)" -- "$cur"))
      return 0
    fi
    ;;
  esac

  if [[ ${COMP_WORDS[1]} == "sync" ]]; then
    COMPREPLY=($(compgen -W "$(ls $src_dir)" -- "$cur"))
    return 0
  fi
}

# Register the completion function for the add subcommand
complete -F _utils_add_completion ./utils
