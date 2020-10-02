FROM python:3.8-alpine
WORKDIR /backend
COPY . .
RUN pip install -r requirements.txt
RUN pip freeze > requirements.txt
EXPOSE 5001
CMD ["python3", "app.py"]
CMD ["pytest", "tests/test_backend.py"]
