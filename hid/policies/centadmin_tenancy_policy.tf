/*
 * This creates centroid_admins policy in root compartment and give that group full access in tenancy. Just like default administrators group
 */

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}

provider "oci" {
  tenancy_ocid = "${var.tenancy_ocid}"
  user_ocid = "${var.user_ocid}"
  fingerprint = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region = "${var.region}"
}



resource "oci_identity_policy" "p" {
  name = "centroid_admins_policy"
  compartment_id = "${var.compartment_ocid}"
  description = "Policy to give centroid_admins tenant admin access"
  statements = ["Allow group centroid_admins to manage all-resources in TENANCY"]
}


