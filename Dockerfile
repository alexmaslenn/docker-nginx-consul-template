FROM nginx:latest

LABEL maintainer="Alexander Maslennikov"

ENV CONSUL_TEMPLATE_VERSION=0.24.1
ENV CONSUL_URL localhost:8500
ENV TEMPLATE_PATH nginx.conf.tmpl
# Update apt
RUN apt-get update \
	&& apt-get install -y -q wget curl unzip lsb-release runit
# Download consul-template
ENV CT_URL https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip
RUN curl -O $CT_URL
# Unzip consul-template
RUN unzip consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -d /usr/bin \
  && rm consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip

#Create entrypoint
RUN mkdir -p /scripts/
COPY start.sh /scripts/start.sh
RUN ["chmod", "+x", "/scripts/start.sh"]
ENTRYPOINT ["/scripts/start.sh"]