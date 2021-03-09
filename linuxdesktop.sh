sudo useradd -m swenson
sudo adduser swenson sudo
echo "swenson:1Amarselinus" | sudo chpasswd
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
sudo hostname shouko
sudo adduser swenson chrome-remote-desktop
sudo apt install tightvncserver
echo -e "no\n1Amarselinus\n1Amarselinus" | tightvncserver :1
echo -e "123456\n123456" | su - swenson -c """DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AY0e-g6M7bMf4pSfmSRs_8Xj1g6o-zl3LHPWF8QQhh1AideZNRnwqqTSm7m8H0P2ORYmfA" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname)"""

if [[ -z "1iX7KZI6l9uc0cLD5Pj4eStvQnF_7EhMLbe6Y9sFZtD5CNP2g" ]]; then
  echo "Please set '1iX7KZI6l9uc0cLD5Pj4eStvQnF_7EhMLbe6Y9sFZtD5CNP2g'"
  exit 2
fi

if [[ -z "1Amarselinus" ]]; then
  echo "Please set '1Amarselinus' for user: swenson"
  exit 3
fi

echo "### Install ngrok ###"

wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip
unzip ngrok-stable-linux-386.zip
chmod +x ./ngrok

echo "### Update user: swenson password ###"
echo -e "1Amarselinus\n1Amarselinus" | sudo passwd "swenson"

echo "### Start ngrok proxy for 22 port ###"


rm -f .ngrok.log
./ngrok authtoken "1iX7KZI6l9uc0cLD5Pj4eStvQnF_7EhMLbe6Y9sFZtD5CNP2g"
./ngrok tcp 22 --log ".ngrok.log" &

sleep 10
HAS_ERRORS=$(grep "command failed" < .ngrok.log)

if [[ -z "$HAS_ERRORS" ]]; then
  echo ""
  echo "=========================================="
  echo "To connect: $(grep -o -E "tcp://(.+)" < .ngrok.log | sed "s/tcp:\/\//ssh swenson@/" | sed "s/:/ -p /")"
  echo "Connect with remote desktop: https://remotedesktop.google.com/access"
  echo "=========================================="
else
  echo "$HAS_ERRORS"
  exit 4
fi
