FROM python:3.8
WORKDIR ./
COPY . .
RUN pip install Flask
EXPOSE 5000
ENTRYPOINT ["python", "app.py"]