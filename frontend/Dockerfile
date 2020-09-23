FROM python:3.7
WORKDIR /frontend
COPY . .
RUN pip install -r requirements.txt
RUN pip freeze > requirements.txt
EXPOSE 5000
ENTRYPOINT ["python", "app.py"]