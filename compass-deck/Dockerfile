FROM huangxiangyu/centos-systemd

ARG BRANCH=master
ADD . /root/compass-deck

RUN /root/compass-deck/build.sh

EXPOSE 80

CMD ["/sbin/init", "/usr/local/bin/start.sh"]
