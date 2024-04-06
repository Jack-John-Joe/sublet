echo "Updating Sublet.."
cd /sublet/extras
rm ./db.yaml
curl # the githubusercontent thing
cp ./db.yaml /sublet/config
curl # the newest sublet ver
rm /sbin/sublet.x
cp ./sublet.x /sbin/
rm ./sublet.x