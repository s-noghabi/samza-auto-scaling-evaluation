#!/bin/bash
#run the script as following: <input file name>  <size to chunk> <sleep time>
while true;do
filename="$1"
chunkSize=$2
sleepTime=$3
topicName="shadi-mem-test-in"
count=0
tmpFile=tmp.json
rm -f $tmpFile
touch $tmpFile
startTime=`ruby -e 'puts Time.now.to_f'`
echo "start $startTime"
while read -r line
do

    data=$line
    echo $data >> $tmpFile
    #echo $line
    count=$[count + 1]
#    echo $count
    if [ $count = $chunkSize ]; then
        echo "restarting $count" 
        `../hello-samza/deploy/kafka/bin/kafka-console-producer.sh --topic shadi-mem-test-in --broker-list lca1-kafka-kafka-queuing-vip.corp.linkedin.com:10251 < $tmpFile` 
        count=0
       # sleep $sleepTime
        rm -rf $tmpFile
        touch $tmpFile 
    fi
#./kafka-console-producer.sh --topic $2 --zookeeper zk-lca1-kafka.corp.linkedin.com:12913/kafka-queuing $line
done < "$filename"

endTime=`ruby -e 'puts Time.now.to_f'`
diff=`echo "$endTime - $startTime" | bc`
echo $diff

echo " end time  $endTime"
done
