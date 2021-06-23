// SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
//
// SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

package tests

import (
	"context"
	"github.com/onosproject/helmit/pkg/helm"
	"github.com/onosproject/helmit/pkg/input"
	"github.com/onosproject/helmit/pkg/kubernetes"
	"github.com/onosproject/helmit/pkg/test"
	"github.com/onosproject/onos-test/pkg/onostest"
	"github.com/stretchr/testify/assert"
	"testing"
	"time"
)

// AetherRocUmbrellaSuite is the aether-roc-umbrella chart test suite
type AetherRocUmbrellaSuite struct {
	test.Suite
	c *input.Context
}

// SetupTestSuite sets up the aether roc umbrella test suite
func (s *AetherRocUmbrellaSuite) SetupTestSuite(c *input.Context) error {
	s.c = c
	return nil
}

func getCredentials() (string, string, error) {
	kubClient, err := kubernetes.New()
	if err != nil {
		return "", "", err
	}
	secrets, err := kubClient.CoreV1().Secrets().Get(context.Background(), onostest.SecretsName)
	if err != nil {
		return "", "", err
	}
	username := string(secrets.Object.Data["sd-ran-username"])
	password := string(secrets.Object.Data["sd-ran-password"])

	return username, password, nil
}

// TestInstall tests installing the aether-roc-umbrella chart
func (s *AetherRocUmbrellaSuite) TestInstall(t *testing.T) {
	username, password, err := getCredentials()
	assert.NoError(t, err)
	registry := s.c.GetArg("registry").String("")

	onos := helm.Chart("aether-roc-umbrella", onostest.SdranChartRepo).
		Release("aether-roc-umbrella").
		SetUsername(username).
		SetPassword(password).
		WithTimeout(15 * time.Minute).
		Set("onos-ric.service.external.nodePort", 0).
		Set("onos-ric-ho.service.external.nodePort", 0).
		Set("onos-ric-mlb.service.external.nodePort", 0).
		Set("import.onos-gui.enabled", false).
		Set("import.aether-roc-gui.enabled", false).
		Set("import.onos-cli.enabled", false).
		Set("onos-topo.image.tag", "latest").
		Set("onos-config.image.tag", "latest").
		Set("aether-roc-api.image.tag", "latest").
		Set("onos-config.plugin.compiler.target", "github.com/onosproject/onos-config@master").
		Set("onos-cli.postInstall.topo", "").
		Set("global.image.registry", registry)
	assert.NoError(t, onos.Install(true))
}
