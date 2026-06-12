#!/bin/bash

service dbus start
service xrdp start
mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

echo "Starting Windows 10 Tiny..."
qemu-system-x86_64 -m 256M -hda /windows/tiny10.qcow2 -vnc :0 -k en-us -net user -net nic -rtc base=localtime -daemonize

echo "======================================"
echo "Windows 10 RDP READY!"
echo "Connect via VNC: port 5900"
echo "Or RDP: port 3389 (Linux Desktop fallback)"
echo "======================================"

tail -f /var/log/xrdp-sesman.log
