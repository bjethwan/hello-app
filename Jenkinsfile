node {
 stage('SCM'){
    checkout scm
 }

 stage('Build'){
    def project = "bjethwan"
    def isProjectPresentOnRegistry = false
    def customImage = docker.build(project +"/hello-app:${env.BUILD_ID}")
    httpRequest authentication: 'harbor_credentials', httpMode: 'HEAD', ignoreSslErrors: true, responseHandle: 'printMessage', url: 'https://harbor.bj-cloud.xyz/api/projects?project_name='+project
    docker.withRegistry('https://harbor.bj-cloud.xyz', 'harbor_credentials') {
       customImage.push()
    }
    println(isProjectPresentOnRegistry)
 }
}

def printMessage(){
   println(${message})
}
