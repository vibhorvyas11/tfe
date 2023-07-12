locals {
    options_deletion_protection_true = {
        allow_stopping_for_update = true
        deletion_protection       = false
        preemptible
    }
    shielded_config_vars = {
              enable_secure_boot  = true
              enable_vtpm         = true
              enable_integrity_monitoring = true
    }
}
module "compute-engine" {
    for_each = {
        for k, v in try(var.compute-vars , {}): k => v if v.delete_vm != true
    }
    source = " "
    version = "1.0.1"
    project_id = var.project_id
    environment = each.value.environment
    environment_ptr = each.value.environment_ptr
    project_dns_id = each.value.project_dns_id
    description = each.value.description
    region = each.value.region
    options = each.value.options_deletion_protection_true
    zones = each.value.zones
    name = each.key
    address_reserve = try(each.value.address_reserve, false)
    host_project = try(each.value.host_project, null)
    subnetwork = try(each.value.subnetwork, null)
    instance_type = each.value.instance_type
    network_interfaces = each.value.network_interfaces
    resource_policies = try(each.value.resource_policies, "")
    boot_disk = each.value.boot_disk
    attached_disks = each.value.attached_disks
    metadata = {
        enable-osconfig = "TRUE"
        enable-guest-attributes = "TRUE"
        windows_startup-script-ps1 = try("${file(each.value.windows_startup_script_ps1)}", null)
        startup-script = try("${file(each.value.linux_startup_script)}", null)
    }
    group = each.value.group
    instance_group = each.value.instance_group
    metadata_startup_script = try("${file(each.value.metadata_startup_script)}", null)
    service_account = each.value.service_account
    scopes = local.sa_scopes
    shielded_config = local.shielded_config_vars
    tag             = each.value.tags
    labels = each.value.labels
}
module "cloud_storage_bucket" {
    for_each = {
        for k, v in try(var.cloud_storage, {}): k => v if v.delete_bucket != true
    }
    source = " "
    version = "1.0.1"

}
