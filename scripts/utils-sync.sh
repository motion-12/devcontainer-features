#!/bin/bash

echo "Syncing utils..."

# Get features either from the arguments or from $(ls -d src/*)
if [ $# -eq 0 ]; then
  FEATURES=$(ls -d src/*)
else
  FEATURES="$@"

  # Loop over every word/feature and prepend src/ to the word if it doesn't already have it, and seperate each word with a new line
  for feature in $FEATURES; do
    if [[ ! $feature == src/* ]]; then
      FEATURES="${FEATURES/$feature/
src\/$feature}"
    fi
  done

fi

# Loop over all the features and copy the utils in the utils.txt to the feature
for feature in $FEATURES; do
  # If the feature doesn't exist, echo a warning
  if [ ! -d ${feature} ]; then
    echo -e "\033[31mWarning (${feature}/utils.txt): Feature \"${feature}\" does not exist\033[0m"
    continue
  fi

  if [ -f ${feature}/utils.txt ]; then
    while IFS= read -r util; do
      # If the util doesn't exist, echo a warning
      if [ ! -f shared/${util}.sh ]; then
        echo -e "\033[31mWarning (${feature}/utils.txt): Util \"${util}\" does not exist\033[0m"
        continue
      fi

      # Copy the util to the feature
      cp shared/${util}.sh ${feature}/${util}.sh
    done <${feature}/utils.txt
  fi
done
