include .env.local

.PHONY: stop clean .setup check_elactic create_elastic_ssl_certs

DOCKER_COMPOSE_CMD ?= docker-compose

clean:
	rm -rf docker/tmp/

local: .setup
	$(DOCKER_COMPOSE_CMD) -f docker/docker-compose-local.yml --env-file .env.local up

create_elastic_ssl_certs: .setup
	$(DOCKER_COMPOSE_CMD) -f docker/elasticsearch-ssl-certificate/create-certs.yml --env-file .env.local run -rm create_certs

check_elastic:
	@nodes="$(shell curl -u $(ELASTIC_USER):$(ELASTIC_PASSWORD) -X GET "localhost:9200/_cat/nodes?h=name&pretty" 2>&1 | xargs | grep -o 'es0.')" && if [ "$$nodes" = '' ]; then  echo "\n---\n Elastic not running"; else echo "\n---\n Running nodes: $$nodes"; fi

stop:
	$(DOCKER_COMPOSE_CMD) -f docker/docker-compose-local.yml down

.setup:
	mkdir -p docker/tmp/elasticsearch/data
