kind = "service-router"
name = "helloworld"
routes = [
  {
    match {
      http {
        path_prefix = "/hello-world"
      }
    }

    destination {
      service = "http-echo"
    }
  },
]