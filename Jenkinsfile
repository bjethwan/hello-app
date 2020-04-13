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
      httpRequest(
	acceptType: 'APPLICATION_JSON', 
	authentication: 'harbor_credentials', 
	consoleLogResponseBody: true, 
	contentType: 'APPLICATION_JSON', 
	httpMode: 'POST', 
	ignoreSslErrors: true, 
	requestBody: '
	{
  		"project_name": project,
		"count_limit": -1,
  		"storage_limit": -1,
  		"metadata": {
    			"enable_content_trust": "false",
    			"auto_scan": "true",
    			"severity": "none",
    			"reuse_sys_cve_whitelist": "true",
    			"public": "true",
    			"prevent_vul": "false"
 		 }
	}', 
	responseHandle: 'NONE', 
	url: 'https://harbor.bj-cloud.xyz/api/projects', 
	validResponseCodes: '100:499'
      )
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
