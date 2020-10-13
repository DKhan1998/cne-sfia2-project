x# QAC SFIA2 Project

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/0c689785321d4944a43a8344b425dc65)](https://app.codacy.com/manual/DKhan1998/cne-sfia2-project?utm_source=github.com&utm_medium=referral&utm_content=DKhan1998/cne-sfia2-project&utm_campaign=Badge_Grade_Settings)

The application is a simple Flask application, built in Python, that makes use of a microservice architecture comprising of 2 separate services.

## Brief

The application must:

- Be deployed to a **Virtual Machine for testing**
- Be deployed in a **managed Kubernetes Cluster for production**
- Make use of a **managed Database solution**

## Application

The application works by:
1. The frontend service making a GET request to the backend service. 
2. The backend service using a database connection to query the database and return a result.
3. The frontend service serving up a simple HTML (`index.html`) to display the result.

### Constraints

1. Kanban Board: Jira
2. Version Control: Git
3. CI Server: Jenkins
4. Configuration Management: Ansible
5. Cloud Server: AWS EC2
6. Database Server: AWS RDS
7. Containerisation: Docker
8. Reverse Proxy: NGINX
9. Orchestration Tool: Kubernetes
10. Infrastructure Management: Terraform

### Project Planning

## MOSCOW Analysis

![MOSCOW](img/MoSCoW%20Prioritization%20and%20Scoping.png)

## Risk Assessment

![Risk-Assessment](https://daoodk.atlassian.net/l/c/NwjBBk2Q)

## JIRA Board

![Jira-front](img/jira1.png)
![Jira-more](img/jira2.png)

### Continuous Integration

The project infrastructure follows this design
*   Terraform builds resources
*   Ansible configures them
*   Jenkins builds application
*   Jenkins Runs test in py-environmnet
*   Test application using a testdb
*   Manually deploy project images to docker hub
*   Manually run kurbenetes deployment configured to run on deploydb


![app-diagram](img/crop)

## Jenkins

![jenkins-img](img/jenkins.png)

## Testing

Pytest is done using the python interpreter in pytest, where jenkins will assign a testdb vm to build and test the project.

The following screenshots represent the test scenarios;

![pytest1](img/pytest1.png)
![pytest2](img/pytest2.png)

## Kubernetes

We run Kubernetes manually as we lack configuration to run independently through jenkins and terraform

![cluster-down](img/k8s.png)
![cluster-run](img/runk8s.png)
