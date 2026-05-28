# 🚀 Node.js CI/CD Pipeline with Jenkins Shared Library, Docker & GitHub

This project demonstrates a complete CI/CD pipeline for a Node.js application using Jenkins, Docker, and a Jenkins Shared Library to modularise and reuse pipeline logic.

The pipeline automates versioning, testing, Docker image creation, image publishing, and Git commit updates.

---

## 📌 Architecture Overview

The CI/CD flow is implemented using a Jenkins Shared Library:

- Jenkinsfile acts as a lightweight configuration layer
- Shared Library contains all pipeline logic (`nodeCiPipeline`)
- Parameters are passed dynamically from Jenkinsfile

---

## ⚙️ CI/CD Pipeline Flow

The pipeline executes the following stages:

1. Checkout source code from GitHub  
2. Increment application version (npm minor version bump)  
3. Run unit tests to validate code integrity  
4. Build Docker image using version + build number tag  
5. Push Docker image to Docker Hub  
6. Commit updated version back to GitHub  

---

## 🧱 Project Structure

node-project/
├── app/
│   ├── package.json
│   ├── index.js
│   └── tests/
├── Jenkinsfile
├── Dockerfile
└── Jenkins Shared Library
    └── vars/
        └── nodeCiPipeline.groovy

---

## 🧠 Jenkins Shared Library Usage

### Jenkinsfile

@Library('jenkins-shared-library') _

nodeCiPipeline(
    nodeTool: 'my-nodejs',
    branch: 'main',
    gitCredentials: 'GitHub-credentials',
    gitRepo: 'https://github.com/oadenekan/node-project.git',
    appDirectory: 'app',
    dockerCredentials: 'docker-hub-repo',
    dockerRepo: 'olusolaayeni/demo-app',
    gitPushCredentials: 'github-jenkins-token',
    githubRepo: 'oadenekan/node-project'
)

---

## 🔧 Shared Library Implementation

The pipeline logic is fully abstracted into:

nodeCiPipeline.groovy

Key responsibilities:

- Git checkout
- Version increment using npm
- Test execution
- Docker image build & push
- Git commit & push automation

---

## 🔐 Credentials Used

Configured in Jenkins:

- GitHub-credentials → cloning repo
- github-jenkins-token → pushing version updates
- docker-hub-repo → Docker Hub authentication

---

## 🐳 Docker Strategy

Images are tagged using:

- npm version (semantic versioning)
- Jenkins build number

Example:

olusolaayeni/demo-app:1.2.0-45

---

## 🧪 Testing Strategy

Tests run before Docker build:

cd app
npm ci
npm test

If tests fail, pipeline stops execution.

---

## 📈 Key DevOps Concepts Demonstrated

- CI/CD automation with Jenkins
- Shared Library abstraction
- Docker image versioning strategy
- Secure credential handling in pipelines
- Automated Git workflow integration
- Build failure gating via tests

---

## 🚀 Future Improvements

- Kubernetes deployment automation
- Terraform infrastructure provisioning
- Helm chart integration
- Blue/green deployment strategy
- Prometheus + Grafana monitoring

---

## 👨‍💻 Author

Olusola Ayeni
