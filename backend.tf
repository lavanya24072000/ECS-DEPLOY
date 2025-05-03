terraform {
  backend "remote" {
    organization = "sample-001"
 
    workspaces {
      name = "ECS-DEPLOY"
    }
  }
}
