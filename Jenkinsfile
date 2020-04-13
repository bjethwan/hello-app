node {
 stage('SCM'){
    checkout scm
 }

 stage('Build'){
    def project = "bjethwan"
    def customImage = docker.build(project +"/hello-app:${env.BUILD_ID}")
    docker.withRegistry('https://harbor.bj-cloud.xyz', 'harbor_credentials') {
       customImage.push()
    }
 }
}
