SHELL := /bin/bash
BUILDPATH=$(CURDIR)
MAKEPATH=$(BUILDPATH)/make
MAKEWORKPATH=$(MAKEPATH)/$(WORKPATH)
SRCPATH= src
TOOLSPATH=$(BUILDPATH)/tools
IMAGEPATH=$(BUILDPATH)/make/$(MAKEWORKPATH)
PACKAGEPATH=$(BUILDPATH)/Deploy


# docker parameters
DOCKERCMD=$(shell which docker)
DOCKERBUILD=$(DOCKERCMD) build
DOCKERRMIMAGE=$(DOCKERCMD) rmi
DOCKERPULL=$(DOCKERCMD) pull
DOCKERIMASES=$(DOCKERCMD) images
DOCKERSAVE=$(DOCKERCMD) save
DOCKERCOMPOSECMD=$(shell which docker-compose)
DOCKERTAG=$(DOCKERCMD) tag

TARCMD=$(shell which tar)
PKGNAME=ansible-script
PKGTEMPPATH=ansible_k8s
GITTAGVERSION=$(shell git describe --tags || echo UNKNOWN)
VERSIONFILE=VERSION
FLAG=release
ifeq ($(FLAG), release)
        VERSIONTAG=$(GITTAGVERSION)
else
        VERSIONTAG=dev
endif

all:
	@echo $(DOCKERCMD)
	@echo $(DOCKERBUILD)
	@echo $(DOCKERPULL)
	@$(DOCKERPULL) registry.access.redhat.com/rhel7/pod-infrastructure
#	@$(DOCKERPULL) registry:2.6.2
	@$(DOCKERSAVE) -o ./ansible_k8s/roles/node/files/pod-infrastructure registry.access.redhat.com/rhel7/pod-infrastructure:latest
	@$(DOCKERSAVE) -o ./ansible_k8s/roles/registry/files/registry registry:latest
	@curl -L https://github.com/docker/compose/releases/tag/1.20.1/docker-compose-Linux-x86_64  > ./ansible_k8s/roles/master/files/docker-compose
	@$(TARCMD) -zcvf $(PKGNAME)-offline.tgz $(PKGTEMPPATH)
