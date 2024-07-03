#!/bin/bash

echo "Do you want to delete instances of kube-metrics, monitoring, or both? (Enter 'kube-metrics', 'monitoring', or 'both')"
read choice

if [[ $choice == "kube-metrics" || $choice == "both" ]]; then
    kubectl delete clusterrolebinding kube-state-metrics
    kubectl delete clusterrole kube-state-metrics
    kubectl delete deploy -n kube-system kube-state-metrics
    kubectl delete svc -n kube-system kube-state-metrics

    echo "..........................metrics server related all instances are deleted"
fi

if [[ $choice == "monitoring" || $choice == "both" ]]; then
    kubectl delete deploy -n monitoring prometheus-deployment
    kubectl delete configmap -n monitoring prometheus-server-conf
    kubectl delete clusterRole prometheus-cluster-role
    kubectl delete clusterRolebinding prometheus-cluster-role-binding

    echo "..........................prometheus related all instances are deleted"
fi

if [[ $choice != "kube-metrics" && $choice != "monitoring" && $choice != "both" ]]; then
    echo "Invalid input. Please enter 'kube-metrics', 'monitoring', or 'both'."
fi
