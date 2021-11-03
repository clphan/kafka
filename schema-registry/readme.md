* Create a producer with schema
```
kafka-avro-console-producer \
  --broker-list 18.142.49.241:9092 --topic test-avro \
  --property schema.registry.url=http://18.142.49.241:8081 \
  --property value.schema='
  {
    "type":"record",
    "name":"myrecord",
    "fields": [
      {
        "name": "f1",
        "type": "string"
      }
    ]
  }'
```

* Create a consumer with schema but change the name type
```
kafka-avro-console-producer \
  --broker-list 18.142.49.241:9092 --topic test-avro \
  --property schema.registry.url=http://18.142.49.241:8081 \
  --property value.schema='
  {
    "type":"record",
    "name":"myrecord",
    "fields": [
      {
        "name": "f1",
        "type": "int"
      }
    ]
  }'
```