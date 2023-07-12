terraform {
  cloud {
    organization = "tfe-learning-01"

    workspaces {
      name = "tfe-project01"
    }
  }
}