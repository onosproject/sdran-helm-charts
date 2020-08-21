// SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
//
// SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

package tests

import (
	"github.com/onosproject/helmit/pkg/helm"
	"github.com/onosproject/helmit/pkg/test"
	"github.com/onosproject/onos-test/pkg/onostest"
	"github.com/stretchr/testify/assert"
	"testing"
)

// SDRANSuite is the sd-ran chart test suite
type SDRANSuite struct {
	test.Suite
}

const onosComponentName = "sd-ran"
const testName = "chart-test"

// TestInstall tests installing the sd-ran chart
func (s *SDRANSuite) TestInstall(t *testing.T) {
	atomix := helm.Chart(onostest.ControllerChartName, onostest.AtomixChartRepo).
		Release(onostest.AtomixName(testName, onosComponentName)).
		Set("scope", "Namespace")
	assert.NoError(t, atomix.Install(true))

	raft := helm.Chart(onostest.RaftStorageControllerChartName, onostest.AtomixChartRepo).
		Release(onostest.RaftReleaseName(onosComponentName)).
		Set("scope", "Namespace")
	assert.NoError(t, raft.Install(true))

	sdran := helm.Chart("sd-ran").
		Release("sd-ran").
		Set("global.storage.controller", onostest.AtomixController(testName, onosComponentName)).
		Set("import.onos-gui.enabled", false).
		Set("onos-ric.service.external.nodePort", 0).
		Set("onos-ric-ho.service.external.nodePort", 0).
		Set("onos-ric-mlb.service.external.nodePort", 0).
		Set("onos-ric.image.tag", "latest").
		Set("onos-ric-ho.image.tag", "latest").
		Set("onos-ric-mlb.image.tag", "latest").
		Set("onos-cli.image.tag", "latest").
		Set("onos-topo.image.tag", "latest").
		Set("onos-config.image.tag", "latest").
		Set("ran-simulator.image.tag", "latest")
	assert.NoError(t, sdran.Install(true))
}
