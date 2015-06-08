FROM stackbrew/ubuntu:trusty

RUN apt-get update && apt-get install -y curl logrotate

# Get latest from https://mms.mongodb.com/settings/monitoring-agent
RUN curl -sSL https://mms.mongodb.com/download/agent/monitoring/mongodb-mms-monitoring-agent_3.4.0.190-1_amd64.deb -o mms.deb
RUN dpkg -i mms.deb
RUN rm mms.deb

ADD entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

USER mongodb-mms-agent
CMD ["mongodb-mms-monitoring-agent","-conf","/etc/mongodb-mms/monitoring-agent.config"]
