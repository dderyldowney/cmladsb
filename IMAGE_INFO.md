# Project Base Image Information

## Base Image

- **Base Image**: `debian:bookworm-slim`
  - A lightweight Debian-based image is used for better reproducibility and reduced image size. This ensures a minimal environment with only essential packages.

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

- **LOCALE**: `en_US.UTF-8` (default)
  - The default locale for the resulting image.
  - **Customization**: Set a different locale choice if en_US.UTF-8 is not workable for you.

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
