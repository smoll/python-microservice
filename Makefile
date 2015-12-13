all:	build tag test push

build:
	@sh docker_helper.sh build

tag:
	@sh docker_helper.sh tag

v:
	@sh docker_helper.sh tag `cat version`
	@sh test.sh
	@sh docker_helper.sh push

test-deps:
	@pip install -r test-requirements.txt

test:
	@sh test.sh

push:
	@sh docker_helper.sh push

.PHONY: build tag v test-deps test push
