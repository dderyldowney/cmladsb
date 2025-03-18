# Dockerfile Documentation

This Dockerfile creates a containerized environment tailored for ZeroToMastery's Complete AI and Machine Learning Bootcamp, but it is also versatile enough for general Python programming, Machine Learning, and Data Science tasks. Below is a concise breakdown of its purpose, components, and customization options.

## Maintainer Information

- **Maintainer**: `D Deryl Downey <ddd@davidderyldowney.com>`
  - Contact information for the maintainer of this Dockerfile.

## Purpose

The container is designed to run Jupyter Lab with Python and Node.js, providing a robust development environment for AI, Machine Learning, and Data Science projects. It includes essential tools like pyenv for Python version management, NVM for Node.js, and Oh My Zsh for an enhanced shell experience.


## Image Information

All basic information regarding the image's settings like exposed ports, build arguments and system dependencies are now maintained in a separate file, found here: [`IMAGE_INFO.md`](IMAGE_INFO.md)

## User and Environment

All information regarding the local User and their environment is now maintained in a separate file, found here: [`USER_AND_ENVIRONMENT.md`](USER_AND_ENVIRONMENT.md)

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

## Enhanced Code Editing Features

Jupyter Lab support for LSP (Language Server Protocol) has been enabled for tab completion in notebooks and Python files, powered by the Jedi Language Server. The CodeMirror extension is also enabled ensuring syntax highlighting and automatic addition of matching brackets and quotes as you type.

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
docker run --rm -it -p 8888:8888 cmladsb
```

## Capability Provisioning

The following modules are utilized to support the project's functionality, ensuring efficient development, debugging, data processing, and machine learning capabilities.

### **Development & Debugging**

- `black` – Code formatter ensuring consistent Python style.
- `debugpy` – Debugging tool enabling remote debugging.
- `flake8` – Linter enforcing PEP 8 compliance.

### **Interactive Computing & Notebooks**

- `ipykernel` – Jupyter kernel for Python execution.
- `ipython` – Interactive Python shell.
- `jupyterlab` – Web-based interactive development environment.
- `jupyterlab-server` – Backend server support for JupyterLab.

### **Data Processing & Visualization**

- `matplotlib` – Plotting library for data visualization.
- `numpy` – Numerical computing library supporting large arrays and matrices.
- `pandas` – Data manipulation and analysis library.
- `seaborn` – Statistical data visualization built on Matplotlib.

### **Machine Learning & Scientific Computing**

- `fairly` – Framework for reproducible research and AI workflows.
- `scikit-learn` – Machine learning algorithms and tools.
- `scipy` – Scientific computing and numerical analysis library.
- `torch` – PyTorch deep learning framework.
- `torchvision` – Computer vision tools for PyTorch.

### **Computer Vision**

- `opencv-python` – OpenCV bindings for computer vision applications.

### **Validation & Testing**

- `pydantic` – Data validation and settings management using Python type hints.
- `pytest` – Testing framework for scalable and efficient test execution.

### **Web & API Integration**

- `open-webui` – Web UI for interacting with models and applications. It is also the source of the website used in this image.

This set of modules ensures robust, scalable, and efficient workflows across data processing, visualization, machine learning, and development environments.

## Additional Information

This project offers a generalistic exploration of the different levels of artificial intelligence, providing detailed descriptions and examples of their distinctions. It covers [`Artificial Intelligence (AI), Artificial Narrow Intelligence (ANI), and Artificial General Intelligence (AGI)`](AI_ANI_AGI.md) from a broad and insightful perspective.

For those seeking to understand AI fundamentals, this resource serves as an essential guide, making it an invaluable read for learners and enthusiasts alike.

## Project Git Log

As I have time, I summarize the content of the git log stream into [WORK_DONE.md](WORK_DONE.md) in a more human-readable and digestible format. I fully admit to using ANI services to accomplish this. This is currently a manual process linked to my remembrance of rerunning the creation task.

## Project Notes

- **WARNING:** The image(s) resulting from this project are quite large. Be prepared for this in your storage
preparations.
- The container is optimized for development with Python using Jupyter Lab. Node.js is included for Jupyter Lab's use.
- The `requirements.txt` file should be placed in the same directory as the Dockerfile before building the image.
- Customizing the build arguments allows you to tailor the container to your specific needs, such as using a different Python version or virtual environment name.
- If you run the container detached, you can find the token needed for login under the container's 'View Details', which is under the 3-dot ellipse to the far right of its name in the Docker Desktop GUI's Containers view. It's between the Stop and the Delete icons.
- The container can be used for general Python programming, without running Jupyter Lab, easily by simply overriding the CMD instruction from the command line. More information can be found in the associated [Docker documentation](https://docs.docker.com/get-started/docker-concepts/running-containers/overriding-container-defaults/)
- If you find that locales are causing an issue for you, please do the following.

    ```bash
    sudo locale-gen --purge
    sudo dpkg-reconfigure locales
    ```

  At the resulting interactive prompt, simply select the appropriate number (97 for en_US.UTF-8 for example) for your locale and the system will regenerate the appropriate one and apply it system-wide for you. Occasionally, the generation of locale files is corrupted and needs repair. This has been a glitch for years. This handles that for you, albeit through manual reconfiguration.
- If you're a bit more adventurous about your setup, using a Docker volume for the user home dir, or even just a Notebooks directory under it, would be a logical choice for possible user-defined changes.

