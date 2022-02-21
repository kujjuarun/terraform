pipeline {
    agent any
        options {
            timestamps ()
        }
    
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    tools {
        terraform 'Terraform-Win'
   }
    
    stages {
        stage('Code Extraction') {
            steps {
                git branch: 'main', credentialsId: 'cff6456e-2e71-4647-b3fe-846013c20e46', url: 'https://github.com/kujjuarun/terraform.git'
            }
        }
        
        stage('Terraform Version') {
            steps {
                bat 'terraform --version'
            }
        }
        
        stage('Terraform Init') {
            steps {
                bat 'terraform init -upgrade'
            }
        }
        
        stage('Terraform validate') {
            steps {
                bat 'terraform validate'
            }
        }
        
        stage('Terraform plan') {
            steps {
                bat 'set AWS_PROFILE=default'
                bat 'terraform plan -input=false -out tfplan'
                bat 'terraform show -no-color tfplan > tfplan.txt'
            }
        }
        
        stage('Terraform Action') {
            steps {
                bat 'echo %action%'
                bat 'terraform %action% --auto-approve'
            }
        }        
        
    }
}