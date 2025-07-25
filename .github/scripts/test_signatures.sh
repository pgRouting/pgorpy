#!/bin/bash

# This test checks that signatures within mayors
# Call from the root of the repository

DIR=$(git rev-parse --show-toplevel)/sql/sigs

pushd "${DIR}" > /dev/null || exit

# For bash, uses temporary files
mapfile -t SIGNATURES < <(git ls-files "*.sig" | perl -pe 's/(.*)--(.*)\.sig/$2/')

for s1 in "${SIGNATURES[@]}"
do
    for s2 in "${SIGNATURES[@]}"
    do
        # only comparing lower version with higher version
        if (( $(echo "$s1 >= $s2" | bc -l) )); then continue; fi

        mayor1=$(echo "$s1" | perl -pe 's/([0-9]+).*/$1/')
        mayor2=$(echo "$s2" | perl -pe 's/([0-9]+).*/$1/')

        # comparing within same mayors only
        if [ "$mayor1" != "$mayor2" ]; then continue; fi

        # ignoring any signature changes made on v0
        if [ "$mayor1" == 0 ]; then continue; fi

        missing+=$(comm -23 "pgorpy--$s1.sig" "pgorpy--$s2.sig")
    done
done

popd > /dev/null || exit

error=0

if [[ $missing ]]; then
  echo " ****************************************************"
  echo " *** Found removed signatures"
  echo " ****************************************************"
  echo "$missing"
  error=1
fi

exit $error
