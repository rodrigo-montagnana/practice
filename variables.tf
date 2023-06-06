# define some vars

# cloud init cfg
data "template_file" "user_data" {
  template = "${file("${path.module}/cloud_init.cfg")}"
}

# Use CloudInit to add the instance
resource "libvirt_cloudinit_disk" "common_init" {
  name      = "commoninit.iso"
  pool      = "default"
  user_data = "${data.template_file.user_data.rendered}"
}

# centos vm name
variable "centos_vm_name" {
  type = string
  default = "centos8stream"
}

# ubuntu vm name
variable "ubuntu_vm_name" {
  type = string
  default = "ubuntu2204jfish"
}

variable "instance_count" {
  type = number
  default = 1
}

# Defining base image for centos
resource "libvirt_volume" "centos_qcow2" {
  name = "centos.qcow2"
  pool = "default"
  source = "https://cloud.centos.org/centos/8-stream/x86_64/images/CentOS-Stream-GenericCloud-8-20220913.0.x86_64.qcow2"
  format = "qcow2"
}

# Defining base image for ubuntu
resource "libvirt_volume" "ubuntu_qcow2" {
  name = "ubuntu.img"
  pool = "default" # List storage pools using virsh pool-list
  source = "https://cloud-images.ubuntu.com/releases/22.04/release-20230518/ubuntu-22.04-server-cloudimg-amd64.img"
  format = "qcow2"
}
