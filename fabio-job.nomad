job "fabio" {
  datacenters = ["dc1"]
  type = "system"

  group "fabio" {
    task "fabio" {
      driver = "docker"
      env {
        "CONSUL_HTTP_ADDR" = "192.168.95.3:8500"
      }
      config {
        image = "fabiolb/fabio"
        network_mode = "host"
        args = [
          "-registry.consul.addr", "${CONSUL_HTTP_ADDR}"
        ]
      }

      resources {
        cpu    = 200
        memory = 128
        network {
          mbits = 20
          port "lb" {
            static = 9999
          }
          port "ui" {
            static = 9998
          }
        }
      }
    }
  }
}