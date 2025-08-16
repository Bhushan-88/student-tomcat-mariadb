# student-tomcat-mariadb
A Dockerized Java web application (student.war) deployed on Apache Tomcat 9 with MySQL/MariaDB database integration.  Includes JDBC connector configuration, database schema setup, and deployment instructions for running the student application  with RDS or local MariaDB.

# 📘 Student Application Deployment with Tomcat & MariaDB

This repository contains documentation and configuration files to deploy a **Java Student Web Application (`student.war`)** on **Apache Tomcat** inside Docker, with **MariaDB/MySQL** as the backend database.  

---

## 🚀 Features
- Dockerfile to build a Tomcat container with the student application.  
- Custom `context.xml` for database connectivity.  
- JDBC connector (`mysql-connector.jar`) copied into Tomcat `lib/`.  
- MariaDB setup instructions for **local Ubuntu** and **AWS RDS MariaDB**.  
- SQL schema for `students` table.  

---

## 🐳 Docker Setup (Tomcat + Student App)
student-app-docs/
│── Dockerfile
│── student.war
│── context.xml
│── mysql-connector.jar
│── README.md  

### 1. Build Docker Image
Make sure the following files are in your project directory:
- `Dockerfile`
- `student.war`
- `context.xml`
- `mysql-connector.jar`

Then build:
```bash
docker build -t student-tomcat .

2. Run Container
docker run -d -p 8080:8080 --name student-app student-tomcat

3. Access Application
http://localhost:8080/student

##Create rds DB Instance (mariadb)
copy endpoint

## MariaDB Setup (Ubuntu Server)

sudo apt update
sudo apt install mariadb-server -y
sudo systemctl enable mariadb
sudo systemctl start mariadb

Create Database on rds Using ec2  
mysql -h database-1.cmh2syigmz9t.us-east-1.rds.amazonaws.com -u admin -pmypassword

Commands:
create database studentapp;
use studentapp;
CREATE TABLE IF NOT EXISTS students(
    student_id INT NOT NULL AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    student_addr VARCHAR(100) NOT NULL,
    student_age VARCHAR(3) NOT NULL,
    student_qual VARCHAR(20) NOT NULL,
    student_percent VARCHAR(10) NOT NULL,
    student_year_passed VARCHAR(10) NOT NULL,
    PRIMARY KEY (student_id)
);

## Add DB Details Tomcat context.xml (DB Connection)
<Resource name="jdbc/TestDB" auth="Container" type="javax.sql.DataSource"
               maxTotal="100" maxIdle="30" maxWaitMillis="10000"
               username="USERNAME" password="PASSWORD" driverClassName="com.mysql.jdbc.Driver"
               url="jdbc:mysql://DB-ENDPOINT:3306/DATABASE"/>

Replace your_db_username, your_db_password, and your-db-host in context.xml.

Make sure mysql-connector.jar version matches your DB version.

Container listens on port 8080.

Open the student application in browser:

http://localhost:8080/student


