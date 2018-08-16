FROM centos:7.3.1611

MAINTAINER moumou123 <1026856405@qq.com>

RUN yum -y install wget net-tool openssh-server; yum clean all

RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key

RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key

RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd

RUN mkdir -p /root/.ssh && chown root.root /root && chmod 700 /root/.ssh

RUN echo 'root:mkaliez.com' | chpasswd

RUN wget http://soft.vpser.net/lnmp/lnmp1.5.tar.gz && tar zxf lnmp1.5.tar.gz 

ENV APP_HOME lnmp1.5

WORKDIR $APP_HOME

RUN ./install.sh lnmp && printf "0\n0" && printf "7\n0" && printf "1\n"

EXPOSE 21 22 80 443 888 3306 8888

CMD lnmp start && /usr/sbin/sshd -D
