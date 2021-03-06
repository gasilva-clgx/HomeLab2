// export TF_VAR_lxc_password='abc123'
variable lxc_password {
    type = string
}

variable backend_bucket_prefix {
    type = string
    default = "dev"
}



variable "containers" {
  type = list(map(string))
  default = [
    {
      name      = "kloadbalancer1"
      fqdn      = "kloadbalancer1.psilva.org" 
      ip = "192.168.50.20"
      cpu = 1
      mem = "512MB"
    }
    ,
    {
      name      = "kmaster1"
      fqdn      = "kmaster1.psilva.org" 
      ip        = "192.168.50.21"
      cpu       = 2
      mem       = "3GB"
    }
    ,
    {
      name      = "kmaster2"
      fqdn      = "kmaster2.psilva.org" 
      ip        = "192.168.50.22"
      cpu       = 2
      mem       = "3GB"
    }
    ,
    {
      name      = "knode1"
      fqdn      = "knode1.psilva.org" 
      ip        = "192.168.50.31"
      cpu       = 2
      mem       = "4GB"
    }
    ,
    {
      name      = "knode2"
      fqdn      = "knode2.psilva.org" 
      ip        = "192.168.50.32"
      cpu       = 4
      mem       = "6GB"
    }
    ,
    {
      name      = "knode3"
      fqdn      = "knode3.psilva.org" 
      ip        = "192.168.50.33"
      cpu       = 8
      mem       = "6GB"
    }
]
}