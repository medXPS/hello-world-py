
FROM python:3.8
WORKDIR /usr/src/app
COPY hello.py .
CMD ["python", "./hello.py"]
