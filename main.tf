terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
    random = {
      source = "hashicorp/random"
    }
    template = {
      source = "hashicorp/template"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "libvirt" {
  ## Configuration options
  uri = "qemu:///system"
}
