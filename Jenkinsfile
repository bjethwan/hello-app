node {

    checkout scm

    def customImage = docker.build("bjethwan/hello-app:${env.BUILD_ID}")

    docker.withRegistry('https://harbor.bj-cloud.xyz', 'harbor_credentials') {
      customImage.push()
    }

    def response = httpRequest 'http://localhost:8080/jenkins/api/json?pretty=true'
    println("Status: "+response.status)
    println("Content: "+response.content)

}
