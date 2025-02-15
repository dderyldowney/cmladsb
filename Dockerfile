# Base image with specific version for better reproducibility
FROM debian:bookworm-slim

# Add maintainer information
LABEL maintainer="D Deryl Downey <ddd@davidderyldowney.com>"

# Set build arguments
ARG USER_NAME=python_app
ARG UID=1000
ARG GID=1000
ARG DEBIAN_FRONTEND=noninteractive
ARG PYTHON_VERSION=3.12.9

# Install system dependencies and create user in one layer to reduce image size
RUN apt-get update && apt-get install -y --no-install-recommends \
    zsh \
    curl \
    git \
    wget \
    vim \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    ca-certificates \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -g $GID $USER_NAME \
    && useradd -m -u $UID -g $GID -s /usr/bin/zsh $USER_NAME \
    && usermod -aG sudo $USER_NAME \
    && echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER_NAME

# Switch to the non-root user
USER $USER_NAME
WORKDIR /home/$USER_NAME

COPY --chown=$USER_NAME:$USER_NAME requirements.txt /home/$USER_NAME/

# Install oh-my-zsh and pyenv, configure environment in one layer
ENV PYENV_ROOT=/home/$USER_NAME/.pyenv
ENV PATH=$PYENV_ROOT/bin:$PATH

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended \
    && git clone https://github.com/pyenv/pyenv.git ~/.pyenv \
    && git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv \
    && echo 'export ZSH="$HOME/.oh-my-zsh"' >> ~/.zshrc \
    && echo 'ZSH_THEME="robbyrussell"' >> ~/.zshrc \
    && echo 'plugins=(git)' >> ~/.zshrc \
    && echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc \
    && echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc \
    && echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc \
    && echo 'eval "$(pyenv init --path)"' >> ~/.zshrc \
    && echo 'eval "$(pyenv init -)"' >> ~/.zshrc \
    && echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc \
    && exec $SHELL

# Install Python using pyenv and create a virtual environment
RUN /usr/bin/zsh -c "eval $(pyenv init --path) \
    && eval $(pyenv init -) \
    && eval $(pyenv virtualenv-init -) \
    && pyenv install $PYTHON_VERSION \
    && pyenv global $PYTHON_VERSION \
    && pyenv virtualenv $PYTHON_VERSION venv"

RUN /usr/bin/zsh -c ". ~/.zshrc \
    && pyenv activate venv \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt"

# Set default shell to zsh
SHELL ["/usr/bin/zsh", "-c"]

# Use shell form to run multiple commands in CMD
CMD ["zsh", "-c", "source ~/.zshrc && source venv/bin/activate && exec zsh"]
