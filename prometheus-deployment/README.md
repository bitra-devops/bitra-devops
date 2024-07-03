Notes for reference.

The deployment is done with guidance from : https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/

The deployment has the following:

    -   ClusterRole named 'prometheus-cluster-role' deployed first to ensure permissions through out the cluster role for the clusterrolebinding of 'prometheus-cluster-role-binding' which holds 
        the ServiceAccount opf namespace 'Monitoring'. So all the deployments in monitoring namespace has permissions to 'gte, list and watch' all 'pods, nodes, nodes/proxy, services, endpoints' in the cluster

    -   ConfigMap named 'prometheus-server-conf' is deployed next, which consists of all the configuration files and its data namely 'prometheus.yml' and 'prometheus.rules'\

    -   Deployment named 'prometheus-deployment' is deployed last which contains the pod deployment information and its configurations

    -   Prometheus webui is now accessed by running the below commands

        -   kubectl get pods --namespace monitoring
        -   kubectl port-forward <pod-name> 8080:9090 --namespace monitoring

Issues observered :

    * - 26-06-2024
    Issue : 
    When opened prometheus ui and when navigated to status --> targets, I couldnt see all deployments but only kubestate-metrics and that was also down.
    Afgter multiple tweaking, nothing worked and didnt understand what happened. The fix should generally be somewhere within configmap.
    
    Resolution:
    However, after diff cheking the original files to the ones I made, and no changes obsereved that 'could have' had an impact, I simply stopped and started all instances relating to this sw (ClusterRole, ConfigMap, Deployment).
    Now I see everything and all works as expected. 


    * - 26-06-2024
    Issue :
    Kube-State-Metrics is down and alerts are firing in prometheus web ui.