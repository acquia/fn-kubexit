# Kubexit

fn-kubexit is a mirrored image of [karlkfi/kubexit](https://github.com/karlkfi/kubexit).

## Artifactory
The mirrored image is pushed to [JFrog Artifactory](https://jfrog.com/artifactory/)

## Development

Run [prepare-for-development.sh](prepare-for-development.sh). It will create a mirror directory where you will do your patching.
Do your changes in mirror, don't do any commits or git add.
Run [create-patch.sh](create-patch.sh) once done, it will create a patch in patches out of the uncommitted changes in mirror.

https://jfrog.ais.acquia.io/ui/repos/tree/General/devops-pipeline-dev/fn-kubexit

## Use case
Kubernetes supports multiple containers in a pod, but there is no current feature to manage dependency ordering, so all the containers (other than init containers) start at the same time. This can cause a number of issues with certain configurations, some of which kubexit is designed to mitigate.

- Kubernetes jobs run until all containers have exited. If a sidecar container is supporting a primary container, the sidecar needs to be gracefully terminated after the primary container has exited, before the job will end. Kubexit mitigates this with death dependencies.
- Sidecar proxies (e.g. Istio, CloudSQL Proxy) are often designed to handle network traffic to and from a pod's primary container. But if the primary container tries to make egress call or recieve ingress calls before the sidecar proxy is up and ready, those calls may fail. Kubexit mitigates this with birth dependencies.

## Docker pull
```
docker pull jfrog.ais.acquia.io/devops-pipeline/fn-kubexit:latest
```

## Maintenance
- Update go.mod dependencies and Dockerfile
- Keep fork synced with the latest changes of karlkfi/kubexit
- Commits made to the this forked repo earlier (acquia/fn-kubexit), is applied as a patch.
  - To maintain further, please add more patches to the `/patches` directory
  ```
  git diff origin/<branch> upstream/<branch>  > changes01.patch
  ```