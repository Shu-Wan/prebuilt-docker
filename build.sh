#docker buildx create --use # create a buildx driver
docker buildx build --platform=linux/amd64,linux/arm64 \
--build-arg SPARK_VERSION=3.3.2 \
-f ./ubuntu-with-spark.dockerfile \
--push -t shuwan/ubuntu-20.04:spark-3.3.2 .
