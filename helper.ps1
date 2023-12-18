# https://pipelinesascode.com/dev/
# https://github.com/openshift-pipelines/pipelines-as-code/blob/8f990bf5f348f6529deaa3693257907b42287a35/.github/workflows/kind-e2e-tests.yaml#L90

# All in one setup for e2e testing
make dev

export KUBECONFIG=/home/kcloutie/.kube/config.kind
# Get forwarder url
kubectl get pods -n gitea
kubectl logs gosmee-???? -n gitea

# Add webhook secret
kubectl -n pipelines-as-code delete secret pipelines-as-code-secret
kubectl -n pipelines-as-code create secret generic pipelines-as-code-secret \
--from-file secrets/github-private-key \
--from-literal github-application-id=$(pass show github-app/github-application-id) \
--from-literal webhook.secret=$(pass show github-app/webhook.secret) 


kubectl apply -f ./manifests
kubectl delete -f ./manifests

The github app config seems to the issue

kubectl logs deployment/pipelines-as-code-controller -n pipelines-as-code | snazy
kubectl logs deployment/pipelines-as-code-watcher -n pipelines-as-code | snazy
kubectl logs deployment/pipelines-as-code-webhook -n pipelines-as-code | snazy

kubectl get events --sort-by='.metadata.creationTimestamp' -n pac-e2e-test-j5nlr


export KUBECONFIG=/home/kcloutie/.kube/config.kind
export TEST_GITHUB_API_URL=api.github.com
export TEST_GITHUB_REPO_INSTALLATION_ID="43763482"
export TEST_GITHUB_TOKEN=????????????????????????
export TEST_GITHUB_REPO_OWNER=kcloutie/test-pac
export TEST_GITHUB_REPO_OWNER_GITHUBAPP=kcloutie/test-pac
export TEST_EL_URL=http://controller.paac-127-0-0-1.nip.io
export TEST_EL_WEBHOOK_SECRET=$(pass show github-app/webhook.secret)
export TEST_GITEA_API_URL=http://localhost:3000
export TEST_GITEA_USERNAME=pac
export TEST_GITEA_PASSWORD=pac
export TEST_GITEA_REPO_OWNER=pac/pac
export TEST_GITEA_SMEEURL=https://hook.pipelinesascode.com/KeaQJYHIiKea
# export TEST_NOCLEANUP=true



cd test/; go test -tags=e2e -v -run TestGithub .
cd test/; go test -timeout=20m -tags=e2e -v -run TestGitea .
go test -tags=e2e  -v -run ^TestGiteaParamsChangedFilesCEL$ .

curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ??????" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/app/installations


rm -r /tmp/replays
ls -la /tmp/replays

git mv files/1_file.txt files/renamed_1_file.txt


for ($i = 0; $i -lt 50; $i++) {
  (New-Guid | Select-Object -ExpandProperty Guid) | Set-Content -Path "files/$($i)_file.txt" -Force
}
