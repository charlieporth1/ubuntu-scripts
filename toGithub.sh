

cd /mnt/HDD/Programs

if [[ `git status --porcelain` ]]; then
  # Changes
echo changes
git add .
git commit -m date
git rm --cached -r .git
git rm --cached email-virus-report.sh

git push | parallel -j128 -Jcluster

else
echo no changes
  # No changes
fi
