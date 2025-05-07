# Development Environment Configuration

This directory contains the Terraform variable values (`.tfvars`) for the development environment. These values are used when deploying Azure infrastructure resources for development purposes.

## Files

- **dev.tfvars**: Contains variable values specific to the development environment

## Configuration Details

The development environment configuration typically includes:

1. **Resource Naming**: Development-specific resource naming (usually with a `-dev` or `dev` suffix/prefix)
2. **Resource Sizing**: Smaller, cost-effective resource sizes appropriate for development
3. **Feature Flags**: Enabling/disabling features based on development requirements
4. **Retention Policies**: Shorter retention periods for logs and backups
5. **Access Controls**: Potentially more permissive access controls than production

## Usage

To apply the Terraform configurations using these development variables:

```bash
cd ../../scripts
terraform apply -var-file=../env/dev/dev.tfvars
```

## Important Notes

- The development environment is intended for testing and development purposes only
- It may not have the same security, redundancy, or performance characteristics as production
- Changes to the development environment should still follow proper change management procedures
- Sensitive information should not be stored in these files, even for development
