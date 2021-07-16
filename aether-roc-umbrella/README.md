## Aether ROC Umbrella chart

First add repos to your Helm client
```
stable       	https://charts.helm.sh/stable                        
cord         	https://charts.opencord.org                          
atomix       	https://charts.atomix.io                             
onosproject  	https://charts.onosproject.org                       
sdran        	https://sdrancharts.onosproject.org                  
aether       	https://charts.aetherproject.org                     
cetic        	https://cetic.github.io/helm-charts                  
bitnami      	https://charts.bitnami.com/bitnami
```

Provides a [Helm] chart for deploying

* aether-roc-gui (2 versions)
* aether-roc-api 
* onos-topo
* onos-config
* sdcore-adapter (2 versions)
* sdcore-test-dummy
* grafana
* prometheus

to [Kubernetes].
> See the [documentation] for more info.

## Config models
The Aether ROC Umbrella chart controls the Config Model Plugins that are enabled in `onos-config`
Currently 2 versions of the `Aether` model are loaded:

* aether-2.1.0
* aether-3.0.0

## Deploy with Authentication enabled

1) install the helm Repo https://cetic.github.io/helm-charts
2) deploy the [dex-ldap-umbrella](https://github.com/onosproject/onos-helm-charts/tree/master/dex-ldap-umbrella)

Then run:
```bash
helm -n micro-onos install aether-roc-umbrella sdran/aether-roc-umbrella \
--set onos-config.openidc.issuer=http://dex-ldap-umbrella:5556 \
--set aether-roc-gui.openidc.issuer=http://dex-ldap-umbrella:5556
```

## Sample Data - MEGA Patch
Some sample data that works with the `aether-3.0.0` models is available at
https://github.com/onosproject/aether-roc-api/blob/master/examples/MEGA_Patch.curl

This creates 2 sample enterprises `acme` and `starbucks` with corresponding `sites`,
`applications`, `device-groups` and `vcs` etc.

## sdcore-test-dummy 
The chart includes the `sdcore-test-dummy` container for testing the `sdcore-adapter`

> this may be disabled in the chart with `--set import.sdcore-test-dummy.enabled=false`

This runs in the cluster at http://aether-roc-umbrella-sdcore-test-dummy (port 80)

This is a simple nginx server that has been configured to accept POST requests and 
log their contents. Use `kubectl -n <namespace> logs --follow <pod identifier>` to
see the POST request contents.

In a configuration of a `connectivity-service` for the 4G/5G model (aether-3.0.0)
the following values should be set:
* "core-5g-endpoint": "http://aether-roc-umbrella-sdcore-test-dummy/v1/config/5g",

In a configuration of a `connectivity-service` for the 4G only model (aether-2.1.0)
the following values should be set:
* hss-endpoint http://aether-roc-umbrella-sdcore-test-dummy/v1/config/imsis
* spgwc-endpoint http://aether-roc-umbrella-sdcore-test-dummy/v1/config
* pcrf-endpoint http://aether-roc-umbrella-sdcore-test-dummy/v1/config policies

[Kubernetes]: https://kubernetes.io/
[Helm]: https://helm.sh/
[documentation]: https://docs.onosproject.org/developers/deploy_with_helm/
