resource "oci_core_instance" "NAVInstance1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "NAVInstance1"
  image = "${var.InstanceImageOCID[var.region]}"
  shape = "${var.InstanceShape}"

  create_vnic_details {
    subnet_id = "${var.subnet_id}"
    display_name = "primaryvnic"
    assign_public_ip = true
    hostname_label = "navexampleinstance1"
  },

  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data = "${base64encode(file(var.BootStrapFile))}"
  }

  timeouts {
    create = "60m"
  }
}
