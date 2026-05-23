# Dockerfile
FROM jenkins/jenkins:lts

USER root

# Install AWS CLI
RUN apt-get update && apt-get install -y curl unzip \
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip && ./aws/install \
  && rm -rf awscliv2.zip aws

# Install Terraform
RUN curl -LO https://releases.hashicorp.com/terraform/1.7.0/terraform_1.7.0_linux_amd64.zip \
  && unzip terraform_1.7.0_linux_amd64.zip \
  && mv terraform /usr/local/bin/ \
  && rm terraform_1.7.0_linux_amd64.zip

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  && chmod +x kubectl && mv kubectl /usr/local/bin/

# Install Docker CLI (to build images inside Jenkins)
RUN curl -fsSL https://get.docker.com | sh

USER jenkins
