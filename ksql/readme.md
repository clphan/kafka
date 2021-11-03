* setup confluent
```
export PATH=${PATH}:/opt/confluent/bin
export CONFLUENT_HOME=/opt/confluent
```

## Create confluent local service 
* Create ksql server 
```
confluent local services ksql-server start
```

* Check status of service 
```
confluent local services status
```
* To easier to connect to confluent registry we can use landoop 
```
docker run --rm -it -p 8000:8000 \
           -e "CONNECT_URL=http://172.18.51.203" \
           landoop/kafka-connect-ui
```