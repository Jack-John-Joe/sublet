echo "Updating Sublet.."
cd /sublet/extras
rm ./db.xml
wget https://github.com/Jack-John-Joe/sublet/raw/main/database/db/db.xml
cp ./db.xml /sublet/config
wget # the newest sublet ver
rm /sbin/sublet.x
cp ./sublet.x /sbin/
rm ./sublet.x