FROM debian:buster-slim

COPY config /cc

RUN mv /cc/sources.list /etc/apt/sources.list \
		&& dpkg --add-architecture i386 \
		&& apt-get -q update \
		&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y --auto-remove \
		build-essential \
		bzip2 \
		ca-certificates \
		binutils \
		curl \
		file \
		gcc-multilib \
		gdb \
		git \
		libc6:i386 \
		libc6-dbg:i386 \
		libc6-dbg \
		make \
		net-tools \
		netcat \
		pkg-config \
		python3-dev \
		procps \
		ruby \
		socat \
		tmux \
		vim	\
		\
		&& mv /cc/config /root/.config \
		&& mv /cc/bashrc /root/.bashrc \
		&& mv /cc/vim /root/.vim && mv /cc/vimrc /root/.vimrc && vim +PlugInstall +qall\
		&& python3 /cc/get-pip.py \
		&& pip install -U pip \
		&& pip install --no-cache-dir \
		angr \
		pwntools \
		ropgadget \
		\
		&& cd /root \
		&& git clone --depth 1 https://github.com/scwuaptx/peda \
		&& git clone --depth 1 https://github.com/scwuaptx/Pwngdb \
		&& cp Pwngdb/.gdbinit . \
#		&& git clone --depth 1 https://github.com.cnpmjs.org/lieanu/LibcSearcher \
#		&& cd LibcSearcher && python setup.py develop && rm -rf .git* README.md && cd \
		&& cd / \
		\
		&& gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ \
		&& gem install one_gadget \
		&& echo "[+] Build stage success"; \
		\
		sed -i 's/http/https/g' /etc/apt/sources.list; \
		apt-get clean; \
		apt-get autoclean; \
		apt-get autoremove; \
		rm -rf /tmp/* /var/tmp/*; \
		rm -rf /var/lib/apt/lists/*; \
		rm -rf /var/lib/gems/2.*/cache/*; \
		find / -name __pycache__ | xargs rm -rf; \
		find / -type d -iregex '.*\.git' | xargs rm -rf; \
		find / -type f -iregex '.*\(\.gitignore\|\.md\)' -exec rm -rf {} \; ; \
		rm -rf /cc;

#RUN useradd -m ctf
#WORKDIR /home/ctf/ctf
#RUN chown -R ctf.ctf /home/ctf
#		echo "ctf ALL=NOPASSWD: ALL" > /etc/sudoers.d/ctf
#USER ctf
