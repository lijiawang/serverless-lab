#!/bin/bash
set -e 

trap '{ echo "" ; exit 1; }' INT

KAFKA_TOPIC=${1:-'my-topic'}
KAFKA_CLUSTER_NS=${2:-'kafka'}
KAFKA_CLUSTER_NAME=${3:-'my-cluster'}

kubectl -n $KAFKA_CLUSTER_NS run kafka-consumer -ti \
  --image=strimzi/kafka:0.15.0-kafka-2.3.1 \
  --rm=true --restart=Never \
  -- bin/kafka-console-consumer.sh \
  --bootstrap-server $KAFKA_CLUSTER_NAME-$KAFKA_CLUSTER_NS-bootstrap:9092 \
  --topic $KAFKA_TOPIC --from-beginning
