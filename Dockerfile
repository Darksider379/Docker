FROM centos:7

RUN yum install -y openssh-server

RUN useradd remote_user && \
echo "remote_user:1234" | chpasswd && \
mkdir /home/remote_user/.ssh && \
chmod 700 /home/remote_user/.ssh

COPY remote-key.pub /home/remote_user/.ssh/authorized_keys

RUN chown remote_user:remote_user -R /home/remote_user/.ssh/ && \
chmod 600 /home/remote_user/.ssh/authorized_keys

RUN /usr/sbin/sshd-keygen
RUN yum install -y mysql
RUN yum install awscli -y
RUN yum install -y epel-release
RUN yum install -y ansible


CMD /usr/sbin/sshd -D
