#cat /var/www/view/otih-oith/*
cd /var/www/view/otih-oith

for html in  ls -R `find . -name '*.html' -print`;
do
  echo html $html
htmlwithout=${html#*/}
htmlwithout1=${htmlwithout%.html}

  echo htmlwithout1  $htmlwithout1

ln -s $html  $htmlwithout1
done
