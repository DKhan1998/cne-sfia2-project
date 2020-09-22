FROM python:3.8
COPY . .
RUN pip install -r requirements.txt
RUN pip freeze > requirements.txt
ENTRYPOINT [ "python3", "app.py" ]