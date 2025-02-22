# Base image with specific version for better reproducibility
FROM debian:bookworm-slim

# Add maintainer information
LABEL maintainer="D Deryl Downey <ddd@davidderyldowney.com>"

# Expose Jupyter Lab port
EXPOSE 8888

# Set build arguments
ARG USER_NAME=python_user
ARG UID=1000
ARG GID=1000
ARG DEBIAN_FRONTEND=noninteractive
ARG LOCALE=en_US.UTF-8
ARG PYTHON_VERSION=3.12.9
ARG VENV_NAME=cmladsb

# Customization Note: Changing the ARG VENV_NAME sets the container's VENV_NAME environment variable. 
# This allows you to define the default virtual environment name, as referenced in the CMD instruction.

# Set environment variables
ENV LANG=$LOCALE
ENV LANGUAGE=$LOCALE
ENV NVM_DIR=/home/$USER_NAME/.nvm
ENV PYENV_ROOT=/home/$USER_NAME/.pyenv
ENV PATH=$PYENV_ROOT/bin:$PATH
ENV PYTHONIOENCODING=utf-8
ENV TERM=xterm-256color
ENV VENV_NAME=$VENV_NAME

# Install system dependencies and create user in one layer to reduce image size
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales procps apt-transport-https ca-certificates sudo less \
    bash zsh gnupg ssh curl wget git vim build-essential libssl-dev \
    zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
    libffi-dev liblzma-dev \
    && locale-gen "$LOCALE" && update-locale "$LOCALE" \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && groupadd -g $GID $USER_NAME \
    && useradd -m -u $UID -g $GID -s /usr/bin/zsh $USER_NAME \
    && usermod -aG sudo $USER_NAME \
    && echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER_NAME

# Switch to the non-root user
USER $USER_NAME
WORKDIR /home/$USER_NAME

# Copy necessary files
COPY --chown=$USER_NAME:$USER_NAME requirements.txt README.md ./
COPY --chown=$USER_NAME:$USER_NAME .jupyter/jupyter_server_config.py .jupyter/

# Install Oh My Zsh, NVM, Pyenv, and pyenv-virtualenv and configure .zshrc in a single layer
RUN /usr/bin/zsh -c "wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | bash \
    && wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash \
    && git clone https://github.com/pyenv/pyenv.git /home/\$USER_NAME/.pyenv \
    && git clone https://github.com/pyenv/pyenv-virtualenv.git /home/\$USER_NAME/.pyenv/plugins/pyenv-virtualenv \
    && echo 'export NVM_DIR=\"\$HOME/.nvm\"' >> ~/.zshrc \
    && echo '[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"' >> ~/.zshrc \
    && echo 'export ZSH=\"\$HOME/.oh-my-zsh\"' >> ~/.zshrc \
    && echo 'ZSH_THEME=\"robbyrussell\"' >> ~/.zshrc \
    && echo 'plugins=(git)' >> ~/.zshrc \
    && echo 'source \$ZSH/oh-my-zsh.sh' >> ~/.zshrc \
    && echo 'export PYENV_ROOT=\"\$HOME/.pyenv\"' >> ~/.zshrc \
    && echo 'export PATH=\"\$PYENV_ROOT/bin:\$PATH\"' >> ~/.zshrc \
    && echo 'eval \"\$(pyenv init --path)\"' >> ~/.zshrc \
    && echo 'eval \"\$(pyenv init -)\"' >> ~/.zshrc \
    && echo 'eval \"\$(pyenv virtualenv-init -)\"' >> ~/.zshrc"

# Install Node.js (Stable), and set it as default
RUN /usr/bin/zsh -c "source ~/.zshrc \
    && nvm install stable \
    && nvm alias default stable"

# Install Python using pyenv, and create then stock a virtual environment
RUN /usr/bin/zsh -c "source ~/.zshrc \
    && pyenv install $PYTHON_VERSION \
    && pyenv global $PYTHON_VERSION \
    && pyenv virtualenv $PYTHON_VERSION $VENV_NAME \
    && pyenv activate ${VENV_NAME} \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt"

# Set default shell to zsh
SHELL ["/usr/bin/zsh"]

# Prefer the CMD exec form (["echo", "Hello"]) over the shell form (echo "Hello") for better signal handling and consistency.
CMD ["/usr/bin/zsh", "-c", "source ~/.zshrc && pyenv activate $VENV_NAME && jupyter lab --no-browser --ip=0.0.0.0 --port=8888"]
