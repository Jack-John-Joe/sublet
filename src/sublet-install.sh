#!/bin/bash
echo "Installing Sublet.."
echo "<#________________>"
curl # i'll put the github user content link here latero
unzip installfiles.zip -d ~/sublet/temp/
clear 
echo "Installing Sublet.."
echo "<##_______________>"
cd ~/sublet/temp/
echo "Checking for Superuser Access.. Password may be required."
sudo clear
echo "Installing Sublet.."
echo "<##_______________>"
clear
echo "Installing Sublet.."
echo "<####_____________>"
sudo mkdir /sublet/bin
sudo mkdir /sublet/sbin
clear
echo "Installing Sublet.."
echo "<######___________>"
sudo export PATH=/sublet/bin:$PATH
sudo export PATH=/sublet/sbin:$PATH
clear
echo "Installing Sublet.."
echo "<########_________>"
cd ~/sublet/temp/
sudo cp -a ./sublet.x /sbin
mkdir /sublet/config
sudo cp ~/sublet/temp/config. /sublet/config
clear
echo "Installing Sublet.."
echo "<#################>"
clear
echo "Preparing Sublet.."
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "$NAME"
else
    OS=$(awk '/DISTRIB_ID=/' /etc/*-release | sed 's/DISTRIB_ID=//' | tr '[:upper:]' '[:lower:]')
    echo "$OS"
fi
clr
echo "ver: 0.1.1"
distro: $NAME
macOS: false
preset: 1" > /sublet/temp/config/config.yaml
sudo cd ~/sublet/temp
sudo cp -a ./db.yaml /sublet/
sudo cp ~/sublet/temp/extra /sublet/x
echo "#!/bin/bash /sublet/x/updater.sh" > /etc/init.d/update.sh
# I FORGOT TO CHMOD IT UP SHIT
sudo chmod +x /etc/init.d/update.sh
# there rea rea
echo "Preparing Sublet.."
echo "Cleaning up.."
rm -rf ~/sublet
echo "Sublet 0.1.1 has been installed."
end