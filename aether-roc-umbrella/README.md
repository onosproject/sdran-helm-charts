## Aether ROC Umbrella chart

Provides a [Helm] chart for deploying aether-portal, aether-roc, onos-topo, onos-config, onos-gui to [Kubernetes].
See the [documentation] for more info.

To deploy with Authentication enabled:
First deploy the [dex-ldap-umbrella](https://github.com/onosproject/onos-helm-charts/tree/master/dex-ldap-umbrella)

Then run:
```bash
hm install aether-roc-umbrella ./aether-roc-umbrella --set onos-config.openidc.issuer=http://dex-ldap-umbrella:32000 --set aether-roc-gui.openidc.issuer=http://dex-ldap-umbrella:32000
```

[Kubernetes]: https://kubernetes.io/
[Helm]: https://helm.sh/
[documentation]: https://docs.onosproject.org/developers/deploy_with_helm/
