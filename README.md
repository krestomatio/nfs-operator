> The Kubernetes Operator in this project is in **Alpha** version. **Use at your own risk**

[NFS Operator](https://github.com/krestomatio/nfs-operator) adds three important features for a NFS in Kubernetes. It allows setting NFS export [ownership/permissions](#ownershippermissions), enables PVC [autoexpansion](#autoexpansion) and reduces the number of manual [resource definitions](#storageclass). It is based on [Rook NFS v1.6](https://github.com/rook/rook/blob/release-1.6/Documentation/nfs.md) and [Ansible Operator SDK](https://sdk.operatorframework.io/docs/building-operators/ansible/tutorial/). Thus, the new features are in addition to those in Rook NFS. The extra functions it adds on top of Rook NFS are:

1. It is able to set ownership and permissions for the (NFS) Server export
2. It is able to autoexpand/adjust the value of (NFS) Server PVC storage size
3. It automatically creates a StorageClass with a (NFS) Server

There are some restrictions compared to Rook NFS:
* Only one export/PVC per (NFS) Server

## Prerequisites
Prerequisites are the same as [Rook NFS](https://github.com/rook/rook/blob/release-1.6/Documentation/nfs.md#prerequisites). Therefore, **Rook NFS v1.6 must be installed**.

## Install
Follow the next steps to install the NFS Operator as well as Rook NFS v1.6 operator. Notice that CRs should be installed in the namesapace **rook-nfs**. It is the default namespace for (NFS) Servers in Rook NFS Operator installation:
```bash
# install rook nfs operator v1.6
make deploy-rook

# install this operator
make deploy

# add a nfs server cr/object
kubectl -n rook-nfs apply -f config/samples/nfs_v1alpha1_server.yaml

# follow/check nfs operator logs
kubectl -n nfs-operator-system logs -l control-plane=controller-manager -c manager  -f

# follow sample nfs server cr/object status
kubectl -n rook-nfs get Server server-sample -o yaml -w
```

## Uninstall
Follow the next steps to uninstall it.
```bash
# delete the nfs server cr/object
# CAUTION with data loss
kubectl -n rook-nfs delete -f config/samples/nfs_v1alpha1_server.yaml

# uninstall this operator
make undeploy

# uninstall rook nfs operator v1.6
make undeploy-rook
```

## Configuration Options
For a CRD sample, see: [sample](config/samples/nfs_v1alpha1_server.yaml)

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
When autoexpansion is enabled (_server_pvc_autoexpansion_), if storage available is less than 20% or below _server_pvc_autoexpansion_gib_, PVC storage size is auto incremented according to _server_pvc_autoexpansion_gib_. However, it will not be increment beyond _server_pvc_autoexpansion_cap_gib_ (see related [function](https://github.com/krestomatio/ansible-collection-k8s/blob/c8768df3d9af4ddf7258c31d37cc3f54cc5a4cf6/plugins/module_utils/storage.py#L62)). The following is a config example for it:
```yaml
spec:
  # Autoexpansion
  ## Enable autoexpansion
  server_pvc_autoexpansion: true
  ## Every time autoexpansion is required, increment 5 GiB
  server_pvc_autoexpansion_gib: 5
  ### But no more than 250 GiB
  server_pvc_autoexpansion_cap_gib: 250
```

#### Please, you should take into consideration the following:
* Not all types of storage are compatible. For instance, hostpath is not.
* Kubernetes cluster and (NFS) Server PVC must support expansion of volumes
* In older K8s versions, (NFS) Server pod may be restart when autoexpansion is enabled if Kubernetes feature gate _ExpandInUsePersistentVolumes_ is false. See: Kubernetes [Feature Gates](https://kubernetes.io/docs/reference/command-line-tools-reference/feature-gates/)

### StorageClass
A class is automatically created with suffix **-nfs-sc**. If a CR is created with the name: [**server-sample**](config/samples/nfs_v1alpha1_server.yaml), a storage class named **server-sample-nfs-sc** is also created and showed in the CR status.

### Advanced Options
For advanced configuration options available for CR spec, take a look at [the options](https://github.com/krestomatio/ansible-collection-k8s/blob/master/roles/v1alpha1/nfs/server/defaults/main/server.yml)

## Want to contribute?
* Use [Github issues](https://github.com/krestomatio/nfs-operator/issues) to report bugs, send enhancement, new feature requests and questions
* Join [our telegram group](https://t.me/nfs_operator)
