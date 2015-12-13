all:	build tag test push

build:
	@sh docker_helper.sh build

tag:
	@sh docker_helper.sh tag

# Usage: $ make tagv v="1.0"
# TODO: replace with grabbing from version.py
tagv:
	@sh docker_helper.sh tag $(v)

test-deps:
	@pip install -r test-requirements.txt

test:
	@sh test.sh

push:
	@sh docker_helper.sh push

.PHONY: build tag tagv test-deps test push
