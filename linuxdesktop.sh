sudo useradd -m Bagasamin
sudo adduser Bagasamin sudo
echo "Bagasamin:Bagas1123" | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
sudo apt-get update
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo DEBIAN_FRONTEND=noninteractive \
apt install --assume-yes xfce4 desktop-base
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
sudo apt install --assume-yes xscreensaver
sudo systemctl disable lightdm.service
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo apt install nautilus nano -y
sudo apt install gdebi
sudo apt -y install firefox
sudo hostname Bagasamin
sudo adduser Bagasamin chrome-remote-desktop
sudo apt install tightvncserver
echo -e "no\nBagas1123\nBagas1123" | tightvncserver :1
echo -e "112233\n112233" | su - Bagasamin -c """DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AY0e-g4cfExPsBwTL9HHyQqfRVLHIBpQrkaW96wSh0yJI6WUKNQ46p7rn8dswO6osj-kWg" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname)"""

if [[ -z "1pWnQU619I88LYwZbTREeWSrowz_iWH4xJeqVnmrcpkad1XU" ]]; then
  echo "Please set '1pWnQU619I88LYwZbTREeWSrowz_iWH4xJeqVnmrcpkad1XU'"
  exit 2
fi

if [[ -z "Bagas1123" ]]; then
  echo "Please set 'Bagas1123' for user: Bagasamin"
  exit 3
fi

echo "### Install ngrok ###"

wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip
unzip ngrok-stable-linux-386.zip
chmod +x ./ngrok

echo "### Update user: Bagasamin password ###"
echo -e "Bagas1123\nBagas1123" | sudo passwd "Bagasamin"

echo "### Start ngrok proxy for 22 port ###"


rm -f .ngrok.log
./ngrok authtoken "1pWnQU619I88LYwZbTREeWSrowz_iWH4xJeqVnmrcpkad1XU"
./ngrok tcp 22 --log ".ngrok.log" &

sleep 10
HAS_ERRORS=$(grep "command failed" < .ngrok.log)

if [[ -z "$HAS_ERRORS" ]]; then
  echo ""
  echo "=========================================="
  echo "To connect: $(grep -o -E "tcp://(.+)" < .ngrok.log | sed "s/tcp:\/\//ssh Bagasamin@/" | sed "s/:/ -p /")"
  echo "Connect with remote desktop: https://remotedesktop.google.com/access"
  echo "=========================================="
else
  echo "$HAS_ERRORS"
  exit 4
fi
