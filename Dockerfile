FROM python:3.8
WORKDIR ./
COPY . .
RUN pip install Flask
EXPOSE 5000
ENTRYPOINT ["python", "app.py"]
FROM nginx:latest
WORKDIR /app
COPY --from=build /build/dist .
COPY nginx.conf /etc/nginx/nginx.conf
