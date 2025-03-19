# Project Base Image Information

## Base Image and Port Configuration

This project uses a lightweight Debian-based container image as its foundation:

* **Base Image**: `debian:bookworm-slim`
  * Chosen for its minimal footprint
  * Provides essential system utilities
  * Debian Bookworm (stable) based

* **Port Configuration**: `8888`
  * Reserved for Jupyter Lab web interface
  * Enables browser-based access to notebooks
  * Configurable through the `docker run` command

## Build Arguments Configuration

The following build arguments can be customized during image construction:

| Argument | Default | Description |
|----------|---------|-------------|
| USER_NAME | python_user | Non-root username with sudo privileges for container operations |
| UID/GID | 1000 | User and Group IDs for file permission management |
| DEBIAN_FRONTEND | noninteractive | Prevents interactive prompts during package installation |
| LOCALE | en_US. UTF-8 | System locale settings for character encoding and language |
| PYTHON_VERSION | 3.12.9 | Specific Python version to be installed via pyenv |
| VENV_NAME | cmladsb | Virtual environment name for project isolation |

### Customization Examples

To customize the build with specific arguments:

```bash
# Basic customization
--build-arg USER_NAME=<username> --build-arg PYTHON_VERSION=<version>

# Full customization
--build-arg USER_NAME=data_scientist \
--build-arg PYTHON_VERSION=3.11.0 \
--build-arg VENV_NAME=ml_project
```

## System Dependencies

The image includes carefully selected development packages installed in a single layer to minimize image size:

### Build Tools

* `build-essential`: Compilation tools and libraries
* `libssl-dev`: SSL development libraries
* `zlib1g-dev`: Compression library development files

### Version Control

* `git`: Distributed version control system

### Development Environment

* `zsh`: Advanced shell for improved productivity
* `vim`: Powerful text editor for development

### System Utilities

* `curl`: Command line tool for transferring data
* `wget`: Network downloader
* `sudo`: Elevated privileges management
* `locales`: Language and regional settings

### Python-Specific Dependencies

* `libreadline-dev`: Command line editing library
* `libsqlite3-dev`: SQLite database engine
* `libffi-dev`: Foreign Function Interface library
* `libpq-dev`: PostgreSQL development files

**Important Note**: All package installation caches are automatically cleared after installation to optimize the final image size and reduce the container footprint.

* This is achieved with `apt-get clean` to remove cached package files and `rm -rf /var/lib/apt/lists/*` to delete package lists. While requiring a manual `sudo apt update` to refresh packages, this minimizes image size as much as possible while retaining essential dependencies.
* The final image remains large, due to the combined `PyTorch` and `Computer Vision` support packages, however, attention to removing unnecessary installation packages and package lists remains, as always, crucial in a containerized environment to optimize deployment speed and resource usage.
