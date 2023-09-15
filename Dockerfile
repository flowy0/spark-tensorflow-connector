FROM maven:3.9.1-amazoncorretto-11-debian AS stage1
RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/tensorflow/ecosystem.git spark-tensorflow-connector-source
RUN cd spark-tensorflow-connector-source/hadoop && mvn clean install -Dmaven.javadoc.skip=true
RUN cd spark-tensorflow-connector-source/spark/spark-tensorflow-connector && mvn clean install -DskipTests

# changed to alpine image so that bash is enabled
FROM alpine AS export-stage  
COPY --from=stage1 /spark-tensorflow-connector-source/spark/spark-tensorflow-connector/target/spark-tensorflow-connector_2.12-1.11.0.jar  .

