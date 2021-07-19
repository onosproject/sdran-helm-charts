# Creating new Org with VCS
To create a new Organization and VCS, call the grafana-create-orgs.sh script

> If you want to add at startup, instead add them to the `values.yaml` under `grafana.orgs`.

Call the script like:

`grafana-create-orgs.sh <ADMINUSER> <ADMINPASS> <umbrella-chart-name> <grafana-server> <dashboard-folder> orgs...`

e.g.
```bash
PATH=$PATH:. grafana-create-orgs.sh admin Ts8k0hvsZZD058JsqOl8w332YUNs8GAAEpYWCmJu aether-roc-umbrella localhost:8183/grafana \
  ../dashboards/vcs "siemens[siemens-munich-cameras siemens-mannheim-cameras siemens-mannheim-labs]"
```

1) cd in to this `scripts` directory

1) specify the Org and VCS's like `"org1[vcs1 vcs2]" "org2[vcs1 vcs2]"` 

1) To get the Grafana password use
    1) `kubectl get secret --namespace micro-onos aether-roc-umbrella-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo`

1) Port forward `aether-roc-gui` to get grafana on `localhost:8183/grafana`
    1) `kubectl -n micro-onos port-forward $(kubectl -n micro-onos get pods -l type=arg -o name) 8183:80`
