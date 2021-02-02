resource "random_integer" "id" {
  min = 100
  max = 999

  keepers = {
    app_name = var.name
  }
}

locals {
  project_name   = "${title(random_integer.id.keepers.app_name)} ${title(var.environment)}"
  canonical_name = "${join("-", split(" ", lower(local.project_name)))}"
  project_id     = "${local.canonical_name}-${random_integer.id.result}"
}

resource "google_project" "project" {
  name                = local.project_name
  billing_account     = var.billing_account
  project_id          = local.project_id
  folder_id           = var.folder_id
  org_id              = var.org_id
  auto_create_network = var.auto_create_network
  skip_delete         = var.skip_delete
  labels              = var.labels
}
