## Start zookeeper and kafka
```
zookeeper-server-start.sh config/zookeeper.properties
```
To start kafka, first need to edit properties
```
vi config/server.properties
// under log.dirs, add director ./data/kafka
```
```
kafka-server-start.sh config/server.properties
```
## Topics
* Befor start, make sure that zookeeper started and kafka started also.
  * Start with a topic
  ```
  kafka-topics.sh --bootstrap-server localhost:9092 --topic first_topic --create --partitions 3 --replication-factor 2
  ```
  * List topics
  ```
  kafka-topics.sh --bootstrap-server localhost:9092 --list
  ```
  * To know more about the topic we have created
  ```
  kafka-topics.sh --bootstrap-server localhost:9092 --topic first_topic --describe
  ```
  * To delete a specific topic
  ```
  kafka-topics.sh --bootstrap-server localhost:9092 --topic second_topic --delete
  ```
## Producer
* Create kafka console producer
```
kafka-console-producer.sh --broker-list localhost:9092 --topic first_topic
```
* Create kafka console producer with ack
```
kafka-console-producer.sh --broker-list localhost:9092 --topic first_topic --producer-property acks=all
```
## Comsumer
* To get message which created at the producer side (only newly message created in real-time)
```
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic first_topic
```
* To get all the message from the beginning
```
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic first-topic --from-beginning
```
## Console consumer in group mode
When create a consumer we can group messages into a group by implement a argument named --group <random-groupname>
```
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic first-topic --group my-app-topic
```
We can run consumer group directly, to get a list of consumer group run
```
kafka-consumer-groups.sh --bootstrap-server localhost:9092 --list
```
To know more about the consumer group
```
kafka-consumer-groups.sh --broker-list localhost:9092 --describe --group <groupName> 
```
## Resetting Offset
```
kafka-consumer-groups.sh --bootstrap-server localhost:9092 --group my-app --reset-offsets/--shift-by <number>/ --to-earliest --execute --topic first_topic
```
