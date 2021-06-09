#!/bin/bash
echo "Filtering"
cat  $R_LIST/black/domains.txt |  perl -pe " s/(.)?$/./ " | perl -pe " s/^(.)?/./ " > $R_LIST/black/domains.txt.tmp
cat  $R_LIST/white/domains.txt |  perl -pe " s/(.)?$/./ " | perl -pe " s/^(.)?/./ " > $R_LIST/white/domains.txt.tmp
cat  $R_LIST/black/regex.txt |  perl -pe " s/(.)?$/./ " > $R_LIST/black/regex.txt.tmp
echo "Moving files over"
mv $R_LIST/black/domains.txt.tmp > $R_LIST/black/domains.txt
mv $R_LIST/white/domains.txt.tmp $R_LIST/white/domains.txt
mv $R_LIST/black/regex.txt.tmp $R_LIST/black/regex.txt
echo done 
