This folder contains self-signed certificates for use in testing. _DO NOT USE THESE
CERTIFICATES IN PRODUCTION!_

The certificates were generated with the
https://github.com/onosproject/gnxi-simulators/blob/master/pkg/certs/generate_certs.sh 
script as
```bash
generate-certs.sh aether-roc-api.opennetworking.org
```

In this folder they **must** be (re)named
* tls.cacrt
* tls.crt
* tls.key

Use
```bash
openssl x509 -in aether-roc-api/files/certs/tls.crt -text -noout
```
to verify the contents (especially the subject).
