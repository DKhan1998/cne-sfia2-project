x# QAC SFIA2 Project

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/0c689785321d4944a43a8344b425dc65)](https://app.codacy.com/manual/DKhan1998/cne-sfia2-project?utm_source=github.com&utm_medium=referral&utm_content=DKhan1998/cne-sfia2-project&utm_campaign=Badge_Grade_Settings)

This application is a simple [Flask application](https://flask.palletsprojects.com/en/1.1.x/quickstart/#a-minimal-application), ready to be deployed, for your SFIA2 project.

The following information should be everything you need to complete the project.

## Brief

The application must:

- Be deployed to a **Virtual Machine for testing**
- Be deployed in a **managed Kubernetes Cluster for production**
- Make use of a **managed Database solution**

## Application

The application is a Flask application running in **2 micro-services** (*frontend* and *backend*).  

The database directory is available should you: 
  - want to use a MySQL container for your database at any point, *or*
  - want to make use of the `Create.sql` file to **set up and pre-populate your database**.

The application works by:
1. The frontend service making a GET request to the backend service. 
2. The backend service using a database connection to query the database and return a result.
3. The frontend service serving up a simple HTML (`index.html`) to display the result.

### Database Connection

The database connection is handled in the `./backend/application/__init__.py` file.

A typical Database URI follows the form:

```
mysql+pymysql://[db-user]:[db-password]@[db-host]/[db-name]
```

An example of this would be:

```
mysql+pymysql://root:password@mysql:3306/orders
```

### Environment Variables

The application makes use of **2 environment variables**:

- `DATABASE_URI`: as described above
- `SECRET_KEY`: any *random string* will work here

### Running a Flask Application

Typically, to run a Flask application, you would:

1. Install the pip dependencies:

```
pip install -r requirements.txt
```

2. Run the application:

```
python3 app.py
```

![app-diagram](https://i.imgur.com/wnbDazy.png)

## Testing

Unit Tests have been included for both the frontend and backend services.

To test the backend service, you will need two things:

1. A database called `testdb`
2. A `TEST_DATABASE_URI` environment variable, which contains the database connection for the `testdb` database.

You can run the tests using the command:

```
pytest
```

To generate a coverage report, you will need to run:

```
pytest --cov application
```

## Infrastructure

The **Minimum Viable Product** for this project should at least demonstrate the following infrastructure diagram:

![mvp-diagram](https://i.imgur.com/i5qfOas.png)

**Stretch goals** for this project include:

- Using **Terraform to configure the Kubernetes Cluster** for production 
- Using **Terraform and Ansible to configure the Test VM**

Completing the stretch goals should yield an infrastructure diagram similar to the following:

![stretch-digram](https://i.imgur.com/Q5zljVl.png)

**Good luck!**
