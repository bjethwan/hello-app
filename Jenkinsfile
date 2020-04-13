node {
 stage('SCM'){
    checkout scm
 }

 stage('Build'){
    def project = "notpresent"
    def isProjectPresentOnRegistry = false
    def customImage = docker.build(project +"/hello-app:${env.BUILD_ID}")
   
    def response = httpRequest authentication: 'harbor_credentials', httpMode: 'HEAD', ignoreSslErrors: true, validResponseCodes: '100:499', url: 'https://harbor.bj-cloud.xyz/api/projects?project_name='+project
    println("Status: "+response.status)
    println("Content: "+response.content)
    
    if(response.status == 200){
      isProjectPresentOnRegistry = true
    }else{
      isProjectPresentOnRegistry = false
    }
    println(isProjectPresentOnRegistry)

    docker.withRegistry('https://harbor.bj-cloud.xyz', 'harbor_credentials') {
       customImage.push()
    }
 }
}

def printMessage(){
   println(${message})
}
