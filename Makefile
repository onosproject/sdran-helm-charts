# SPDX-FileCopyrightText: 2019-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

.PHONY: all test clean

all: test

jenkins-test: jenkins_version_check license_check deps # @HELP run the jenkins verification tests
	docker pull quay.io/helmpack/chart-testing:v2.4.0
	docker run --rm --name ct --volume `pwd`:/charts quay.io/helmpack/chart-testing:v3.0.0-beta.1 sh -c "ct lint --charts charts/onos-e2sub,charts/onos-e2t,charts/ran-simulator,charts/onos-kpimon --debug --validate-maintainers=false"

license_check: # @HELP examine and ensure license headers exist
	@if [ ! -d "../build-tools" ]; then cd .. && git clone https://github.com/onosproject/build-tools.git; fi
	./../build-tools/licensing/boilerplate.py -v --rootdir=${CURDIR} --boilerplate SPDX-Apache-2.0

jenkins_version_check: build-tools # @HELP run the version checker on the charts
	export COMPARISON_BRANCH=origin/master && export WORKSPACE=`pwd` && ./../build-tools/chart_version_check

version_check: build-tools # @HELP run the version checker on the charts
	COMPARISON_BRANCH=master ./../build-tools/chart_version_check

test: # @HELP run the integration tests
test: license_check version_check deps
	./build/bin/run-sd-ran-test

publish: build-tools # @HELP publish version on sdrancharts.onosproject.org
	./../build-tools/publish-version ${VERSION}

jenkins-publish: build-tools # @HELP publish version on github
	cd .. && GO111MODULE=on go get github.com/mikefarah/yq/v4@v4.16.2
	./../build-tools/release-chart-merge-commit https://sdrancharts.onosproject.org ${WEBSITE_USER} ${WEBSITE_PASSWORD}

build-tools: # @HELP install the ONOS build tools if needed
	@if [ ! -d "../build-tools" ]; then cd .. && git clone https://github.com/onosproject/build-tools.git; fi

bumponosdeps: # @HELP update "onosproject" go dependencies and push patch to git.
	./../build-tools/bump-onos-deps ${VERSION}

clean: # @HELP clean up temporary files for SD-RAN umbrella.
	rm -rf sd-ran/charts sd-ran/Chart.lock

deps: # @HELP build dependencies for SD-RAN Umbrella local charts.
deps: clean
	helm dep build sd-ran

help:
	@grep -E '^.*: *# *@HELP' $(MAKEFILE_LIST) \
    | sort \
    | awk ' \
        BEGIN {FS = ": *# *@HELP"}; \
        {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}; \
    '
