PROJECT_SHORTNAME ?= nfs
VERSION ?= 0.3.46
COLLECTION_VERSION ?= 0.3.67
OPERATOR_TYPE ?= ansible
PROJECT_TYPE ?= $(OPERATOR_TYPE)-operator

include hack/mk/main.mk
