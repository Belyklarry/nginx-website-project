pipeline {
  agent any
  parameters {
    choice(
        name: 'Action',
        choices: "apply\ndestroy",
        description: 'Apply or Destroy the instance' )
  }
  stages {

    stage('Checkout') {
        steps {
            git branch: 'master', credentialsId: 'local_auth', url: 'git@github.com:Belyklarry/nginx-website-project.git'
        }
    }

    stage('Terraform') {
      steps {
        script {
          if (params.Action == "apply") {
            sh 'terraform init -chdir=terraform/static-site'
            sh 'terraform apply -var "name=hello" -var "group=web" -var "region=af-south-1" -var "profile=scottyfullstack" --auto-approve -chdir=terraform/static-site'
          } 
          else {
            sh 'terraform destroy -var "name=hello" -var "group=web" -var "region=af-south-1" -var "profile=scottyfullstack" --auto-approve -chdir=terraform/static-site'
          }
        }
      }
    }

    stage('Ansible') {
      steps {
        retry(count: 5) {
          sh 'ansible-playbook -i /etc/ansible/aws_ec2.yaml ansible/static-site/site.yaml'
        }
      }
    }
  }
}
