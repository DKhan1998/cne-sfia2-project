FROM python:3.8

# Create app directory
WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

EXPOSE 5001

ENTRYPOINT [ "python", "app.py" ]