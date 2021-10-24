* Befor stat we need to make sure that zookeeper started and kafka already started also.
  * Start with topic: 
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