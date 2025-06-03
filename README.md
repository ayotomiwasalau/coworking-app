# Coworking Space Service Extension
The Coworking Space Service is a set of APIs that enables users to request one-time tokens and administrators to authorize access to a coworking space. This service follows a microservice pattern and the APIs are split into distinct services that can be deployed and managed independently of one another.

## Getting Started

## Deployment Architecture

This project implements a microservice deployment with Kubernetes and a modern CI/CD pipeline using AWS CodeBuild.  Here's an overview of the deployment architecture and process:

### Kubernetes Deployment

The application is deployed to Kubernetes using the following components:

- **Analytics Service**: Main application deployment
- **PostgreSQL**: Database deployment with persistent storage
- **ConfigMaps**: Configuration management for environment variables

### CI/CD Pipeline

The project uses AWS CodeBuild as the CI/CD tool, configured through `buildspec.yaml`. The pipeline follows these key stages:

1. **Pre-build Phase**:
   - Authenticates with Docker Hub and AWS ECR
   - Sets up build environment variables
   - Prepares for container image building

2. **Build Phase**:
   - Builds Docker container for the analytics service
   - Tags images with both build number and 'latest' tag
   - Prepares images for both ECR and Docker Hub

3. **Post-build Phase**:
   - Pushes container images to AWS ECR
   - Maintains both versioned and latest tags


### Deployment Process

To deploy changes to the application:

1. **Code Changes**:
   - Make changes to the analytics service code
   - Commit and push to the repository
   - The CI/CD pipeline automatically triggers

2. **Build Process**:
   - AWS CodeBuild automatically builds the new container image
   - Images are pushed to ECR with version tags
   - Build logs are available in AWS CodeBuild console

3. **Deployment**:
   - Kubernetes deployments are managed through YAML manifests in the `deployment/` directory
   - Use `kubectl apply -f deployment/` to apply changes
   - Rollout status can be monitored using `kubectl rollout status`

### Required Environment Variables

The following environment variables must be configured in your CI/CD pipeline:

- `DOCKERHUB_USERNAME`: Docker Hub username
- `DOCKERHUB_PASSWORD`: Docker Hub password
- `AWS_ACCOUNT_ID`: Your AWS account ID
- `AWS_DEFAULT_REGION`: AWS region for deployment
- `IMAGE_REPO_NAME`: Name of the container image repository

### Monitoring and Maintenance

- Use `kubectl get pods` to check pod status
- Monitor logs using `kubectl logs <pod-name>`
- Restart deployement using `kubectl rollout restart deployment <deployment-name>`

### Best Practices

1. Always test changes in a staging environment before production
2. Use semantic versioning for container images
3. Keep deployment manifests in version control
4. Monitor application logs and metrics
5. Implement proper health checks and readiness probes

For detailed configuration and troubleshooting, refer to the individual YAML files in the `deployment/` directory. 