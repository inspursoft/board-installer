SHELL := /bin/bash
BUILDPATH=$(CURDIR)
MAKEPATH=$(BUILDPATH)
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
PKGNAME=ansible-install
PKGTEMPPATH=ansible_k8s
GITTAGVERSION=$(shell git describe --tags || echo UNKNOWN)
VERSIONFILE=VERSION
FLAG=release
ifeq ($(FLAG), release)
        VERSIONTAG=$(GITTAGVERSION)
else
        VERSIONTAG=dev
endif

tar:
	@echo $(DOCKERCMD)
	@echo $(DOCKERBUILD)
	@echo $(DOCKERPULL)
	@curl -O "http://repo.inspur.com/artifactory/k8s-deploy-script/pre-env.tar.gz"
	@$(TARCMD) zxvf pre-env.tar.gz -C ansible_k8s
	@$(TARCMD) -zcvf $(PKGNAME)-offline-$(VERSIONTAG).tgz $(PKGTEMPPATH)
image:
	@echo $(DOCKERCMD)
	@echo $(DOCKERBUILD)
	@echo $(MAKEWORKPATH)
	@$(DOCKERBUILD) -f $(MAKEWORKPATH)/Dockerfile -t ansible_install:$(VERSIONTAG) .

