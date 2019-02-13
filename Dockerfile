FROM ubuntu:bionic

# install repo update and dependencies
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install openssh-server vim curl git nano build-essential libssl-dev curl -y

# configure ssh
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original
RUN chmod a-w /etc/ssh/sshd_config.original
COPY sshd_config /etc/ssh/sshd_config

# install node js
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

# install vim extensions
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
COPY vimrc ~/.vimrc

COPY run.sh /root/run.sh

RUN adduser user --disabled-password -q --gecos "User"
RUN mkdir -p /home/user/.ssh
COPY id_rsa.pub /home/user/.ssh/given_id_rsa.pub
RUN cat /home/user/.ssh/given_id_rsa.pub > /home/user/.ssh/authorized_keys

# expose ssh port
EXPOSE 22
CMD sh /root/run.sh