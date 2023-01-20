FROM ubuntu:20.04

# Set tz for easy install
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" TZ="Europe/Amsterdam" apt-get install -y tzdata

# Upgrade and install packages
RUN apt update -y && apt upgrade -y && \
    apt install -yqq build-essential cmake curl g++ git libssl-dev make netcat p7zip-full pkg-config sudo vim wget

# Add a user `rustnanodev` so that you're not developing as the `root` user
RUN adduser --gecos '/usr/bin/bash' --disabled-password rustnanodev && \
  echo "rustnanodev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd
ENV SHELL bash

USER rustnanodev
WORKDIR /home/rustnanodev
# Create USER environment variable to prevent "could not determine the current user, please set $USER" error when running "cargo new ..."
ENV USER rustnanodev

# Install rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh
RUN sh rustup.sh -y && rm -f rustup.sh
ENV PATH /home/rustnanodev/.cargo/bin:$PATH

# Install code-server 
RUN curl -fsSL https://code-server.dev/install.sh > install.sh
RUN sh install.sh --method=standalone
RUN rm -f install.sh
RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc
RUN sudo chown -R rustnanodev:rustnanodev /home/rustnanodev/.local
ENV PATH /home/rustnanodev/.local/bin:$PATH

#
RUN rustup toolchain install nightly
RUN rustup default nightly
## Install extensions dependencies
RUN rustup component add rust-analysis
RUN rustup component add rust-src 

USER rustnanodev
## Language support for Rust
RUN code-server --install-extension rust-lang.rust-analyzer

# Rust-analyzer binary
RUN mkdir -p /home/rustnanodev/.local/share/code-server/User/globalStorage/matklad.rust-analyzer/
RUN curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o /home/rustnanodev/.local/share/code-server/User/globalStorage/matklad.rust-analyzer/rust-analyzer-linux
RUN chmod u+x /home/rustnanodev/.local/share/code-server/User/globalStorage/matklad.rust-analyzer/rust-analyzer-linux

# Debugging tools
# Install from the vsix instead of using extension id because of this issue: https://github.com/vadimcn/vscode-lldb/issues/314
RUN curl -L https://github.com/vadimcn/vscode-lldb/releases/download/v1.8.1/codelldb-x86_64-linux.vsix -o codelldb-x86_64-linux.vsix
RUN code-server --install-extension codelldb-x86_64-linux.vsix
RUN rm -f codelldb-x86_64-linux.vsix

# VSCode extensions
# edit cargo configuration files
RUN code-server --install-extension bungcip.better-toml
# crates extension
RUN code-server --install-extension serayuzgur.crates
# error Lens extension
RUN code-server --install-extension usernamehw.errorlens
# crate analyzer
RUN code-server --install-extension DotJoshJohnson.xml
# docs view
RUN code-server --install-extension bierner.docs-view
# improved syntax highlighting
RUN code-server --install-extension dustypomerleau.rust-syntax
# arzg - color theme for rust
RUN code-server --install-extension arzg.sema

## Install corrosion (glue layer between Rust and C++)
USER rustnanodev
RUN git clone https://github.com/AndrewGaspar/corrosion.git
RUN cd corrosion
RUN cmake -Scorrosion -Bbuild -DCMAKE_BUILD_TYPE=Release
USER root
RUN cmake --build build --config Release
RUN cmake --install build --config Release

COPY *.sh /home/rustnanodev/

USER root
EXPOSE 8041

# Remove sudo package
ENV SUDO_FORCE_REMOVE yes
RUN apt -y remove sudo

# Run code server
USER rustnanodev

CMD ["code-server", "--bind-addr=0.0.0.0:8041", "--auth=none"]
