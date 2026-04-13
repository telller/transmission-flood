pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        PROJECT_DIR = "${WORKSPACE}"
        COMPOSE_FILE = "docker-compose.yml"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Compose Down') {
            steps {
                dir("${PROJECT_DIR}") {
                    sh "docker-compose -f ${COMPOSE_FILE} down || true"
                }
            }
        }

        stage('Docker Compose Up') {
            steps {
                withCredentials([
                    string(credentialsId: 'flood-user', variable: 'FLOOD_USER'),
                    string(credentialsId: 'flood-pass', variable: 'FLOOD_PASS'),
                    string(credentialsId: 'tr-user', variable: 'TR_USER'),
                    string(credentialsId: 'tr-pass', variable: 'TR_PASS'),
                ]) {
                    dir("${PROJECT_DIR}") {
                        sh "docker-compose -f ${COMPOSE_FILE} up -d --build"
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Build finished"
        }
    }
}