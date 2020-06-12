based on `Session2/homework/authors/deployment.yaml`

* added Deployment: `authors-v2`
* added DestinationRule: `authors`  with trafficPolicy (RANDOM loadbalancer and Circuit Breaker)

based on `Session2/homework/books/deployment.yaml`

* added Deployment: `books-v2`
* added DestinationRule: `books` with trafficPolicy (ROUND_ROBIN loadbalancer and Circuit Breaker)

Thes changes just copied from `1-canary` and not important for `circuit-breaking`

The HTTP rooting by header added (the same behavior as for 2-dev-environement). 

Session2/homework/frontend/deployment.yaml

* added Deployment: frontend-v2
* added DestinationRule: frontend

Session2/homework/gateway/course-gateway-controller.yml
* updated VirtualService: course-istio  
  