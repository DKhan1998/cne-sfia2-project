FROM python:3.8 as build
WORKDIR /app
COPY . .
RUN pip install Flask && pip install -U pytest
EXPOSE 5000
ENTRYPOINT ["python3", "app.py"]
FROM nginx:latest
WORKDIR /app
COPY nginx/nginx.conf /etc/nginx/nginx.conf
