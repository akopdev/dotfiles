FROM ubuntu

ARG username=akop
ARG userpass=akop

# Install essential packages
RUN apt-get update && \
    apt-get install build-essential \
                    curl \
                    file \
                    git \
                    openssh-server \
                    ruby-full \ 
                    python3 \
                    zsh \
                    locales --no-install-recommends -y && \
    rm -rf /var/lib/apt/lists/*

RUN localedef -i en_US -f UTF-8 en_GB.UTF-8

# Homebrew is not working under root user, so we should create custom
RUN useradd -m -s /usr/bin/zsh ${username} && \
    echo "${username} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# To install brew on linux environment we need to have a shared user
RUN useradd -m -s /bin/bash linuxbrew && \
    echo "linuxbrew ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Add dotfiles to user folder
COPY . /home/${username}/.dotfiles

# Install brew package manager
USER linuxbrew
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Provide non-root user with access to both own and brew files
USER root
RUN chown -R ${username} /home

# Switch to non-root user to finish account setup
USER ${username}
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
RUN mkdir -p /home/${username}/go/{bin,src,pkg}
RUN /bin/bash -c /home/${username}/.dotfiles/bin/dotfiles update


# Let's launch SSH service, so user can connect to container
USER root

# Start ssh deamon
RUN echo "${username}:${userpass}" | chpasswd 
RUN sed -i "s/prohibit-password/yes/" /etc/ssh/sshd_config
RUN echo "StrictHostKeyChecking=no" >> /etc/ssh/ssh_config
RUN service ssh start

WORKDIR /home/${username}/Projects

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
