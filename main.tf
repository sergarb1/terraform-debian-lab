terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    local = {
      source = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

provider "docker" {}

# Imagen Debian
resource "docker_image" "debian" {
  name = "debian:latest"
}

# Contraseñas aleatorias
resource "random_password" "alumno" {
  count   = var.num_maquinas
  length  = 12
  special = true
}

resource "random_password" "admin" {
  count   = var.num_maquinas
  length  = 16
  special = true
}

# Contenedores
resource "docker_container" "maquinas" {
  count = var.num_maquinas

  name  = format("maquina%02d", count.index + 1)
  image = docker_image.debian.image_id

  ports {
    internal = 22
    external = 2200 + count.index + 1
  }

  # Sintaxis correcta para Terraform 3.x
  restart = "always"

  command = [
    "bash",
    "-c",
    <<-EOT
      set -e
      apt-get update &&
      DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server sudo &&

      mkdir -p /run/sshd &&
      ssh-keygen -A || true &&

      useradd -m -s /bin/bash alumno &&
      echo "alumno:${random_password.alumno[count.index].result}" | chpasswd &&

      useradd -m -s /bin/bash administrador &&
      echo "administrador:${random_password.admin[count.index].result}" | chpasswd &&

      usermod -aG sudo alumno &&
      usermod -aG sudo administrador &&
      echo "alumno ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers &&
      echo "administrador ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers &&

      exec /usr/sbin/sshd -D
    EOT
  ]
}