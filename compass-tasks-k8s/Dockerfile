FROM compass4nfv/compass-tasks-base:7.0.0
ARG BRANCH=master
RUN yum install git ntp wget ntpdate openssh-server python-devel sudo  -y \
    && source /root/.virtualenvs/compass-core/bin/activate \
#    && source activate \
    && pip uninstall ansible -y \
    && deactivate \
    && rm -rf  /opt/kargo_k8s  \
    && git clone https://github.com/kubernetes-incubator/kubespray.git /opt/kargo_k8s \
    && cd /opt/kargo_k8s \
    && git checkout v2.6.0 -b k8s1.10.4 \
    && pip install -U -r requirements.txt \
    && pip install ansible==2.4.2.0 \
    && yum clean all
