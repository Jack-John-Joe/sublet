echo "Sublet 0.3.0 - NIS"
echo "Installing.."
echo "Checking for root access.."
sudo clear
echo "Sublet 0.3.0 - NIS"
echo "Installing.."
sudo unzip nis_image.zip -d /
sudo export PATH=/sublet/bin:$PATH
sudo export PATH=/sublet/sbin:$PATH
clear
echo "Sublet 0.3.0 - NIS"
echo "Installing.."
sudo cp -a /subtemp/sublet.x /sbin
echo "#!/bin/bash /sublet/x/updater.sh" > /etc/init.d/update.sh
sudo chmod +x /etc/init.d/update.sh


