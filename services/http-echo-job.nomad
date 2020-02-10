job "docs" {
  datacenters = ["dc1"]

  group "example" {
    count = 3
    task "server" {
      service {
        tags = ["urlprefix-/"]
        port = "http"
        name = "http-echo"

        check {
          type = "http"
          port = "http"
          path = "/"
          interval = "5s"
          timeout = "1s"
        }

        connect {
          sidecar_service {}
        }
      }

      artifact {
       source = "https://github.com/hashicorp/http-echo/releases/download/v0.2.3/http-echo_0.2.3_linux_amd64.zip"
       destination = "/opt/nomad/"
      }

      driver = "exec"

      config {
        command = "/opt/nomad/http-echo"
        args = [
          "-listen", ":5678",
          "-text", "hello world"
        ]
      }
      
      resources {
        network {
          mbits = 10
          port "http" {
            static = "5678"
            netmask = "192.168.95.0/24"
          }
        }
      }
    }
  }
}
