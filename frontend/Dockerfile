FROM python:3.7
WORKDIR /app
RUN pip install requirements.txt
COPY app.py .
EXPOSE 5000
ENTRYPOINT ["python", "app.py"]