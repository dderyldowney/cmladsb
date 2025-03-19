# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

## [2025-03-19]

* **Reworked README**: Made it more concise and professional.

## [2025-03-18]

* **Documentation Fixes**:
  * Corrected spelling and grammar in `WORK_DONE.md`
  * Corrected spelling and grammar in `README.md`
* **Enhancements**:
  * Added `.env` file usage for environment variables.
  * Introduced watch capability for `cmladsb_container`, controlled via `docker compose watch`.
  * Added workspace directory, PostgreSQL client support, and headers.
  * Moved documentation files to a dedicated directory.
  * Updated `docker-compose.yaml`, renamed `compose.yml` to `docker-compose.yaml`.
  * Configured container workspace and database volume.

## [2025-03-16]

* **Optimizations**:
  * Streamlined `COPY` command to bulk inject Markdown (`.md`) files into the Docker image.
* **Markdown Improvements**:
  * Fixed formatting in `WORK_DONE.md`
  * Updated `README` with a "Project Git Log" section.
  * Broke down `README.md` into multiple files:
    * `IMAGE_INFO.md`
    * `USER_AND_ENVIRONMENT.md`
  * Created `WORK_DONE.md` as a summary file linked to the README.
* **Git Enhancements**:
  * Added AI descriptions file (`AI_ANI_AGI.md`).
  * Linked AI descriptions file in `README.md`.
  * Fixed AI descriptions link syntax.

## [2025-03-15]

* **Development Tools**:
  * Added `fairly` for research recordset management.
  * Integrated `pytest` for testing.
* **Dependency Updates**:
  * Updated `requirements.txt` to focus on core and addon packages.
  * Added `Capabilities Provisioning` section in `README.md`.

## [2025-03-14]

* **Container & Infrastructure**:
  * Updated `jupyterlab` to `4.3.6`.
  * Reorganized `Dockerfile` for a cleaner separation of base work and `python_user`.
  * Implemented Dockerfile linting.

## [2025-02-22]

* **Jupyter Enhancements**:
  * Explicitly added `jupyter_codemirror` to server extensions.
  * Enabled auto brackets and quotes in Jupyter Notebook.
  * Enhanced code editing features (matching brackets, quotes).
  * Enabled full `Jedi Language Server` support for notebooks and standalone files.
* **Docker & Build Improvements**:
  * Removed `aws_sagemaker` extension.
  * Added Jupyter Lab language server support.
  * Updated Docker build examples to use `buildx build`.
  * Reduced Docker image layers via optimized `RUN` commands.

## [2025-02-21]

* **Bug Fixes & Workarounds**:
  * Fixed missing port information in the `run` command.
  * Added a workaround for corrupted locale generation during build.
  * Documented LOCALE changes in `README.md`.

## [2025-02-15]

* **Project Initialization**:
  * Added `README.md`.
  * Updated `Dockerfile` for native Python `venv` usage.
  * Exported all local packages to `requirements.txt`.
  * Configured `.devcontainer` setup.
  * Integrated `pip freeze --local` output into `requirements.txt`.

## [2025-02-14]

* **Dockerization & Virtual Environment**:
  * Added base skeleton for Docker-based environment.
  * Created virtual environment `cmladsb` and pre-installed necessary packages.

## [2025-02-13]

* **Initial Commit**:
  * Bootstrapped project using **ZTM's Complete Machine Learning and Data Science Bootcamp**.
  * Created a new repository for the project.
