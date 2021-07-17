.PHONY: all build test out clean

SHELL = /bin/bash

all: all_default all_no_service

all_build: build_default build_no_service
all_test: test_default test_no_service
all_clean: clean_default clean_no_service

all_default: build_default test_default clean_default
build_default: build_deployment_default
test_default: test_deployment_default
clean_default: clean_deployment_default

all_no_service: build_no_service test_no_service clean_no_service
build_no_service: build_deployment_no_service
test_no_service: test_deployment_no_service
clean_no_service: clean_deployment_no_service

build_deployment_default:
	@pushd examples/default; \
	terraform init; \
	terraform apply -auto-approve; \
	popd

test_deployment_default:
	@pushd examples/default; \
	echo "testing ..."; \
	popd

clean_deployment_default:
	@pushd examples/default; \
	terraform destroy -auto-approve; \
	popd

build_deployment_no_service:
	@pushd examples/no_service; \
	terraform init; \
	terraform apply -auto-approve; \
	popd

test_deployment_no_service:
	@pushd examples/no_service; \
	echo "testing ..."; \
	popd

clean_deployment_no_service:
	@pushd examples/no_service; \
	terraform destroy -auto-approve; \
	popd
