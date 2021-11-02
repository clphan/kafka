* setup confluent
```
export PATH=${PATH}:/opt/confluent/bin
export CONFLUENT_HOME=/opt/confluent
```

## Create confluent local service 
* Create ksql server 
```
confluent services ksql-server start
```

* Check status of service 
```
confluent local services status
```