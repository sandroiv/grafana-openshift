FROM centos:7
MAINTAINER Shared Utilities <email-here>

USER root
EXPOSE 3000

ARG GRAFANA_REPO_URL="https://dl.grafana.com/oss/release"
ARG GRAFANA_RPM_FILE="grafana-6.3.2-1.x86_64.rpm"

ADD root /
RUN yum -y install $GRAFANA_REPO_URL/$GRAFANA_RPM_FILE \
    && yum clean all
COPY run.sh /usr/share/grafana/
RUN /usr/bin/fix-permissions /usr/share/grafana \
    && /usr/bin/fix-permissions /etc/grafana \
    && /usr/bin/fix-permissions /var/lib/grafana \
    && /usr/bin/fix-permissions /var/log/grafana 

WORKDIR /usr/share/grafana
ENTRYPOINT ["./run.sh"]
