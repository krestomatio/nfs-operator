PROJECT_SHORTNAME ?= nfs
VERSION ?= 0.4.2
COLLECTION_VERSION ?= 0.4.7
OPERATOR_TYPE ?= ansible
PROJECT_TYPE ?= $(OPERATOR_TYPE)-operator

include hack/mk/main.mk
