from kafka import KafkaProducer

def main():
    print("Start sending...!")
    producer = KafkaProducer(bootstrap_servers='3.0.55.197:9092')
    producer.send('test-bank-transaction', b'hsekkazzzz')

if __name__ == "__main__":
    main()