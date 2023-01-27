# SPDX-FileCopyrightText: 2019-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

.PHONY: all test clean

all: test

build-tools:=$(shell if [ ! -d "./build/build-tools" ]; then cd build && git clone https://github.com/onosproject/build-tools.git; fi)
include ./build/build-tools/make/onf-common.mk

jenkins-test: jenkins_version_check license deps # @HELP run the jenkins verification tests
	docker pull quay.io/helmpack/chart-testing:v2.4.0
	docker run --rm --name ct --volume `pwd`:/charts quay.io/helmpack/chart-testing:v3.0.0-beta.1 sh -c "ct lint --charts charts/onos-e2t,charts/ran-simulator,charts/onos-kpimon --debug --validate-maintainers=false"

jenkins_version_check: # @HELP run the version checker on the charts
	export COMPARISON_BRANCH=origin/master && export WORKSPACE=`pwd` && ./build/build-tools/chart_version_check

version_check: # @HELP run the version checker on the charts
	COMPARISON_BRANCH=master ./build/build-tools/chart_version_check

test: # @HELP run the integration tests
test: license version_check deps
	./build/bin/run-sd-ran-test

publish: # @HELP publish version on sdrancharts.onosproject.org
	./build/build-tools/publish-version ${VERSION}

jenkins-publish: # @HELP publish version on github
	cd .. && GO111MODULE=on go install github.com/mikefarah/yq/v4@v4.16.2
	./build/build-tools/release-chart-merge-commit https://sdrancharts.onosproject.org ${WEBSITE_USER} ${WEBSITE_PASSWORD}

clean:: # @HELP clean up temporary files for SD-RAN umbrella.
	rm -rf sd-ran/charts sd-ran/Chart.lock

deps: # @HELP build dependencies for SD-RAN Umbrella local charts.
deps: clean
	helm dep build sd-ran
