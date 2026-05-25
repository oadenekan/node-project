pipeline {
    agent any
    tools {
        nodejs "my-nodejs"
    }
    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                credentialsId: 'GitHub-credentials',
                url: 'https://github.com/oadenekan/node-project.git'
            }
        }

        stage('Increment Version') {
            steps {
                script {
                    // enter app directory, because that is where package.json is located
                    dir("app") {
                        // update application version in the package.json file with one of these release types: patch, minor or major
                       // This command updates the minor version in package.json and ensures no Git commands are executed in the background, preventing automatic commits or tags in your Jenkins Pipeline
                        sh "npm version minor --no-git-tag-version"

                        // read the updated version from the package.json file
                        def packageJson = readJSON file: 'package.json'
                        def version = packageJson.version

                        // set the new version as part of IMAGE_NAME
                        env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                    }
                }
            }
        }

        stage('Run tests') {
            steps {
                script {
                    // enter app directory, because that's where package.json and tests are located
                    dir("app") {
                        // install all dependencies needed for running tests
                        sh 'npm install'
                        sh 'npm test'
                    }
                }
            }
        }

        stage('Build and Push docker image') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'docker-hub-repo',
                        usernameVariable: 'USER',
                        passwordVariable: 'PASS')
                ]){
                    sh "docker build -t docker-hub-repo/myapp:${IMAGE_NAME} ."
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh "docker push docker-hub-repo/myapp:${IMAGE_NAME}"
                }
            }
        }

        stage('Commit version update') {
            steps {
                script {
                     withCredentials([
                        usernamePassword(
                            credentialsId: 'GitHub-credentials',
                            usernameVariable: 'USER',
                            passwordVariable: 'PASS')
                     ]){
                        // git config here for the first time run
                        sh '''
                        git config user.email "jenkins@example.com"
                        git config user.name "Jenkins"
                        git remote set-url origin https://$USER:$PASS@github.com/oadenekan/node-project.git
                        git add app/package.json
                        git commit -m "ci: version bump" || true

                        git push origin main
                        '''
                    }
                }
            }
        }

    }
}
