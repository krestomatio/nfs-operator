This is a NFS Operator for Kubernetes. It is based on rook nfs and Ansible operator sdk.

## Install
```bash
# install the operator
make deploy

# add a nfs server object
kubectl apply -f config/samples/nfs_v1alpha1_server.yaml
```
More instructions could be found in the [Ansible Operator Tutorial](https://sdk.operatorframework.io/docs/building-operators/ansible/tutorial/)

## Uninstall
```bash
# delete the nfs server object
# CAUTION with data loss
kubectl delete -f config/samples/nfs_v1alpha1_server.yaml

# uninstall the operator
make undeploy
```

## Want to contribute?
* Use github issues to report bugs, send enhancement, new feature requests and questions
* Join [our telegram group](https://t.me/nfs_operator)
