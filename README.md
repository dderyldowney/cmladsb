# Complete AI and Machine Learning Bootcamp

This repository is designed for use with [ZeroToMastery's](https://zerotomastery.io) Complete AI and Machine Learning Bootcamp. However, it can also be used as a resource for any Python project.

## Overview

I wanted a virtual machine I could use for ZTM's bootcamp which covers a wide range of topics in AI and Machine Learning, including but not limited to:

- Data Preprocessing
- Exploratory Data Analysis
- Supervised Learning
- Unsupervised Learning
- Neural Networks
- Deep Learning
- Natural Language Processing
- Model Deployment

I also wanted it to be versatile enough to be used with just about any Python 3 project. So, I created this.
It uses the smallest Debian image, adds in [PyEnv](https://github.com/pyenv/pyenv), installs the latest
[Python 3.12](https://docs.python.org/3.12/) (which is 3.12.9 as of this timestamp), creates a virtual environment 
named under the user's ``$HOME/venv`` directory, with the prompt set to *cmladsb*, and installs Jupyter Notebooks, 
ipykernel, etc. Look in ``requirements.txt`` to see what exactly is installed.

I consciously chose not to use Python 3.13 because there are several issues between 3.13 and some of the
packages used in the course, but the entire 3.12 series works just fine.

## Getting Started

Make sure you have [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed for your OS, 
and that it is configured and running.

To get started with *this* repository, clone it to your local machine and build the image:

```bash
git clone https://github.com/dderyldowney/cmladsb.git
cd cmladsb
docker build -t cmladsb .
```

To use this, you can either open the project in VSCode, or its derivatives like Cursor or Windsurf, and choose
to Run In Container from VSCOde's command palate, use it as the base image for your own project(s), or execute it
from docker like:

```bash
docker run --rm -it cmladsb
```

## Requirements

Inside the image this Dockerfile creates, if you just attach to it or Run In Container, you need to run:

```bash
source venv/bin/activate
```
because the image's CMD gets overriden when you launch it manually.

If, for some reason, after loading the virtualenv, the packages don't show when you run ``pip list --local``, 
just run the command:

```bash
pip install --upgrade pip 
pip install --no-cache-dir -r requirements.txt
```

Then, just code like normal. Ypu'll need to install vim, less, etc manually via the ``apt`` package manager.
The user in the image is ``python_app``and is a member of the ``sudo`` group already. The password is disabled 
on the user. The default shell is ``/usr/bin/zsh`` and comes with [Oh-My-Zsh](https://ohmyz.sh/) installed.


## Usage

You can use the notebooks and scripts in this repository to follow along with the bootcamp or to work on your own Python projects.

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request for any improvements or additions.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [ZeroToMastery](https://zerotomastery.io) for providing their bootcamp! Well worth the yearly subscription fee!

D Deryl Downey

Happy coding!