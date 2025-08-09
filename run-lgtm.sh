#!/bin/bash

RELEASE=${1:-latest}

docker pull docker.io/grafana/otel-lgtm:"${RELEASE}"

touch .env

docker run \
	--name lgtm \
	-p 3000:3000 \
	-p 4317:4317 \
	-p 4318:4318 \
    -p 8125:8125/udp \
	--rm \
	-ti \
	-v "$PWD"/container/grafana:/data/grafana \
	-v "$PWD"/container/prometheus:/data/prometheus \
	-v "$PWD"/container/loki:/data/loki \
    -v "$PWD"/docker/otelcol-config.yaml:/otel-lgtm/otelcol-config.yaml \
    -v "$PWD"/docker/loki-config.yaml:/otel-lgtm/loki-config.yaml \
	-e GF_PATHS_DATA=/data/grafana \
	--env-file .env \
	docker.io/grafana/otel-lgtm:"${RELEASE}"
