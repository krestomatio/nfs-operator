[NFS Operator](https://github.com/krestomatio/nfs-operator) creates NFSv4 Ganesha servers in Kubernetes, allowing to set [ownership/permissions](#ownershippermissions) of their NFS export directory; to [autoexpand their PVC](#autoexpansion); and to enable [RWX storage](#rwx-storage) from them:

1. It can set ownership and permissions for [export parent directory](#ownershippermissions) of the (NFS) Server.
2. It is able to [expand/adjust](#autoexpansion) the PVC size of the (NFS) Server automatically, as it grows.
3. It could autogenerate an StorageClass that uses the (NFS) Server for [RWX storage](#rwx-storage).

>It is based on [Ansible Operator SDK](https://sdk.operatorframework.io/docs/building-operators/ansible/tutorial/).

## Dependencies
> A previous version had NFS Rook as a dependency. However, it is no longer the case
* [NFS CSI](https://github.com/kubernetes-csi/csi-driver-nfs) driver `version >= v3.0.0` for dynamic provisioning

## Install

> The Kubernetes Operator in this project is in **Alpha** version. **Use at your own risk**

Follow the next steps to install the NFS Operator:
```bash
# install this operator
make deploy

# create a nfs server cr/object from sample
kubectl apply -f config/samples/nfs_v1alpha1_server.yaml

# follow/check nfs operator logs
kubectl -n nfs-operator-system logs -l control-plane=controller-manager -c manager  -f

# follow sample nfs server cr/object status
kubectl get Server server-sample -o yaml -w
```

## Uninstall
Follow the next steps to uninstall it.
```bash
# delete the nfs server cr/object
# CAUTION with data loss
kubectl delete -f config/samples/nfs_v1alpha1_server.yaml

# uninstall this operator
make undeploy
```

## Configuration Options
For a Custom Resource (CR) sample of a (NFS) Server, see: [sample](config/samples/nfs_v1alpha1_server.yaml)

### Ownership/Permissions
To set export folder ownership, set _server_export_userid_ and _server_export_groupid_. For export folder permissions, set _server_export_permissions_. For instance:
```yaml
spec:
  # Ownership/permissions
  ## Set export folder userid to 48
  server_export_userid: 48
  ## Set export folder groupid to 0
  server_export_groupid: 0
  ## Set export folder permissions to 775
  server_export_permissions: 755
```

### Autoexpansion
When autoexpansion is enabled (_server_pvc_autoexpansion_), if storage available is less than 20% or below _server_pvc_autoexpansion_increment_gib_, PVC storage size is auto incremented according to _server_pvc_autoexpansion_increment_gib_. However, it will not be increment beyond _server_pvc_autoexpansion_cap_gib_ (see related [function](https://github.com/krestomatio/ansible-collection-k8s/blob/c8768df3d9af4ddf7258c31d37cc3f54cc5a4cf6/plugins/module_utils/storage.py#L62)). The following is a config example for it:
```yaml
spec:
  # Autoexpansion
  ## Enable autoexpansion
  server_pvc_autoexpansion: true
  ## Every time autoexpansion is required, increment 5 GiB
  server_pvc_autoexpansion_increment_gib: 5
  ### But no more than 250 GiB
  server_pvc_autoexpansion_cap_gib: 250
```

#### Please, you should take into consideration the following:
* Not all types of storage are compatible. For instance, hostpath is not.
* Kubernetes cluster and (NFS) Server PVC must support expansion of volumes
* In older K8s versions, (NFS) Server pod may be restart when autoexpansion is enabled if Kubernetes feature gate _ExpandInUsePersistentVolumes_ is false. See: Kubernetes [Feature Gates](https://kubernetes.io/docs/reference/command-line-tools-reference/feature-gates/)

### RWX Storage
`StorageClass` (SC) autocreation could be specified in the (NFS) Server CR. The default is to generate one SC.

SC default name is defined using (NFS) Server CR name + suffix **-nfs-sc**. For example: if a CR is created with the name: [**server-sample**](config/samples/nfs_v1alpha1_server.yaml), a storage class named **server-sample-sc** is also created and showed in the CR status.

### Advanced Options
For advanced configuration options available for CR spec, take a look at [the options](https://github.com/krestomatio/ansible-collection-k8s/blob/master/roles/v1alpha1/nfs/server/defaults/main/server.yml)

## Want to contribute?
* Use [Github issues](https://github.com/krestomatio/nfs-operator/issues) to report bugs, send enhancement, new feature requests and questions
* Join [our telegram group](https://t.me/nfs_operator)
