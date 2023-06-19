/* 
  Kubernetes namespace to isolate the resources we are going to create
  in this example.
 */
resource "kubernetes_namespace" "nginx_namespace" {
  metadata {
    name = "nginx-namespace"
  }
}

/* 
  Kubernetes deployment and service to run nginx in the namespace we
  created above.
 */
resource "kubernetes_deployment" "nginx_deployment" {
  metadata {
    name      = "nginx-deployment"
    namespace = kubernetes_namespace.nginx_namespace.metadata[0].name
    labels = {
      app = "nginx"
    }
  }

  spec {
    replicas = 1

    # selector is used by the deployment controller to find which pods
    selector {
      match_labels = {
        app = "nginx"
      }
    }

    # template describes the pods that will be created
    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      # container describes the container that will be created
      spec {
        container {
          image = "nginx:latest"
          name  = "nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

/* 
  Kubernetes service to expose the nginx deployment above.
 */
resource "kubernetes_service" "nginx_service" {
  metadata {
    name      = "nginx-service"
    namespace = kubernetes_namespace.nginx_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      port        = 80
      target_port = 80
    }
  }
}
