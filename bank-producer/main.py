import random
import datetime
import time
import json
from kafka import KafkaProducer

BROKER_HOSTNAME = '3.0.55.197'
BROKER_PORT = '9092'
def getReferrer():
    data = {}
    data['Name'] = random.choice(['John','Herry', 'Richard', 'Chris','Mike'])
    data['amount'] = random.randint(1,200)
    now = datetime.datetime.now()
    str_now = now.isoformat()
    data['time'] = str_now
    return data


def main():
    print("Start sending...!")
    while(True):
        jsdata = getReferrer()
        strdata = json.dumps(jsdata)
        producer = KafkaProducer(bootstrap_servers='{}:{}'.format(BROKER_HOSTNAME, BROKER_PORT))
        rs = producer.send('test-bank-transaction', key=jsdata.get("Name").encode('utf-8'), value=strdata.encode('utf-8'))
        rs = rs.get(timeout=60)
        print("data: {}".format(jsdata))
        # print("result: {}".get(rs))
        time.sleep(1)


if __name__ == "__main__":
    main()