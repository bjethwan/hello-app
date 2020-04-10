node {

    checkout scm

    def customImage = docker.build("bjethwan/hello-app:${env.BUILD_ID}")

    docker.withRegistry('https://harbor.bj-cloud.xyz', harbor_credentials) {
      customImage.push()
    }

}
