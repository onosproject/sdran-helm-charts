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

* aether-roc-gui, 
* aether-roc-api 
* onos-topo
* onos-config 
* onos-gui

to [Kubernetes].
> See the [documentation] for more info.

## Config models
The Aether ROC Umbrella chart controls the Config Model Plugins that are enabled in `onos-config`
Currently 4 versions of the `Aether` model are loaded:

* aether-1.0.0
* aether-2.0.0
* aether-2.1.0
* aether-2.2.0

## Deploy with Authentication enabled

1) install the helm Repo https://cetic.github.io/helm-charts
2) deploy the [dex-ldap-umbrella](https://github.com/onosproject/onos-helm-charts/tree/master/dex-ldap-umbrella)

Then run:
```bash
hm install aether-roc-umbrella ./aether-roc-umbrella --set onos-config.openidc.issuer=http://dex-ldap-umbrella:32000 --set aether-roc-gui.openidc.issuer=http://dex-ldap-umbrella:32000
```

## sdcore-test-dummy 
The chart includes the `sdcore-test-dummy` container for testing the `sdcore-adapter`

> this may be disabled in the chart with `--set import.sdcore-test-dummy.enabled=false`

This runs in the cluster at http://aether-roc-umbrella-sdcore-test-dummy (port 80)

This is a simple nginx server that has been configured to accept POST requests and 
log their contents. Use `kubectl -n <namespace> logs --follow <pod identifier>` to
see the POST request contents.

In a configuration of a `connectivity-service` the following values should be set:
* hss-endpoint http://aether-roc-umbrella-sdcore-test-dummy/v1/config/imsis
* spgwc-endpoint http://aether-roc-umbrella-sdcore-test-dummy/v1/config
* pcrf-endpoint http://aether-roc-umbrella-sdcore-test-dummy/v1/config policies

[Kubernetes]: https://kubernetes.io/
[Helm]: https://helm.sh/
[documentation]: https://docs.onosproject.org/developers/deploy_with_helm/
