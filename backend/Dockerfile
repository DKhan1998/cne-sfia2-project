FROM python:3.8
WORKDIR /backend
COPY app.py .
RUN pip install -r requirements.txt
RUN pip freeze > requirements.txt
EXPOSE 5001
ENTRYPOINT [ "python3", "app.py" ]