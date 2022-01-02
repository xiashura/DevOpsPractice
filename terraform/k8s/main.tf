
provider "kubernetes" {
  config_path    = "~/.kube/config"
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "scalable-nginx-example"
    labels = {
      App = "ScalableNginxExample"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableNginxExample"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableNginxExample"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "example"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "nginx" {
  metadata {
    name = "nginx-example"
  }
  spec {
    selector = {
      App = kubernetes_deployment.nginx.spec.0.template.0.metadata[0].labels.App
    }
    port {
      protocol = "TCP"
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}


resource "kubernetes_ingress" "nginx" { 
  metadata { 
    name = "nginx-example"
  }

  spec { 
    rule{
      http{
        path{
          path = "/"
          backend {
            service_name = kubernetes_service.nginx.metadata.0.name
            service_port = 80
          }
          
        }
      }
    }
  }

}

