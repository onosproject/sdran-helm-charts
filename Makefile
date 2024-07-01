# SPDX-FileCopyrightText: 2019-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

.PHONY: all test clean version-check

COMPARISON_BRANCH ?= master

all: dep

lint: # @HELP run helm lint
	./build/bin/helm_lint.sh

check-version: # @HELP run the version checker on the charts
	COMPARISON_BRANCH=${COMPARISON_BRANCH} ./build/bin/version_check.sh all

test: # @HELP run the integration tests
test: deps license lint

clean:: # @HELP clean up temporary files for SD-RAN umbrella.
	rm -rf sd-ran/charts sd-ran/Chart.lock

deps: # @HELP build dependencies for SD-RAN Umbrella local charts.
deps: clean
	helm dep build sd-ran

license: # @HELP run license checks
	rm -rf venv
	python3 -m venv venv
	. ./venv/bin/activate;\
	python3 -m pip install --upgrade pip;\
	python3 -m pip install reuse;\
	reuse lint


publish: # @HELP publish version on sdrancharts.onosproject.org
	./build/build-tools/publish-version ${VERSION}

jenkins-publish: # @HELP publish version on github
	cd .. && GO111MODULE=on go install github.com/mikefarah/yq/v4@v4.16.2
	./build/build-tools/release-chart-merge-commit https://sdrancharts.onosproject.org ${WEBSITE_USER} ${WEBSITE_PASSWORD}