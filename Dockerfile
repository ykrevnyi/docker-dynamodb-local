
FROM openjdk:8-jre
MAINTAINER Yurii Krevnyi <ykrevnyi@gmail.com>

# Get the package from Amazon
RUN mkdir -p /opt/dynamodb && \
    cd /opt/dynamodb && \
    wget https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz && \
    tar -zxvf dynamodb_local_latest.tar.gz && \
    rm -f dynamodb_local_latest.tar.gz

ENTRYPOINT ["/usr/bin/java", "-Djava.library.path=.", "-jar", "DynamoDBLocal.jar", "-port", "8000"]

WORKDIR /opt/dynamodb
EXPOSE 8000