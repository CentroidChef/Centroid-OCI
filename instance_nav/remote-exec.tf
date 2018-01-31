resource "null_resource" "remote-exec" {
    depends_on = ["oci_core_instance.NAVInstance1"]
   
   provisioner "file" {
 	connection {
        agent = false
        timeout = "30m"
        host = "${data.oci_core_vnic.InstanceVnic.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
        source = "script.sh"
        destination = "/home/opc/script.sh"
    }	
    provisioner "remote-exec" {
 	connection {
        agent = false
        timeout = "30m"
        host = "${data.oci_core_vnic.InstanceVnic.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      inline = [
        "touch ~/IMadeAFile.Right.Here",
	"chmod +x /home/opc/script.sh",
	"sudo /home/opc/script.sh"
      ]
    }

}

