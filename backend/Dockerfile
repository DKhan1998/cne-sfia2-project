FROM python:3.8-alpine
WORKDIR /backend
COPY . .
RUN pip install -r requirements.txt
RUN pip freeze > requirements.txt
EXPOSE 5001
ENTRYPOINT ["/usr/bin/python3", "app.py"]