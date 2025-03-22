# Project Documentation

Both this Project's Dockerfile and Compose files establish a robust, containerized development environment tailored for AI, Machine Learning, and Data Science, aligned with ZeroToMastery's Bootcamp. It features Jupyter Lab with Python and Node.js, enhanced by essential tools like `pyenv`, `NVM`, and `Oh My Zsh`.

## Maintainer

* **D Deryl Downey** (`ddd@davidderyldowney.com`)

## Image & User Information

* Comprehensive image details: [`IMAGE_INFO.md`](IMAGE_INFO.md)
* User-specific environment settings: [`USER_AND_ENVIRONMENT.md`](USER_AND_ENVIRONMENT.md)

## Key Components

### **Programming Environment**

* **Node.js**: Installed via `nvm` for streamlined version management.
* **Python**: Managed via `pyenv` (default: `3.12.9`), with a dedicated virtual environment (`cmladsb`) handled by `pyenv-virtualenv`.
* **Python Dependencies**: Defined in `requirements.txt`, installed using `pip --no-cache-dir` for minimal image size.
* **Enhanced Development**: Jupyter Lab supports LSP (Jedi) for intelligent code completion and CodeMirror for real-time syntax highlighting.
* **Shell Environment**: Default shell is `/usr/bin/zsh` with `bash` and `sh` available.

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

### Using Docker Compose

The `docker-compose.yaml` file simplifies the build and run process.

* To build the image for the first time, use:

    ```bash
    docker-compose build
    ```

    This command builds, but does nothing further with, the container image defined in the `docker-compose.yaml` file.

    To build the image for the first time, *and* run it detached, use:

    ```bash
    docker-compose up --build -d
    ```

* This command will build and start the container in detached mode, allowing you to run it in the background.

  * The `--build` flag ensures that the image is built before starting the container, which is useful if you have made changes to the Dockerfile or the application code.

  * The `-d` flag runs the container in detached mode, allowing you to run it in the background.  

* The `docker-compose up` command will create the container and start it, along with any other services defined in the `docker-compose.yaml` file.

    Once created, in the future you can start the container with:

    ```bash
    docker-compose up -d
    ```

    This command will start the container in detached mode, allowing you to run it in the background.

    To stop the container, use:

    ```bash
    docker compose down
    ```

    This command stops and removes the container, along with any associated networks.

* Developers can use the Docker Compose `watch` command to monitor changes in the codebase and automatically rebuild the container when changes are detected. This is particularly useful for development environments where frequent code changes occur.

    To use the watch command, run:

    ```bash
    docker-compose up --build -d --watch
    ```

    This command will start the container in detached mode, allowing you to run it in the background. The `--watch` flag enables the watch mode, which monitors changes in the codebase and automatically rebuilds the container when changes are detected. This is particularly useful for development environments where frequent code changes occur. Changes to the Dockerfile or the application code will trigger a rebuild of the container image.

    It rebuilds the image for the corresponding service using your local Dockerfile.
    Then, it recreates and restarts the container using the updated image.

    It does NOT automatically pull or update the base image in your Dockerfile unless:

  * You explicitly run `docker compose build --pull`, or
    * You run `docker compose up --build --pull`, or
    * You run `docker compose up --build` and the base image has changed, or
    * You modify the defined base image in the `FROM` line of your Dockerfile and manually rebuild.

    **NOTE:** This is a good practice to ensure that you are using the latest version of the base image.
    However, if you want to ensure that you are always using the latest version of the base image, you can add the --pull flag to the `docker compose build` command. This will pull the latest version of the base image before building your container.

* The `docker-compose.yaml` file is designed to be user-friendly, allowing for easy customization of the container environment. Users can modify the build arguments in the `docker-compose.yaml` file, just like they can in the main `Dockerfile` to personalize their environment.

* The `docker-compose.yaml` file builds the image, runs the container, exposes Jupyter Lab on port 8888, puts the container in the background, creates and starts a containerized Postgres database, which can be accessed at `localhost:5432` with the default user `postgres` and password `postgres_password`, and finally creates a database user with the same name as the container's chosen username with CREATE and DROP rights.
The database defaults to `default_db`, but can be changed in the `docker-compose.yaml` file, or in the user-created `.env` file.

* The main container, `cmladsb_container`, has a default DATABASE_URL environment variable set to `postgresql://python_user:postgres_password@db:5432/postgres`, allowing easy connection to the database. The user name and password can be changed in the `docker-compose.yaml` file, or the `.env` file.

* It is more convenient, and much safer, to use an `.env` file containing these variables, as the `docker-compose.yaml` file will automatically pick them up. This also keeps your credentials out of the codebase.

* The `docker-compose.yaml` file also includes a docker volume, `postgres_db`, for persistent db storage, ensuring that any changes made to the database are retained even after the container is stopped.

* The container also has a Docker volume mounted on `/home/$USER_NAME/workspace`, which allows you to store, and provide future access to, both your data and your work and code.

* **NOTE:** The database container is *only* set up if you utilize the docker-compose.yaml file. If you run the container using the simpler `docker build` and `docker run` commands, the database will *not* be created.

* The container is set to restart automatically if it stops, ensuring that your work is not interrupted.

## Preinstalled Modules

### **Development & Debugging**

* `black` – Enforces consistent code formatting.
* `debugpy` – Enables remote debugging.
* `flake8` – Ensures PEP 8 compliance.

### **Interactive Computing**

* `ipykernel`,  `ipython`,  `jupyterlab`,  `jupyterlab-server`

### **Data Science & Visualization**

* `matplotlib`,  `numpy`,  `pandas`,  `seaborn`

### **Machine Learning & Scientific Computing**

* `fairly`,  `scikit-learn`,  `scipy`,  `torch`,  `torchvision`

### **Computer Vision & AI**

* `opencv-python` – Computer vision library.

### **Validation & Testing**

* `pydantic`,  `pytest`

### **Web & API Integration**

* `open-webui`

### **Database Management**

* libpq-dev – Header files for PostgreSQL module building.
* PostgreSQL client – Command-line tool for PostgreSQL.

## Additional Insights

* Shallow, and generalized, dive into AI concepts: [`AI_ANI_AGI.md`](AI_ANI_AGI.md)
* Human-readable Git log summaries: [`CHANGELOG.md`](CHANGELOG.md)

## Important Considerations

* **Storage Alert**: Expect a large image size; ensure sufficient disk space.
* **Customization**: Modify build arguments as needed to personalize the environment.
* **Accessing Login Tokens**: If running detached, locate the Jupyter token under 'View Details' in the Docker Desktop.
* **Locale Configuration Issues?** Resolve using:

```bash
sudo locale-gen --purge
sudo dpkg-reconfigure locales
```

* **Running Python Independently**: Override the `CMD` instruction to bypass Jupyter Lab. Learn more in the [Docker Documentation](https://docs.docker.com/get-started/docker-concepts/running-containers/overriding-container-defaults/).

## Security Notes

Make sure to manage sensitive data and credentials appropriately, especially when using Docker in production environments. Regularly review and update your security practices to mitigate potential vulnerabilities. Ensure to use environment variables for sensitive information and consider using secrets-management tools for enhanced security.

## Performance

Monitor resource usage, especially when running multiple containers or resource-intensive applications. Consider implementing resource limits to optimize performance.

## Documentation

Refer to the official Docker documentation for more in-depth information on [`Docker`](https://docs.docker.com/manuals) and [`Docker Compose`](https://docs.docker.com/compose/) usage. Regularly review and update your security practices to mitigate potential vulnerabilities.

While it was said previously, it's worth stating again: make sure to manage sensitive data and credentials appropriately, especially when using Docker in production environments.

Consider implementing resource limits to optimize performance.

## Community Support

Engage with the Docker community for troubleshooting and best practices.

## Summary

The Project's Docker setup is designed to be user-friendly, with a focus on providing a seamless experience for developers and data scientists. It includes a variety of preinstalled modules and tools that are commonly used in AI, machine learning, computer vision, and data science projects.

The use of Docker Compose simplifies the process of building and running the container, making it accessible even for those who may not be familiar with Docker. The inclusion of a PostgreSQL database allows for easy data management and storage, while the persistent volumes ensure that data is retained across container restarts.

The containerized environment is built to be easily customizable, allowing users to adapt it to their specific needs and preferences. The inclusion of a PostgreSQL database and persistent storage options further enhances its utility for data-driven applications.
The documentation provides clear instructions on building, running, and customizing the container, making it a valuable resource for developers and data scientists alike. The focus on security, performance, and community support should assure users they can confidently utilize this setup in their projects.

## Feedback

Contributions and suggestions for improvements are welcome. Please reach out via the provided contact information.
