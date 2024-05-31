tag ?= latest
image = rafaelbmateus/do-backup:$(tag)

build:
	docker build -t $(image) .

run:
	docker run --env-file .env --rm $(image)

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

push:
	docker image push $(image)
