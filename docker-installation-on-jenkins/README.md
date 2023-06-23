# using the offical docker webpage to install docker on jenkins server - Ubuntu
(https://docs.docker.com/engine/install/ubuntu/)

- next : before the complettion on the installation , add jenkins user to docker group

sudo usermod -aG docker jenkins

- next: sudo systemctl restart jenkins

