FROM python:3.8
WORKDIR /app
COPY . .
RUN pip install Flask && pip install -U pytest
EXPOSE 5000
ENTRYPOINT ["python3", "app.py"]
FROM nginx:latest
COPY /nginx/nginx.conf /etc/nginx/nginx.conf
