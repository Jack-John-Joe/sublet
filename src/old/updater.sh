echo "Updating Sublet.."
cd /sublet/extras
rm ./db.xml
wget # the githubusercontent thing
cp ./db.xml /sublet/config
wget # the newest sublet ver
rm /sbin/sublet.x
cp ./sublet.x /sbin/
rm ./sublet.x