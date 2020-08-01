### Terraform
This repo contains the terraform setup for the OCF, which is used to interact
with a few APIs and make sure that resources and access are properly version
controlled.

Local plans are fine, but local applies are highly discouraged as it can cause
drift from the state stored in this repo.

To get debug information, try setting `TF_LOG=DEBUG` when planning or applying.

#### Google Cloud Platform
To locally plan or apply, you'll first need a JSON credentials file from GCP
IAM. Then, export the path to that file in a `GOOGLE_CREDENTIALS` environment
variable so that terraform knows where to find it. Depending on your access,
this may not let you plan or apply apply on all resources, so relying on the
plan on a PR and the apply after merging to master is probably best.

#### GitHub
To locally plan or apply, you'll need to export a `GITHUB_TOKEN` environment
variable with a personal access token. Again, depending on your access, this
may not let you plan or apply on all resources, so relying on the plan on a PR
and the apply after merging to master is probably best.
