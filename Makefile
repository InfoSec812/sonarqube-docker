SHELL := /bin/bash

VERSION = $(shell cat VERSION | head -n 1)

# make dist-clean
#  Effectively a git reset --hard HEAD; Removes everything that isn't checked in.
dist-clean:
	git reset --hard HEAD
	git clean -df

.PHONY: dist-clean docker docker-up

docker:
	@cat Dockerfile.template | sed "s@__VERSION__@$(VERSION)@g" > Dockerfile
	@docker build --no-cache=true -t infosec812/sonarqube:$(VERSION) ./
	@docker tag -f infosec812/sonarqube:$(VERSION) infosec812/sonarqube:latest

docker-up: docker
	@docker-compose rm --force
	@docker-compose up

docker-push: docker
	@docker push infosec812/sonarqube:$(VERSION)
