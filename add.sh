printf "welcome"
git remote rm origin
read -p "Enter your github repository address: " GHADDRESS
echo "Address: $GHADDRESS."

env git remote add origin $GHADDRESS

read -p "Enter your repository branch (main/master): " kntl
echo "Branch: $kntl."
env git branch -M $kntl

printf "DONE"
sleep 2
