touch "repo1/spamfile.txt"
echo "spam " >> "repo1/spamfile.txt"
git pull
git add .
git commit -m "fill bytes"
git push --force origin --all

touch "repo1/spamfile.txt"
echo "spam " >> "repo1/spamfile.txt"
git pull
git add .
git commit -m "fill bytes"
git push --force origin --all

printf "akan di lanjutkan 5 jam 30 menit"
sleep 19800
./test1.sh
#
