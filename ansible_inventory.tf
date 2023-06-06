resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tmpl",
    {
     ansible_group_centos = libvirt_domain.centos.*.description,
     hostname_centos      = libvirt_domain.centos.*.name,
     ansible_group_ubuntu = libvirt_domain.ubuntu.*.description,
     hostname_ubuntu      = libvirt_domain.ubuntu.*.name
    }
  )
  filename = "${path.module}/ansible/roles/inventories/inventory"
}
