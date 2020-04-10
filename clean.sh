kubectl delete configmap ratelimit-config
kubectl delete svc ratelimit-service
kubectl delete deployment ratelimit-deployment
kubectl delete envoyfilter filter-ratelimit -n istio-system
kubectl delete envoyfilter filter-ratelimit-svc -n istio-system