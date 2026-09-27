# vprofile EKS Infrastructure

Terraform configuration for the `vprofile-eks-cluster86440` Amazon EKS cluster in `us-east-1`.

## Infrastructure

- VPC CIDR: `10.0.0.0/16`
- Two public subnets in `us-east-1a` and `us-east-1b`, with direct internet access through an internet gateway
- EKS managed node group using `t3.large` instances, with minimum, desired, and maximum sizes of 1, 1, and 2
- EBS CSI managed add-on with IAM Roles for Service Accounts (IRSA); EKS manages its Kubernetes service account
- S3 remote state at `s3://gitops-terraformcode86440/eks/terraform.tfstate`, with no DynamoDB lock table

There are no private subnets or NAT gateways. Worker nodes use public subnets, so review network access controls before deploying workloads.

## Prerequisites

- Terraform CLI
- AWS credentials configured for an identity with permission to manage the EKS, EC2, IAM, and S3 resources
- The configured S3 state bucket must already exist and be accessible

## Usage

Run these commands from the repository directory:

```sh
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
```

Terraform uses the S3 backend configured in `backend.tf`. The configuration does not create the state bucket.

To remove the resources managed by this configuration:

```sh
terraform destroy
```

## Outputs

- `cluster_endpoint`: EKS Kubernetes API endpoint
- `cluster_name`: EKS cluster name
- `cluster_arn`: EKS cluster ARN