<!--
SPDX-FileCopyrightText: 2019-present Open Networking Foundation <info@opennetworking.org>

SPDX-License-Identifier: Apache-2.0
-->

# ONOS SDRAN Helm charts
[![Build Status](https://travis-ci.com/onosproject/sdran-helm-charts.svg?token=GojsizpApAX76HQhL5pw&branch=master)](https://travis-ci.com/onosproject/sdran-helm-charts)
[![Integration Test Status](https://img.shields.io/travis/onosproject/onos-test?label=integration-tests&logo=integration-tests)](https://travis-ci.com/onosproject/onos-test)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/gojp/goreportcard/blob/master/LICENSE)

This repository contains helm charts for the different µONOS services and
overarching helm charts for a set of microservices yielding a full control
plane deployment.

Each folder contains the helm chart of that specific project.
e.g. `onos-config` folder contains the `onos-config` helm chart.

The overarching helm chart to deploy `micro-onos` is in the `sd-ran` folder.

The `micro-onos` documentation project provides [step by step documentation](https://docs.onosproject.org/developers/deploy_with_helm/)
on how to deploy a whole `micro-onos` with Helm. You can also deploy each
service separately by following the the `How to deploy with Helm` documentation
contained in each service.
For example [this](https://docs.onosproject.org/onos-config/docs/deployment/) is the `onos-config` one.
