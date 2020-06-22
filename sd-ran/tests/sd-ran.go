// SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
//
// SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

package tests

import (
	"github.com/onosproject/helmit/pkg/helm"
	"github.com/onosproject/helmit/pkg/test"
	"github.com/stretchr/testify/assert"
	"testing"
)

// SDRANSuite is the sd-ran chart test suite
type SDRANSuite struct {
	test.Suite
}

// TestInstall tests installing the sd-ran chart
func (s *SDRANSuite) TestInstall(t *testing.T) {
	atomix := helm.Chart("atomix-controller", "https://charts.atomix.io").
		Release("sd-ran-atomix").
		Set("scope", "Namespace")
	assert.NoError(t, atomix.Install(true))

	raft := helm.Chart("raft-storage-controller", "https://charts.atomix.io").
		Release("sd-ran-raft").
		Set("scope", "Namespace")
	assert.NoError(t, raft.Install(true))

	sdran := helm.Chart("sd-ran").
		Release("sd-ran").
		Set("global.store.controller", "sd-ran-atomix-atomix-controller:5679").
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
