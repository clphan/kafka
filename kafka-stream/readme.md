## Start consumer on output topic 
kafka-console-consumer.sh --bootstrap-server 3.0.55.197:9092 --topic favourite-color-output --from-beginning 

kafka-console-consumer.sh --bootstrap-server 3.0.55.197:9092 --topic favourite-color-output \
  --from-beginning \
  --formatter kafka.tools.DefaultMessageFormatter \
  --property print.key=true \
  --property print.value=true \
  --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
  --property value.deserializer=org.apache.kafka.common.serialization.LongDeserializer