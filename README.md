# jenkins CI-CD project

- first step : setup jenkins server and install jenkins on the server 
jenkin installation ( https://www.jenkins.io/doc/book/installing/linux/)

- next: configure guithub webhook to jenkins 
steps: - on github, generate a token and add it to the credential on jenkins for webhook

- next- on jenkins manage -> system - > configure github server , using the webhook credentials , then click on manage hooks.

# mvn clean and test
- next: install maven plugins on jenkins
1: maven integration
2: Pipeline Maven Integration





# to Integrate Nexus with jenkins, we need to install a plugin on jenkins called
nexus artifact uploader

# when developers push new version of code to Git, there is usually a new version of pom.xml, and we cant keep updating the version in our jenkinsfile, so we need to figure out a way to have our jenkinsfile pick the new version each time there is a new code..

- next: to do this we need a new plugin on jenkins UI called - Pipeline Utility Steps

# after building the image and want to push to Dockerhub

# the creditals to use should be the dockerhubapi token and not the password