# Shooter Timer App - Docker Deployment Guide

## Overview
This is a containerized Shooter Timer web application for competitive shooters. The app is deployed using Docker with automated CI/CD via GitHub Actions.

## Quick Start - Local Development

### Prerequisites
- Docker Desktop installed
- Docker Compose installed

### Run Locally
```bash
# Navigate to the project directory
cd ShooterApp

# Build and start the container
docker-compose up --build

# Access the app
Open your browser and go to: http://localhost:8066
```

### Stop the container
```bash
docker-compose down
```

## Docker Deployment

### Build Docker Image
```bash
docker build -t shooter-timer:latest .
```

### Run Docker Container
```bash
docker run -p 8066:8066 --name shooter-timer shooter-timer:latest
```

### Using Docker Compose (Recommended)
```bash
docker-compose up -d
```

## GitHub Container Registry (GHCR) Deployment

### Automatic CI/CD Pipeline
- The GitHub Actions workflow automatically builds and pushes your image to GHCR on every push to `main` branch
- Images are tagged with:
  - `latest` (for main branch)
  - Branch name
  - Git SHA
  - Semantic versioning (if you use tags)

### Manual Push to GHCR
```bash
# Login to GHCR
docker login ghcr.io -u <username> -p <personal_access_token>

# Build and tag image
docker build -t ghcr.io/fabo011/shooter-app:latest .

# Push to GHCR
docker push ghcr.io/fabo011/shooter-app:latest
```

### Pull and Run from GHCR
```bash
# Login to GHCR
docker login ghcr.io

# Run the container
docker run -p 8066:8066 ghcr.io/fabo011/shooter-app:latest
```

## Docker Compose with GHCR
To use the GHCR image in docker-compose:

```yaml
version: '3.8'

services:
  shooter-app:
    image: ghcr.io/fabo011/shooter-app:latest
    container_name: shooter-timer
    ports:
      - "8066:8066"
    restart: unless-stopped
```

## Project Structure
```
ShooterApp/
├── index.html                 # Main application
├── Dockerfile                 # Container configuration
├── docker-compose.yml         # Local development setup
├── nginx.conf                 # Nginx web server configuration
├── .dockerignore              # Files to exclude from Docker build
└── .github/
    └── workflows/
        └── build-and-push.yml # GitHub Actions CI/CD pipeline
```

## Configuration

### Port
- The app runs on port **8066** (configurable in docker-compose.yml and nginx.conf)

### Environment
- Lightweight nginx:alpine base image (~150MB)
- Gzip compression enabled
- Static file caching optimized
- Health checks enabled

## Features

### Application
- Mobile-first responsive design
- Shooter timer with countdown
- Leaderboard with rankings
- Burger menu for navigation
- Add/manage shooters
- Full reset functionality
- Local storage for persistence

### Docker
- Lightweight Alpine Linux base
- Health checks
- Auto-restart on failure
- Optimized for production

## Troubleshooting

### Port Already in Use
```bash
# Change port in docker-compose.yml or run:
docker run -p 9000:8066 shooter-timer:latest
```

### Image Won't Build
```bash
# Clear Docker cache
docker builder prune

# Rebuild
docker-compose up --build
```

### GHCR Push Fails
- Ensure you have a GitHub Personal Access Token with `write:packages` scope
- Check GitHub Actions workflow permissions in repository settings

## Health Check
The container includes a health check that verifies the app is running:
```bash
docker ps  # Look for the "healthy" status
```

## Next Steps
1. Push to GitHub to trigger automated builds
2. Access your image at: `ghcr.io/fabo011/shooter-app:latest`
3. Deploy to any Docker-compatible platform (Docker Swarm, Kubernetes, etc.)

## Support
For issues or questions, refer to:
- [Docker Documentation](https://docs.docker.com/)
- [GitHub Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
