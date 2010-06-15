cat data/zones/savonix.internal.zone | grep TXT | awk '{print $5}' | sed s/\"//g | sort > /tmp/tmp1

ls -1 data/zones/ | sed s/.zone//g | sort > /tmp/tmp2

diff /tmp/tmp1 /tmp/tmp2 | grep ">" | awk '{print "git rm " $2 ".zone" }'

#rsync -av pro-2-gl:/etc/nsd3/zones/* ./