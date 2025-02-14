FROM python:3.12

WORKDIR /app

COPY . .

RUN cd /app && python -m venv --prompt cmladsb venv && source venv/bin/activate && pip install -r requirements.txt

# CMD ["python", "main.py"]
CMD ["/bin/zsh"]

# docker build -t python-app .
# docker run -it python-app

# docker run -it -v $(pwd):/app python-app


