.PHONY: all test clean

all: test

license_check: # @HELP examine and ensure license headers exist
	@if [ ! -d "../build-tools" ]; then cd .. && git clone https://github.com/onosproject/build-tools.git; fi
	./../build-tools/licensing/boilerplate.py -v --rootdir=${CURDIR} --boilerplate LicenseRef-ONF-Member-1.0

version_check: # @HELP run the version checker on the charts
	COMPARISON_BRANCH=master ./../build-tools/chart_version_check
	./../build-tools/chart_single_check

test: # @HELP run the integration tests
test: license_check version_check
	helmit test ./test -c .

publish: # @HELP publish version on github
	./../build-tools/publish-version ${VERSION}

bumponosdeps: # @HELP update "onosproject" go dependencies and push patch to git.
	./../build-tools/bump-onos-deps ${VERSION}

clean: # @HELP clean up temporary files.
	rm -rf sd-ran/charts sd-ran/Chart.lock

deps: # @HELP build dependencies for local charts.
	helm dep build sd-ran

help:
	@grep -E '^.*: *# *@HELP' $(MAKEFILE_LIST) \
    | sort \
    | awk ' \
        BEGIN {FS = ": *# *@HELP"}; \
        {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}; \
    '
