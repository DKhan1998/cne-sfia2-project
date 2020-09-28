FROM python:3.8-alpine as build
WORKDIR /build
COPY . .
RUN pip install Flask && pip install -U pytest
EXPOSE 5000
ENTRYPOINT ["python3", "app.py"]
FROM nginx:latest
WORKDIR /app
COPY --from=build /build/dist .
COPY /nginx/nginx.conf /etc/nginx/nginx.conf
