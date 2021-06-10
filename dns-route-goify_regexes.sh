#!/bin/bash
echo "Filtering"
perl -pe " s/(\.)?$/./ " $R_LIST/black/domains.txt | perl -pe " s/^(\.)?/./ " | sudo tee /tmp/b_domains.txt.tmp
perl -pe " s/(\.)?$/./ " $R_LIST/white/domains.txt | perl -pe " s/^(\.)?/./ " | sudo tee /tmp/w_domains.txt.tmp
#perl -pe " s/(\$)?$/.\$/ " $R_LIST/black/regex.txt > $R_LIST/black/regex.txt.tmp
echo "Moving files over"
mv /tmp/b_domains.txt.tmp $R_LIST/black/domains.txt
mv /tmp/w_domains.txt.tmp $R_LIST/white/domains.txt
#mv $R_LIST/black/regex.txt.tmp $R_LIST/black/regex.txt
echo done 
