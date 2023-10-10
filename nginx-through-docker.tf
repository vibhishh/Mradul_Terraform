provider "docker" {}

resource "docker_image" "nginx" {
    name = "nginx:latest"
    keep_locally = false
}

resource "docker_container" "nginx-ctr" {
    name = "terraform-nginx-demo"
    image = docker_image.nginx.name
    ports {
        internal = 80
        external = 80
    }
}
