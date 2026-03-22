# Shooter Timer App - Docker Deployment Guide

## Overview
This is a containerized Shooter Timer web application for competitive shooters. The app is deployed using Docker with automated CI/CD via GitHub Actions.

**URL:** https://shooters.fabo011-cloud.de/

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
services:
  shooter-app:
    image: ghcr.io/fabo011/shooter-app:latest
    container_name: shooter-timer
    ports:
      - "8066:8066"
    restart: unless-stopped
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
