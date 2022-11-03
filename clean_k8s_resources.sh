# !/bin/bash

set -o xtrace
if [[ $# -eq 1 ]]
then
  CURRENT_NS=${1}
else
  CURRENT_NS=$(kubectl config get-contexts --no-headers | grep '*' | awk '{print $NF}')
fi

# Kubernetes Cheat Sheet - webpage/blog
if items=$(kubectl -n ${CURRENT_NS}  get deployment -o name) && [ ! -z "$items" ]
then
  kubectl -n ${CURRENT_NS}  delete ${items}
fi
if items=$(kubectl -n ${CURRENT_NS}  get pod -o name) && [ ! -z "$items" ]
then
  kubectl -n ${CURRENT_NS}  delete ${items}
fi
if items=$(kubectl -n ${CURRENT_NS}  get jobs -o name) && [ ! -z "$items" ]
then
  kubectl -n ${CURRENT_NS}  delete ${items}
fi
if items=$(kubectl -n ${CURRENT_NS}  get secret -o name | grep -v default) && [ ! -z "$items" ]
then
  kubectl -n ${CURRENT_NS}  delete ${items}
fi
if items=$(kubectl -n ${CURRENT_NS}  get configmap -o name | grep -v kube) && [ ! -z "$items" ]
then
  kubectl -n ${CURRENT_NS}  delete ${items}
fi
