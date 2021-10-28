.PHONY: stop clean .setup check_elactic

DOCKER_COMPOSE_CMD ?= docker-compose

clean:
	rm -rf docker/tmp/

local: .setup
	$(DOCKER_COMPOSE_CMD) -f docker/docker-compose-local.yml --env-file .env.dev up

check_elastic:
	@nodes="$(shell curl -X GET "localhost:9200/_cat/nodes?h=name&pretty" 2>&1 | xargs | grep -o 'es0.')" && if [ "$$nodes" = '' ]; then  echo "\n---\n Elastic not running"; else echo "\n---\n Running nodes: $$nodes"; fi

stop:
	$(DOCKER_COMPOSE_CMD) -f docker/docker-compose-local.yml down

.setup:
	mkdir -p docker/tmp/elasticsearch/data
