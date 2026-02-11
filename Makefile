# SPDX-FileCopyrightText: 2019-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

.PHONY: all test clean version-check

COMPARISON_BRANCH ?= master

all: deps

lint: # @HELP run helm lint
	./build/bin/helm_lint.sh

check-version: # @HELP run the version checker on the charts
	COMPARISON_BRANCH=${COMPARISON_BRANCH} ./build/bin/version_check.sh all

test: # @HELP run the integration tests
test: deps license lint

clean:: # @HELP clean up temporary files for SD-RAN umbrella.
	rm -rf onos-exporter/charts onos-exporter/Chart.lock
	rm -rf sd-ran/charts sd-ran/Chart.lock

deps: # @HELP build dependencies for SD-RAN Umbrella local charts.
deps: clean
	helm dep build onos-exporter
	helm dep build sd-ran

license: # @HELP run license checks
	rm -rf venv
	python3 -m venv venv
	. ./venv/bin/activate;\
	python3 -m pip install --upgrade pip;\
	python3 -m pip install reuse;\
	reuse lint
