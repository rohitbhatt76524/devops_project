pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        // AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY are injected automatically
        // from Jenkins → Manage Jenkins → System → Global properties → Environment variables
    }

    parameters {
        booleanParam(name: 'DESTROY', defaultValue: false, description: 'Destroy the EKS cluster instead of creating it')
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -reconfigure'
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.DESTROY) {
                        sh 'terraform plan -destroy -out=tfplan'
                    } else {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Approval: Review Plan') {
            steps {
                input message: 'Review the Terraform plan above. Proceed with apply?', ok: 'Apply'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }

        stage('Configure kubectl') {
            when { expression { return !params.DESTROY } }
            steps {
                script {
                    def clusterName = sh(script: 'terraform output -raw cluster_name', returnStdout: true).trim()
                    sh "aws eks update-kubeconfig --region ${AWS_REGION} --name ${clusterName}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            when { expression { return !params.DESTROY } }
            steps {
                sh 'kubectl apply -f mongo-secret.yaml'
                sh 'kubectl apply -f mongo-configmap.yaml'
                sh 'kubectl apply -f mongo.yaml'
                sh 'kubectl apply -f mongo-express.yaml'
                sh 'kubectl apply -f ingress.yaml'
            }
        }

        stage('Verify Deployment') {
            when { expression { return !params.DESTROY } }
            steps {
                sh 'kubectl rollout status deployment/mongodb-deployment --timeout=120s'
                sh 'kubectl rollout status deployment/mongo-express        --timeout=120s'
                sh 'kubectl get pods'
                sh 'kubectl get svc'
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully. Region: ${AWS_REGION}"
        }
        failure {
            echo 'Pipeline failed — check the stage logs above for details.'
        }
        always {
            cleanWs()
        }
    }
}
