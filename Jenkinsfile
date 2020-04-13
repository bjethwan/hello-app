node {
 stage('SCM'){
    checkout scm
 }

 stage('Build'){
    def project = "bjethwan"
    def isProjectPresentOnRegistry = false
    def customImage = docker.build(project +"/hello-app:${env.BUILD_ID}")
    def response = httpRequest authentication: 'harbor_credentials', httpMode: 'HEAD', ignoreSslErrors: true, url: 'https://harbor.bj-cloud.xyz/api/projects?project_name='+project
    println("Status: "+response.status)
    println("Content: "+response.content)
    docker.withRegistry('https://harbor.bj-cloud.xyz', 'harbor_credentials') {
       customImage.push()
    }
    println(isProjectPresentOnRegistry)
 }
}

def printMessage(){
   println(${message})
}
