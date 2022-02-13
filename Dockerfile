FROM archlinux
MAINTAINER Evan Meek <the_lty_mail@foxmail.com>
RUN echo "Server = https://mirror.sjtu.edu.cn/archlinux/\$repo/os/\$arch"  > /etc/pacman.d/mirrorlist
RUN echo /etc/pacman.d/mirrorlist
RUN pacman -Syy
RUN echo "[archlinuxcn]" >> /etc/pacman.conf
RUN echo "SigLevel = Never" >> /etc/pacman.conf
RUN echo "Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux-cn/\$arch" >> /etc/pacman.conf
RUN pacman -Syy && pacman -S archlinuxcn-keyring --noconfirm
RUN echo "正在安装git"
RUN pacman -S git --noconfirm
RUN echo "正在安装base-devel"
RUN pacman -S base-devel --noconfirm
RUN echo "正在安装terraria-server"
RUN useradd -m -G root terraria
RUN echo "terraria ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/terraria
USER terraria
WORKDIR /home/terraria/
RUN git clone https://aur.archlinux.org/terraria-server.git
WORKDIR /home/terraria/terraria-server
RUN makepkg -si --noconfirm
ENTRYPOINT [ "terraria-server" ]
