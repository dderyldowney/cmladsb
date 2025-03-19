# User and Environment Information

## Project User Configuration

- A non-root user (`python_user` by default) is created with the specified UID and GID.
- The user is added to the `sudo` group with passwordless sudo privileges, allowing the user to execute commands with elevated privileges without a password.

## Project Environment Setup

- **PYENV_ROOT**: `/home/python_user/.pyenv`
  - The root directory for `pyenv` is used to manage Python versions.
- **PATH**: `$PYENV_ROOT/bin:$PATH`
  - Adds `pyenv` to the PATH, making it accessible from the command line.

## Shell and Development Tools

- **Oh My Zsh**: Installed and configured with the `robbyrussell` theme and `git` plugin. This provides an enhanced shell experience with useful features and plugins.
- **NVM**: Installed to manage Node.js versions. NVM ensures that the stable version of Node.js is downloaded and used every time the image is built. This is particularly important because Jupyter Lab relies on Node.js as its backend JavaScript engine for certain operations, such as handling extensions, widgets, and other interactive features. By using NVM, the container guarantees compatibility with Jupyter Lab's requirements while also providing flexibility for users to easily switch to a different Node.js version if needed. This allows developers to adapt to specific project needs or test with alternative versions of Node.js without modifying the Dockerfile itself.
- **Pyenv**: Installed for managing Python versions. This allows you to install and switch between different versions of Python.
- **Pyenv-virtualenv**: Installed for managing Python virtual environments. This allows you to create isolated Python environments for different projects. Python 3.x incorporates this behavior into its `venv` module which is another possible choice for user customization.
