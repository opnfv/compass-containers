FROM compassindocker/systemd-base
ENV container docker
VOLUME [ "/sys/fs/cgroup" ]
ARG BRANCH=master

# pkgs and services...
RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install wget dhcp bind syslinux pykickstart file initscripts net-tools tcpdump xinetd vim \
    avahi avahi-tools ntp fence-agents libvirt-devel python-devel gcc python-pip && \
    wget http://artifacts.opnfv.org/compass4nfv/package/cobbler/cobbler-2.6.10-1.fc22.noarch.rpm && \
    wget http://artifacts.opnfv.org/compass4nfv/package/cobbler/cobbler-web-2.6.10-1.fc22.noarch.rpm && \
    yum -y localinstall cobbler-2.6.10-1.fc22.noarch.rpm cobbler-web-2.6.10-1.fc22.noarch.rpm && \
    rm -f cobbler-2.6.10-1.fc22.noarch.rpm cobbler-web-2.6.10-1.fc22.noarch.rpm && \
    systemctl enable cobblerd && \
    systemctl enable httpd && \
    systemctl enable dhcpd && \
    systemctl enable xinetd && \
    systemctl enable ntpd && \
    pip install libvirt-python click

COPY fence_libvirt /usr/sbin/fence_libvirt
COPY fence_libvirt.template /etc/cobbler/power/fence_libvirt.template

# some tweaks on services
RUN sed -i -e 's/\(^.*disable.*=\) yes/\1 no/' /etc/xinetd.d/tftp && \
    touch /etc/xinetd.d/rsync

RUN mkdir -p /var/www/cblr_ks

COPY distro_signatures.json /var/lib/cobbler/distro_signatures.json
COPY start.sh /usr/local/bin/start.sh
RUN mv /etc/httpd/conf.d/cobbler_web.conf /etc/httpd/conf.d/cobbler_web.conf.bk
COPY cobbler_web.conf /etc/httpd/conf.d/cobbler_web.conf
RUN mv /etc/httpd/conf.d/cobbler.conf /etc/httpd/conf.d/cobbler.conf.bk
COPY cobbler.conf /etc/httpd/conf.d/cobbler.conf
RUN mkdir -p /var/www/pip-openstack
VOLUME ["/var/lib/cobbler", "/var/www/cobbler", "/etc/cobbler", "/mnt", "/var/www/cobbler/repo_mirror", "/var/www/pip"]
EXPOSE 67
EXPOSE 69
EXPOSE 80
EXPOSE 443
EXPOSE 25151
CMD ["/sbin/init", "/usr/local/bin/start.sh"]
