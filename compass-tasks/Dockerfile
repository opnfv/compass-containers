FROM opnfv/compass-tasks-base
ARG BRANCH=master

ADD ./run.sh /root/
ADD ./tacker_conf /opt/tacker_conf
ADD ./setup-complete.yml /opt/
RUN chmod +x /root/run.sh
RUN /root/run.sh
