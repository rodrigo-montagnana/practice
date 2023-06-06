# Define KVM domain to create

resource "libvirt_volume" "ubuntu_disk" {
  count         = "${var.instance_count}"
  name          = "${var.ubuntu_vm_name}_disk_${count.index}"
  base_volume_id = "${libvirt_volume.ubuntu_qcow2.id}"
}

resource "libvirt_domain" "ubuntu" {
  vcpu        = 2
  name        = "${var.ubuntu_vm_name}${count.index}"
  count       = "${var.instance_count}"
  memory      = "756"
  description = "backend"

  network_interface {
    network_name = "default" # List networks with virsh net-list
  }

  disk {
    volume_id = "${element(libvirt_volume.ubuntu_disk.*.id, count.index)}"
  }

  cloudinit = "${libvirt_cloudinit_disk.common_init.id}"

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}

# Output Server IP
output "ubuntu_ip" {
  value = libvirt_domain.ubuntu[*].network_interface.0.addresses.0
}
