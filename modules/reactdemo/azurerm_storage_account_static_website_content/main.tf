#Add index.html to blob storage
locals {
  mime_types = jsondecode(file("${path.module}//file_uploads/mime.json"))
}

resource "azurerm_storage_blob" "example" {
  for_each = fileset("${path.module}/file_uploads", "**/*")
  name                   = each.key
  storage_account_name   = var.storage_account_name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "${path.module}/file_uploads/${each.key}"
  content_type =  lookup(local.mime_types, regex("\\.[^.]+$", each.value), null)
}