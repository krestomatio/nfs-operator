# Repository guidance

Follow this repository's documentation and any more specific instructions for
the files being changed.

## Repository scope

- This Ansible Operator SDK project reconciles NFS-Ganesha custom resources used
  as managed Moodle shared storage by the LMS meta-operator.
- `watches.yaml`, `playbooks/`, `config/crd/`, samples, bundle metadata, and the
  pinned `krestomatio.k8s` collection define provisioning and lifecycle behavior.
- Preserve CRD identity, exports/endpoints, PVC/storage behavior, labels, status,
  and suspend/delete semantics; downstream Moodle readiness depends on them.

## Validation

- Initialize `hack/mk` and `molecule`, then run `make ansible-lint` and
  `make molecule`. Regenerate and validate the bundle when API, RBAC, samples, or
  release metadata changes.
- Storage tests require a disposable cluster. Never point test deployment or
  deletion targets at a cluster containing retained data.
