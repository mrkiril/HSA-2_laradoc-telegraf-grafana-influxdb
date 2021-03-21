PATH_FILE=.env
FILE:=$(test -f $(PATH_FILE))


ps:
	docker-compose ps

up:
	#[ ! -f $(PATH_FILE) ] && cp env-example .env
	[ ! -f $(PATH_FILE) ] && echo exists || echo not exists
	docker-compose up nginx mysql redis elasticsearch mongo telegraf grafana influxdb
	#docker-compose up -d
	docker-compose ps

enter:
	docker-compose exec workspace bash

test_nginx:
	ab -n 10000 -c 1000 http://localhost:80/

test_elastic:
	ab -n 10000 -c 1000 http://localhost:9200/


down:
	docker-compose down

run:
	docker-compose build --parallel --no-cache
	docker-compose up -d
	docker-compose ps

rebuild:
	docker-compose build --parallel
	docker-compose up -d
	docker-compose ps
