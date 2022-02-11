FROM ubuntu:16.04

ENV LC_CTYPE C.UTF-8
WORKDIR /root

RUN apt update
RUN apt install curl gdb git gcc iputils-ping make ssh vim wget python3 python3-pip python3-dev libssl-dev libffi-dev build-essential -y

RUN dpkg --add-architecture i386
RUN apt install libc6-i386 libc6-dbg gcc-multilib -y

RUN python3 -m pip install -U "pip<21.0"
RUN python3 -m pip install -U pwntools
RUN python3 -m pip install unicorn
RUN python3 -m pip install keystone-engine
RUN python3 -m pip install ropper

RUN apt install libcapstone-dev -y

RUN apt install ruby-full ruby-dev -y
RUN gem install one_gadget -v 1.7.3

RUN wget -O ~/.gef.py -q https://github.com/hugsy/gef/releases/download/2021.01/gef.py
RUN echo source ~/.gef.py >> ~/.gdbinit