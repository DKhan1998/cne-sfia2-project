FROM python:3.8 as build
WORKDIR ./
COPY . .
RUN pip install Flask
EXPOSE 5000
ENTRYPOINT ["python3", "app.py"]
FROM nginx:latest
WORKDIR /app
COPY --from=build /build/dist .
COPY nginx.conf /etc/nginx/nginx.conf
