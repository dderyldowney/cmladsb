# Dockerfile Documentation

This Dockerfile establishes a robust, containerized development environment tailored for AI, Machine Learning, and Data Science, aligned with ZeroToMastery's Bootcamp. It features Jupyter Lab with Python and Node.js, enhanced by essential tools like `pyenv`, `NVM`, and `Oh My Zsh`.

## Maintainer
- **D Deryl Downey** (`ddd@davidderyldowney.com`)

## Image & User Information
- Comprehensive image details: [`IMAGE_INFO.md`](IMAGE_INFO.md)
- User-specific environment settings: [`USER_AND_ENVIRONMENT.md`](USER_AND_ENVIRONMENT.md)

## Key Components
### **Programming Environment**
- **Node.js**: Installed via `nvm` for streamlined version management.
- **Python**: Managed via `pyenv` (default: `3.12.9`), with a dedicated virtual environment (`cmladsb`) handled by `pyenv-virtualenv`.
- **Python Dependencies**: Defined in `requirements.txt`, installed using `pip --no-cache-dir` for minimal image size.
- **Enhanced Development**: Jupyter Lab supports LSP (Jedi) for intelligent code completion and CodeMirror for real-time syntax highlighting.
- **Shell Environment**: Default shell is `/usr/bin/zsh` with `bash` and `sh` available.

## Container Execution
Jupyter Lab launches on startup at `http://0.0.0.0:8888`, utilizing `--no-browser` and `--ip=0.0.0.0` for external accessibility.

## Deployment & Customization
### **Building & Running with Custom Parameters**
```bash
docker build -t jupyter-lab --build-arg USER_NAME=<your_username> --build-arg UID=<your_uid> --build-arg GID=<your_gid> --build-arg LOCALE=<your_locale> --build-arg PYTHON_VERSION=<your_python_version> --build-arg VENV_NAME=<your_venv_name> .
docker run -p 8888:8888 jupyter-lab
```
### **Quick Start with Defaults**
```bash
docker build -t cmladsb .
docker run --rm -it -p 8888:8888 cmladsb
```

## Preinstalled Modules
### **Development & Debugging**
- `black` – Enforces consistent code formatting.
- `debugpy` – Enables remote debugging.
- `flake8` – Ensures PEP 8 compliance.

### **Interactive Computing**
- `ipykernel`, `ipython`, `jupyterlab`, `jupyterlab-server`

### **Data Science & Visualization**
- `matplotlib`, `numpy`, `pandas`, `seaborn`

### **Machine Learning & Scientific Computing**
- `fairly`, `scikit-learn`, `scipy`, `torch`, `torchvision`

### **Computer Vision & AI**
- `opencv-python` – Computer vision library.

### **Validation & Testing**
- `pydantic`, `pytest`

### **Web & API Integration**
- `open-webui`

## Additional Insights
- Deep dive into AI concepts: [`AI_ANI_AGI.md`](AI_ANI_AGI.md)
- Human-readable Git log summaries: [`WORK_DONE.md`](WORK_DONE.md)

## Important Considerations
- **Storage Alert**: Expect a large image size; ensure sufficient disk space.
- **Customization**: Modify build arguments as needed to personalize the environment.
- **Accessing Login Tokens**: If running detached, locate the Jupyter token under 'View Details' in Docker Desktop.
- **Persistent Storage**: Consider Docker volumes for preserving user data.
- **Locale Configuration Issues?** Resolve using:
```bash
sudo locale-gen --purge
sudo dpkg-reconfigure locales
```
- **Running Python Independently**: Override the `CMD` instruction to bypass Jupyter Lab. Learn more in the [Docker Documentation](https://docs.docker.com/get-started/docker-concepts/running-containers/overriding-container-defaults/).

This refined Docker setup ensures a seamless, professional development experience, equipping you with a powerful, scalable environment for AI, data science, and machine learning projects.


