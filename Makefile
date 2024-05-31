tag ?= latest
image = rafaelbmateus/do-backup:$(tag)

build:
	docker build -t $(image) .

check: build
	docker run --rm \
		--env-file .env \
		$(image) check.sh

backup:
	docker run --rm \
		--env-file .env \
		-v $(dir):/backup \
		$(image) backup.sh

bash:
	docker run --rm -ti \
		--env-file .env \
		-v $(dir):/backup \
		$(image) /bin/bash

run-daily: build
	docker run --rm -d \
		--env-file .env \
		$(image) run-daily.sh

push:
	docker image push $(image)
