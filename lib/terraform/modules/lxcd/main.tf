terraform {
    required_providers {
        lxd = {
            source = "terraform-lxd/lxd"
            version = "1.7.1"
        }
    }
}

provider "lxd" {

    generate_client_certificates = true
    accept_remote_certificate = true

    lxd_remote {
        name = "captain"
        scheme = "https"
        address = "192.168.48.3"
        password = "${var.lxc_password}"
        default = true
    }
}


resource "lxd_container" "vms" {

  count = length(var.containers) 

  name              = var.containers[count.index].name
  image             = "images:ubuntu/focal/cloud"
  ephemeral         = "false"
  type              = "virtual-machine"
  wait_for_network  = true
  profiles          = ["default"]


  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = "default"
      size = var.containers[count.index].disk
    }
  } 

        config = {
        "limits.cpu": var.containers[count.index].cpu
        "limits.memory": var.containers[count.index].mem
        "user.network-config" : <<-EOL
    version: 1
    config:
      - type: physical
        name: enp5s0
        subnets:
          - type: static
            ipv4: true
            address: ${var.containers[count.index].ip}
            netmask: 255.255.240.0
            gateway: 192.168.50.1
            control: auto
      - type: nameserver
        address:
          - 192.168.49.2
          - 192.168.49.1
        search:
          - local
              EOL

        "user.user-data" : <<-EOL
    #cloud-config
    timezone: America/Toronto
    hostname: ${var.containers[count.index].name}
    fqdn: ${var.containers[count.index].fqdn}
    manage_etc_hosts: true
    package_upgrade: true
    users:
      - name: ${var.containers[count.index].username}
        home: /home/${var.containers[count.index].username}
        shell: /bin/bash
        sudo: 'ALL=(ALL) NOPASSWD: ALL'
        lock_passwd: false
        passwd: ${var.containers[count.index].userpass}
        ssh-authorized-keys:
          - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICST/387GTgu9qAPn92kzTsEyaXu6fdPryg4z+1azovj gabriel@marim
    ssh_pwauth: true
    disable_root: true
    packages:
      - openssh-server
    bootcmd:
      - date > /etc/server_release
              EOL
    }
}
