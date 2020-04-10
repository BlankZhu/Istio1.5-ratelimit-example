# Istio1.5-ratelimit-example
This is a ratelimit example congifurations on Istio 1.5 based on EnvoyFilter

## How to Start

```shell
kubectl apply -f rate_limit.yml
kubectl apply -f rate_limit_filter.yaml
```

## Cleaning Up

```shell
./clean.sh
```

## Validate Ratelimit

To validate the ratelimit, you may:

1. deploy an Nginx with port 80 expose as a server.

2. Modify rate_limit.yml:

   ```yaml
   kind: ConfigMap
   apiVersion: v1
   metadata:
     name: ratelimit-config
   data:
     config.yaml: |
       domain: your-service-domain	# modify this to your service's name
       descriptors:
         - key: remote_address
           rate_limit:	# rate limit parameters here
             unit: minute
             requests_per_unit: 5
   ```

3. Modify rate_limit_filter.yaml:

   ```yaml
   # ...
         patch:
           operation: INSERT_BEFORE
           value:
            name: envoy.rate_limit
            config:
              domain: your-service-domain	# modify this to your service's name
              rate_limit_service:
                grpc_service:
                  envoy_grpc:
                    cluster_name: rate_limit_cluster
                  timeout: 10s
   ```

4. Then use CURL to access your Nginx app. Execute CURL multiple times and you will see the 429 status code.



## Attention

1. All these configurations are applied to namespace `default` and `istio-system`.
2. For more config settings, check for the documents in envoyproxy.io/docs/envoy/latest/.
