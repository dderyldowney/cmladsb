# Dockerfile Documentation

This Dockerfile creates a containerized environment tailored for ZeroToMastery's Complete AI and Machine Learning Bootcamp, but it is also versatile enough for general Python programming, Machine Learning, and Data Science tasks. Below is a concise breakdown of its purpose, components, and customization options.

## Purpose

The container is designed to run Jupyter Lab with Python and Node.js, providing a robust development environment for AI, Machine Learning, and Data Science projects. It includes essential tools like pyenv for Python version management, NVM for Node.js, and Oh My Zsh for an enhanced shell experience.

## Base Image

- **Base Image**: `debian:bookworm-slim`
  - A lightweight Debian-based image is used for better reproducibility and reduced image size. This ensures a minimal environment with only essential packages.

## Maintainer Information

- **Maintainer**: `D Deryl Downey <ddd@davidderyldowney.com>`
  - Contact information for the maintainer of this Dockerfile.

## Exposed Ports

- **Port**: `8888`
  - Jupyter Lab will be accessible on port 8888. This port is exposed to allow external access to the Jupyter Lab interface.

## Build Arguments (Customizable Parameters)

The following build arguments can be customized during the build process to tailor the container to specific needs:

- **USER_NAME**: `python_user` (default)
  - The username for the non-root user created in the container. This user will have sudo privileges without a password.
  - **Customization**: Set a different username by passing `--build-arg USER_NAME=<your_username>` during the build.

- **UID**: `1000` (default)
  - The user ID for the non-root user. This ensures the user has a specific UID, which can be useful for file permissions.
  - **Customization**: Set a different UID by passing `--build-arg UID=<your_uid>` during the build.

- **GID**: `1000` (default)
  - The group ID for the non-root user. This ensures the user has a specific GID, which can be useful for file permissions.
  - **Customization**: Set a different GID by passing `--build-arg GID=<your_gid>` during the build.

- **DEBIAN_FRONTEND**: `noninteractive`
  - Prevents interactive prompts during package installation, ensuring the build process is non-interactive.

- **PYTHON_VERSION**: `3.12.9` (default)
  - The version of Python to be installed using `pyenv`.
  - **Customization**: Set a different Python version by passing `--build-arg PYTHON_VERSION=<your_python_version>` during the build.

- **VENV_NAME**: `cmladsb` (default) [Composed from the first letter of each word in the ZTM course name]
  - The name of the Python virtual environment created using `pyenv-virtualenv`.
  - **Customization**: Set a different virtual environment name by passing `--build-arg VENV_NAME=<your_venv_name>` during the build.

## System Dependencies

The following system dependencies are installed in a single layer to reduce the image size:

- `locales`, `procps`, `apt-transport-https`, `sudo`, `less`, `zsh`, `gnupg`, `curl`, `git`, `wget`, `vim`, `build-essential`, `libssl-dev`, `zlib1g-dev`, `libbz2-dev`, `libreadline-dev`, `libsqlite3-dev`, `llvm`, `libncursesw5-dev`, `xz-utils`, `tk-dev`, `libxml2-dev`, `libxmlsec1-dev`, `libffi-dev`, `liblzma-dev`, `ca-certificates`

These dependencies are essential for development, including tools for version control, text editing, and building Python from source.
The installation packages are removed from the image prior to layer export to further reduce the resulting image size.

- The `locales` package is installed, and the default locale set to `en_US.UTF8`.
  - You can change this at build time by changing the ``ARG LOCALE`` setting in the Dockerfile, or by passing the `--build-arg LOCALE=<your_locale>` flag on the command line at build time. Changes to this variable will propogate to all appropriate spots in the Dockerfile, as well as set the appropriate environment variables in the final image.

## User Configuration

- A non-root user (`python_user` by default) is created with the specified UID and GID.
- The user is added to the `sudo` group with passwordless sudo privileges, allowing the user to execute commands with elevated privileges without a password.

## Environment Setup

- **PYENV_ROOT**: `/home/python_user/.pyenv`
  - The root directory for `pyenv`, which is used to manage Python versions.
- **PATH**: `$PYENV_ROOT/bin:$PATH`
  - Adds `pyenv` to the PATH, making it accessible from the command line.

## Shell and Development Tools

- **Oh My Zsh**: Installed and configured with the `robbyrussell` theme and `git` plugin. This provides an enhanced shell experience with useful features and plugins.
- **NVM**: Installed for managing Node.js versions. NVM ensures that the stable version of Node.js is downloaded and used every time the image is built. This is particularly important because Jupyter Lab relies on Node.js as its backend JavaScript engine for certain operations, such as handling extensions, widgets, and other interactive features. By using NVM, the container guarantees compatibility with Jupyter Lab's requirements while also providing flexibility for users to easily switch to a different Node.js version if needed. This allows developers to adapt to specific project needs or test with alternative versions of Node.js without modifying the Dockerfile itself.
- **Pyenv**: Installed for managing Python versions. This allows you to install and switch between different versions of Python.
- **Pyenv-virtualenv**: Installed for managing Python virtual environments. This allows you to create isolated Python environments for different projects.

## Node.js Installation

- The latest stable version of Node.js is installed using `nvm` and set as the default. This ensures that Node.js is available for development.

## Python Installation

- The specified Python version (`3.12.9` by default) is installed using `pyenv`.
- A virtual environment (`cmladsb` by default) is created using `pyenv-virtualenv`. This virtual environment is activated during the build process.

## Python Dependencies

- The `requirements.txt` file is copied into the container. This file should list all Python dependencies required for the project.
- Python dependencies are installed in the virtual environment using `pip`. The `--no-cache-dir` flag is used to reduce the image size by not caching the downloaded packages.
- An image rebuild is called for any time this file is modified. It was initially generated using

```bash
pip freeze --local > requirements.txt
```

## Default Shell

- The default shell is set to `/usr/bin/zsh`. This ensures that the user will use `zsh` as the default shell when they start a session in the container. However, `bash` is also installed along with the baseline `sh`.

## Command Execution

- The container runs Jupyter Lab on startup, accessible at `http://0.0.0.0:8888`. The `--no-browser` flag prevents Jupyter Lab from trying to open a browser, and the `--ip=0.0.0.0` flag makes it accessible from outside the container.

## Usage & Customization

To build and run the Docker container, using a custom tag of jupyter-lab, with custom parameters:

```bash
docker build -t jupyter-lab --build-arg USER_NAME=<your_username> --build-arg UID=<your_uid> --build-arg GID=<your_gid> --build-arg LOCALE=<your_locale> --build-arg PYTHON_VERSION=<your_python_version> --build-arg VENV_NAME=<your_venv_name> .
docker run -p 8888:8888 jupyter-lab
```

If you want to accept all the defaults specified in the Dockerfile itself, you can build just specifying:

```bash
docker build -t cmladsb .
```

Then, to create, and immediately use, a container from the resulting image:

```bash
docker run --rm -it cmladsb
```

## Notes

- The container is optimized for development with Python using Jupyter Lab. Node.js is included for Jupyter Lab's use.
- The `requirements.txt` file should be placed in the same directory as the Dockerfile before building the image.
- Customizing the build arguments allows you to tailor the container to your specific needs, such as using a different Python version or virtual environment name.
- If you run the container detached, you can find the token needed for login under the container's 'Vew Details', which is under the 3-dot elipse to the far right of it's name in the Docker Desktop GUI's Containers view. It's between the Stop and the Delete icons.
- The container can be used for general Python programming, without running Jupyter Lab, easily by simply overriding the CMD instruction from the command line. More information can be found in the associated [Docker documentation](https://docs.docker.com/get-started/docker-concepts/running-containers/overriding-container-defaults/)
