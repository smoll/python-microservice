all:	build tag test push

build:
	@sh docker_helper.sh build

tag:
	@sh docker_helper.sh tag

test-deps:
	@pip install -r test-requirements.txt

test:
	@sh test.sh

push:
	@sh docker_helper.sh push

.PHONY: build tag test-deps test push
