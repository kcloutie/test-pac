export KUBECONFIG=/home/kcloutie/.kube/config.kind
kubectl apply -f ./manifests

The github app config seems to the issue

kubectl logs deployment/pipelines-as-code-controller -n pipelines-as-code | snazy
kubectl logs deployment/pipelines-as-code-watcher -n pipelines-as-code | snazy
kubectl logs deployment/pipelines-as-code-webhook -n pipelines-as-code | snazy

kubectl -n pipelines-as-code delete secret pipelines-as-code-secret
kubectl -n pipelines-as-code create secret generic pipelines-as-code-secret \
--from-file secrets/github-private-key \
--from-literal github-application-id=$(pass show github-app/github-application-id) \
--from-literal webhook.secret=$(pass show github-app/webhook.secret)

ls -la /tmp/replays
