locals {
  scripts = split("\r", templatefile("${path.module}/scripts/odh-deploy.sh", { 
    access_key = var.AWS_KEY_ID,
    secret_key  = var.AWS_SECRET_KEY,
    redhatToken = var.REDHAT_TOKEN,
    clusterName = var.cluster_name,
    odhProjectName = var.odh_project_name,
    odhProjectDisplayName = var.odh_project_display_name,
    })
  )
}