PROJECT_SHORTNAME ?= nfs
VERSION ?= 0.3.1
COLLECTION_VERSION ?= 0.3.3
OPERATOR_TYPE ?= ansible
PROJECT_TYPE ?= $(OPERATOR_TYPE)-operator

include hack/mk/main.mk
