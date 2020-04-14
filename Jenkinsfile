node {
 stage('SCM'){
    checkout scm
 }

 stage('Build'){
    def project = "bjethwan"

    def customImage = docker.build(project +"/hello-app:${env.BUILD_ID}")
    
    createRequiredProject(project)
    
    //https://issues.jenkins-ci.org/browse/JENKINS-41051
    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'harbor_credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) 
    {
			usr = USERNAME
			pswd = PASSWORD
     
    docker.withRegistry("https://${params.harbor_endpoint}", 'harbor_credentials') {
       sh " echo ${usr}"
       sh "docker login -u ${usr} -p ${pswd} ${params.harbor_endpoint}"
       customImage.push()
    }
}

 }
}

def hello(String name = 'human') {
    echo "Hello, ${name}."
}

def createRequiredProject(String projectName=''){
    def response =
        httpRequest(
                authentication: 'harbor_credentials',
                httpMode: 'HEAD',
                ignoreSslErrors: true,
                validResponseCodes: '100:499',
                url: "https://${params.harbor_endpoint}/api/projects?project_name="+projectName
        )
    println("createRequiredProject-->Status: "+response.status)
    println("createRequiredProject-->Content: "+response.content)
    
    if(response.status == 404){
      def responseForCreateProject = httpRequest(
        acceptType: 'APPLICATION_JSON',
        authentication: 'harbor_credentials',
        consoleLogResponseBody: true,
        contentType: 'APPLICATION_JSON',
        httpMode: 'POST',
        ignoreSslErrors: true,
        requestBody: '''
        {
                "project_name": "''' +projectName+'''",
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
        }''',
        responseHandle: 'NONE',
        url: 'https://'+params.harbor_endpoint+'/api/projects',
        validResponseCodes: '100:499'
      )
      println("responseForCreateProject-->Status: "+responseForCreateProject.status)
      println("responseForCreateProject---->Content: "+responseForCreateProject.content)
    } else if(response.status != 200){
      throw new Exception()
    }   
}
