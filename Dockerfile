FROM ubuntu:16.04

ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8
WORKDIR /root

RUN apt update
RUN apt install curl gdb git gcc iputils-ping make net-tools ssh vim wget zsh python3 python3-pip python3-dev libssl-dev libffi-dev build-essential -y

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

RUN chsh -s $(which zsh) 
RUN zsh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN sed -i 's|ZSH_THEME="robbyrussell"|ZSH_THEME="gnzh"|g' ~/.zshrc
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN sed -i 's|plugins=(git)|plugins=(git zsh-syntax-highlighting zsh-autosuggestions)|g' ~/.zshrc
RUN echo 'ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"' >> ~/.zshrc

CMD ["zsh"]
