PROJECT_SHORTNAME ?= nfs
VERSION ?= 0.3.32
COLLECTION_VERSION ?= 0.3.52
OPERATOR_TYPE ?= ansible
PROJECT_TYPE ?= $(OPERATOR_TYPE)-operator

include hack/mk/main.mk
