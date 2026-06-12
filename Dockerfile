FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    wget curl sudo \
    qemu-system-x86 qemu-utils \
    xrdp xfce4 xfce4-goodies xorg dbus-x11 nano net-tools policykit-1 \
    && apt clean && rm -rf /var/lib/apt/lists/*

RUN echo "root:root" | chpasswd
RUN echo "allowed_users=anybody" > /etc/X11/Xwrapper.config
RUN echo "startxfce4" > /root/.xsession && chmod 700 /root/.xsession

# Download Tiny10 Windows image
RUN mkdir /windows && cd /windows && \
    curl -L -o tiny10.qcow2 "https://dl.bobpony.com/windows/tiny10/Tiny10.qcow2"

# Copy start.sh script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 3389 5900

CMD ["/bin/bash", "/start.sh"]
