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

// ONOSRICSuite is the onos-ric chart test suite
type ONOSRICSuite struct {
	test.Suite
}

// TestInstall tests installing the onos-ric chart
func (s *ONOSRICSuite) TestInstall(t *testing.T) {
	atomix := helm.Chart("atomix-controller", "https://charts.atomix.io").
		Release("onos-ric-atomix").
		Set("scope", "Namespace")
	assert.NoError(t, atomix.Install(true))

	raft := helm.Chart("raft-storage-controller", "https://charts.atomix.io").
		Release("onos-ric-raft").
		Set("scope", "Namespace")
	assert.NoError(t, raft.Install(true))

	topo := helm.Chart("onos-topo", "https://charts.onosproject.org").
		Release("onos-topo").
		Set("storage.controller", "onos-ric-atomix-atomix-controller:5679")
	assert.NoError(t, topo.Install(false))

	ric := helm.Chart("onos-ric").
		Release("onos-ric").
		Set("storage.controller", "onos-ric-atomix-atomix-controller:5679")
	assert.NoError(t, ric.Install(true))
}
