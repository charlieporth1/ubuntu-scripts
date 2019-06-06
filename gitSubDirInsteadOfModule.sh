#!/bin/bash

# Get a list of all the submodules
submodules=($(git config --file .gitmodules --get-regexp path | awk '{ print $2 }'))

# Loop over submodules and convert to regular files
for submodule in "${submodules[@]}"
do  
   echo "Removing $submodule"
   git rm --cached $submodule # Delete references to submodule HEAD
   rm -rf $submodule/.git* # Remove submodule .git references to prevent confusion from main repo
   git add $submodule # Add the left over files from the submodule to the main repo
   git commit -m "Converting submodule $submodule to regular files" # Commit the new regular files!
done

# Finally remove the submodule mapping
git rm.gitmodules
