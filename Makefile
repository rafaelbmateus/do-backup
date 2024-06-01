tag ?= latest
image = rafaelbmateus/do-backup:$(tag)

build:
	docker build -t $(image) .

check: build
	docker run --rm \
		--env-file .env \
		$(image) \
		check.sh

backup: build
	docker run --rm \
		--env-file .env \
		-v $(dir):/backup \
		$(image) \
		backup.sh

run-daily: build
	docker run --rm -d \
		--env-file .env \
		-v $(dir):/backup \
		$(image) \
		run-daily.sh

bash:
	docker run --rm -ti \
		--env-file .env \
		-v $(dir):/backup \
		$(image) \
		/bin/bash

push: build
	docker image push $(image)
