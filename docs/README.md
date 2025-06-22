# NFS Operator

This operator simplifies deployment and management of NFSv4 Ganesha servers within Kubernetes environments. It offers advanced features for NFS exports, including:

* Ownership and Permission Control: Set ownership and permissions for the NFS export directory.
* Automatic PVC Expansion: Configure automatic scaling of the underlying Persistent Volume Claim (PVC) as storage demands grow.
* RWX Storage Class Provisioning: Automatically create a StorageClass for RWX (read-write-execute) access to the NFS export.

**Key Technologies:**

* Kubernetes
* Ansible Operator SDK
* NFS-Ganesha

## Installation

**Important Note:** This NFS Operator is currently in **Beta** stage. Proceed with caution in production deployments.

1. **Install Operator:**
```bash
# Ensure prerequisites are met
kubectl apply -k https://github.com/krestomatio/nfs-operator/config/default?ref=v0.4.25
```

2. **Configure NFS Instance:**
- Download and modify [this sample](https://raw.githubusercontent.com/krestomatio/nfs-operator/v0.4.25/config/samples/nfs_v1alpha1_ganesha.yaml) file to reflect your specific instance. This file defines the desired configuration for your NFS Ganesha deployment.
```bash
curl -sSL 'https://raw.githubusercontent.com/krestomatio/nfs-operator/v0.4.25/config/samples/nfs_v1alpha1_ganesha.yaml' -o nfs_v1alpha1_ganesha.yaml
# modify nfs_v1alpha1_ganesha.yaml
```

3. **Deploy NFS:**
- Deploy a NFS instance using the modified configuration:
```bash
kubectl apply -f nfs_v1alpha1_ganesha.yaml
```

4. **Monitor Logs:**
- Track the NFS Operator logs for insights into the deployment process:
```bash
kubectl -n nfs-operator-system logs -l control-plane=controller-manager -c manager -f
```

- Monitor the status of your deployed NFS instance:
```bash
kubectl get -f nfs_v1alpha1_ganesha.yaml -w
```

## Uninstall

1. **Delete NFS Instance:**
```bash
# Caution: This step leads to data loss. Proceed with caution.
kubectl delete -f nfs_v1alpha1_ganesha.yaml
```

2. **Uninstall Operator:**
```bash
kubectl delete -k https://github.com/krestomatio/nfs-operator/config/default?ref=v0.4.25
```

## Configuration

NFS Ganesha custom resource (CR) can be configure via its spec field. NFS Ganesha CR spec supports all the the variables in [v1alpha1.nfs.ganesha ansible role](https://krestomatio.com/docs/ansible-collection-k8s/roles/v1alpha1.nfs.ganesha/defaults/main/ganesha) as fields. These variables can be specified directly in the NFS CR YAML manifest file, allowing for customization of the Ganesha instance during deployment. Refer to the official [v1alpha1.nfs.ganesha ansible role documentation](https://krestomatio.com/docs/ansible-collection-k8s/roles/v1alpha1.nfs.ganesha/) for a comprehensive list of supported fields.

## Contributing

* Report bugs, request enhancements, or propose new features using GitHub issues.
