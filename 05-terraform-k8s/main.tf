terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~>2.30"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "nginx-terraform"
    labels = {
      app = "nginx-terraform"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "nginx-terraform"
      }
    }
    
    template {
      metadata {
        labels = {
          app = "nginx-terraform"
	}
      }
      
      spec {
        container {
	  name = "nginx"
	  image = "nginx:latest"

	  port {
	    container_port = 80
	  }

	  resources {
	    limits = {
	      cpu = "200m"
	      memory = "128Mi"
	    }
	    requests = {
	      cpu = "100m"
	      memory = "64Mi"
	    }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = "nginx-terraform-service"
  }

  spec {
    selector = {
      app = "nginx-terraform"
    }

    port {
      port = 80
      target_port = 80
    }

    type = "NodePort"
  }
}
