// SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
//
// SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

package tests

import (
	"github.com/onosproject/helmit/pkg/helm"
	"github.com/onosproject/helmit/pkg/input"
	"github.com/onosproject/helmit/pkg/kubernetes"
	"github.com/onosproject/helmit/pkg/test"
	"github.com/onosproject/onos-test/pkg/onostest"
	"github.com/stretchr/testify/assert"
	"testing"
)

// SDRANSuite is the sd-ran chart test suite
type SDRANSuite struct {
	test.Suite
	c *input.Context
}

const onosComponentName = "sd-ran"
const testName = "chart-test"

func getCredentials() (string, string, error) {
	kubClient, err := kubernetes.New()
	if err != nil {
		return "", "", err
	}
	secrets, err := kubClient.CoreV1().Secrets().Get(onostest.SecretsName)
	if err != nil {
		return "", "", err
	}
	username := string(secrets.Object.Data["sd-ran-username"])
	password := string(secrets.Object.Data["sd-ran-password"])

	return username, password, nil
}

// SetupTestSuite sets up the onos-topo test suite
func (s *SDRANSuite) SetupTestSuite(c *input.Context) error {
	s.c = c
	return nil
}

// TestInstall tests installing the sd-ran chart
func (s *SDRANSuite) TestInstall(t *testing.T) {
	username, password, err := getCredentials()
	registry := s.c.GetArg("registry").String("")
	assert.NoError(t, err)

	sdran := helm.Chart("sd-ran", onostest.SdranChartRepo).
		Release("sd-ran").
		SetUsername(username).
		SetPassword(password).
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
		Set("onos-e2t.image.tag", "latest").
		Set("onos-e2sub.image.tag", "latest").
		Set("ran-simulator.image.tag", "latest").
		Set("onos-config.plugin.compiler.target", "github.com/onosproject/onos-config@master").
		Set("global.image.registry", registry)

	assert.NoError(t, sdran.Install(true))
}
