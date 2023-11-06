export KUBECONFIG=/home/kcloutie/.kube/config.kind
kubectl apply -f ./manifests
kubectl delete -f ./manifests

The github app config seems to the issue

kubectl logs deployment/pipelines-as-code-controller -n pipelines-as-code | snazy
kubectl logs deployment/pipelines-as-code-watcher -n pipelines-as-code | snazy
kubectl logs deployment/pipelines-as-code-webhook -n pipelines-as-code | snazy

kubectl -n pipelines-as-code delete secret pipelines-as-code-secret
kubectl -n pipelines-as-code create secret generic pipelines-as-code-secret \
--from-file secrets/github-private-key \
--from-literal github-application-id=$(pass show github-app/github-application-id) \
--from-literal webhook.secret=$(pass show github-app/webhook.secret) 

rm -r /tmp/replays
ls -la /tmp/replays
/tmp/replays/push-2023-11-06T21.14.11.314.sh





#!/bin/bash
#
# Replay script with headers and JSON payload to the target controller.
#
# You can switch the targetURL to another one with the -l switch, which defaults
# to http://localhost:8080.
#
# You can customze this target with the env variable: GOSMEE_DEBUG_SERVICE
set -euxf
cd $(dirname $(readlink -f $0))

targetURL="http://controller.paac-127-0-0-1.nip.io"
[[ ${1:-""} == -l ]] && targetURL=${GOSMEE_DEBUG_SERVICE:-"http://localhost:8080"}
curl -sSi -H "Content-Type: application/json" -H 'X-Github-Hook-Installation-Target-Type: integration' -H 'X-Forwarded-For: 140.82.115.40' -H 'X-Hub-Signature-256: sha256=7d0c314789270b0caa6f551a3be9a2887fded13618768752aa03c09ccb91bdf3' -H 'X-Hub-Signature: sha1=20f86970a5a34c1fa52ff4ee298922c2687909f3' -H 'X-Github-Hook-Installation-Target-Id: 419254' -H 'User-Agent: GitHub-Hookshot/89a7806' -H 'X-Forwarded-Host: hook.pipelinesascode.com' -H 'X-Github-Event: 
push' -H 'X-Forwarded-Proto: https' -H 'X-Github-Delivery: 745ab5e8-7ce9-11ee-8168-7871bd3a061d' -H 'X-Github-Hook-Id: 441514450'  -X POST -d @./push-2023-11-06T21.14.11.314.json ${targetURL}