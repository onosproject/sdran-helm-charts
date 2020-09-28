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

// AetherRocUmbrellaSuite is the aether-roc-umbrella chart test suite
type AetherRocUmbrellaSuite struct {
	test.Suite
}

const componentName = "aether-roc-umbrella"
const testName = "aether-chart-test"

// TestInstall tests installing the aether-roc-umbrella chart
func (s *AetherRocUmbrellaSuite) TestInstall(t *testing.T) {
	atomix := helm.Chart("atomix-controller", onostest.AtomixChartRepo).
		Release(onostest.AtomixName(testName, componentName)).
		Set("scope", "Namespace")
	assert.NoError(t, atomix.Install(true))

	raft := helm.Chart("raft-storage-controller", onostest.AtomixChartRepo).
		Release(onostest.RaftReleaseName(componentName)).
		Set("scope", "Namespace")
	assert.NoError(t, raft.Install(true))

	onos := helm.Chart("aether-roc-umbrella").
		Release("aether-roc-umbrella").
		Set("global.storage.controller", onostest.AtomixController(testName, componentName)).
		Set("import.onos-gui.enabled", false).
		Set("import.onos-cli.enabled", false).
		Set("onos-topo.image.tag", "latest").
		Set("onos-config.image.tag", "latest").
		Set("aether-roc-api.image.tag", "latest")
	assert.NoError(t, onos.Install(true))
}
