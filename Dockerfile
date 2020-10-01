FROM python:3.8-alpine
WORKDIR /app
COPY . .
RUN pip install python3