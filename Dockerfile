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

# Installs system dependencies, create the user, install Oh My Zsh, NVM, Pyenv, pyenv-virtualenv, 
# installs and globally sets the Python version, and does so as a single image layer.
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
    && echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER_NAME \
    && su - $USER_NAME -c "wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | bash" \
    && su - $USER_NAME -c "wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash" \
    && su - $USER_NAME -c "git clone https://github.com/pyenv/pyenv.git /home/$USER_NAME/.pyenv" \
    && su - $USER_NAME -c "git clone https://github.com/pyenv/pyenv-virtualenv.git /home/$USER_NAME/.pyenv/plugins/pyenv-virtualenv" \
    && su - $USER_NAME -c "echo 'export NVM_DIR=\"\$HOME/.nvm\"' >> ~/.zshrc" \
    && su - $USER_NAME -c "echo '[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"' >> ~/.zshrc" \
    && su - $USER_NAME -c "echo 'export ZSH=\"\$HOME/.oh-my-zsh\"' >> ~/.zshrc" \
    && su - $USER_NAME -c "echo 'ZSH_THEME=\"robbyrussell\"' >> ~/.zshrc" \
    && su - $USER_NAME -c "echo 'plugins=(git)' >> ~/.zshrc" \
    && su - $USER_NAME -c "echo 'source \$ZSH/oh-my-zsh.sh' >> ~/.zshrc" \
    && su - $USER_NAME -c "echo 'export PYENV_ROOT=\"\$HOME/.pyenv\"' >> ~/.zshrc" \
    && su - $USER_NAME -c "echo 'export PATH=\"\$PYENV_ROOT/bin:\$PATH\"' >> ~/.zshrc" \
    && su - $USER_NAME -c "echo 'eval \"\$(pyenv init --path)\"' >> ~/.zshrc" \
    && su - $USER_NAME -c "echo 'eval \"\$(pyenv init -)\"' >> ~/.zshrc" \
    && su - $USER_NAME -c "echo 'eval \"\$(pyenv virtualenv-init -)\"' >> ~/.zshrc" \
    && su - $USER_NAME -c "source ~/.zshrc && nvm install stable --delete-prefix && nvm alias default stable" \
    && su - $USER_NAME -c "source ~/.zshrc && pyenv install $PYTHON_VERSION --keep && pyenv global $PYTHON_VERSION && rm -rf /home/$USER_NAME/.pyenv/sources"

# Switch to non-root user. All commands from here are specifically for local environment to non-root user
USER $USER_NAME
WORKDIR /home/$USER_NAME

# Copy all necessary files and directories.
COPY --chown=$USER_NAME:$USER_NAME requirements.txt README.md ./
COPY --chown=$USER_NAME:$USER_NAME .jupyter ./.jupyter
COPY --chown=$USER_NAME:$USER_NAME .config ./.config

# Create the virtual environment and install the required packages.
RUN /usr/bin/zsh -c "source ~/.zshrc && pyenv virtualenv $PYTHON_VERSION $VENV_NAME && pyenv activate $VENV_NAME && pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r requirements.txt"

# Set default shell to zsh
SHELL ["/usr/bin/zsh"]

# Prefer the CMD exec form (["echo", "Hello"]) over the shell form (echo "Hello") for better signal handling and consistency.
CMD ["/usr/bin/zsh", "-c", "source ~/.zshrc && pyenv activate $VENV_NAME && jupyter lab --no-browser --ip=0.0.0.0 --port=8888"]
