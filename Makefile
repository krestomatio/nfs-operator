PROJECT_SHORTNAME ?= nfs
VERSION ?= 0.4.6
COLLECTION_VERSION ?= 0.4.8
OPERATOR_TYPE ?= ansible
PROJECT_TYPE ?= $(OPERATOR_TYPE)-operator
COMMUNITY_OPERATOR_NAME ?= nfs-operator

include hack/mk/main.mk
