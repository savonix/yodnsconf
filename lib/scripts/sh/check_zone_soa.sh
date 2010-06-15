rm -f /tmp/results
cat data/zones/savonix.internal.zone | grep TXT | awk '{print $5}' | sed s/\"//g | sort | while read line; do
   echo $line
   echo $line >> /tmp/results
   dig soa $line +short | awk '{print $1}' >> /tmp/results
done
cat /tmp/results