FROM python:3.7
WORKDIR /app
RUN sudo apt-get install python-matplotlib
RUN pip install -r requirements.txt
RUN pip freeze > requirements.txt
COPY app.py .
EXPOSE 5000
ENTRYPOINT ["python", "app.py"]