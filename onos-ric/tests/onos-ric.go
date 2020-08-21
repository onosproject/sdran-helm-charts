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

// ONOSRICSuite is the onos-ric chart test suite
type ONOSRICSuite struct {
	test.Suite
}

const onosComponentName = "onos-ric"
const testName = "ric-chart-install-test"

// TestInstall tests installing the onos-ric chart
func (s *ONOSRICSuite) TestInstall(t *testing.T) {
	atomix := helm.Chart(onostest.ControllerChartName, onostest.AtomixChartRepo).
		Release(onostest.AtomixName(testName, onosComponentName)).
		Set("scope", "Namespace")
	assert.NoError(t, atomix.Install(true))

	raft := helm.Chart(onostest.RaftStorageControllerChartName, onostest.AtomixChartRepo).
		Release(onostest.RaftReleaseName(onosComponentName)).
		Set("scope", "Namespace")
	assert.NoError(t, raft.Install(true))

	topo := helm.Chart("onos-topo", onostest.OnosChartRepo).
		Release("onos-topo").
		Set("storage.controller", onostest.AtomixController(testName, onosComponentName))
	assert.NoError(t, topo.Install(false))

	ric := helm.Chart("onos-ric").
		Release("onos-ric").
		Set("storage.controller", onostest.AtomixController(testName, onosComponentName))
	assert.NoError(t, ric.Install(true))
}
