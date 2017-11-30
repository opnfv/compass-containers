FROM opnfv/compass-tasks:latest
#FROM localbuild/compass-tasks
ARG BRANCH=master

ADD ./run.sh /root/
ADD ./tacker_conf /opt/tacker_conf
RUN chmod +x /root/run.sh
RUN /root/run.sh
