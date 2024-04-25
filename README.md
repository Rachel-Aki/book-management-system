# book-management-system
## My name
Yuxin Wang

## Overview
Currently we have these repositories:
- book-management-mobile : The ios code
- book-management-backend: Our backend api

## TechStack
- Java
- Swift
- PostgreSQL

## Setup Backend
- start PostgreSQL
```
brew services start postgresql
```

- create database in your local
```
CREATE DATABASE book_management;
USE book_management;
CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  author VARCHAR(255) NOT NULL,
  publication_year INT,
  isbn VARCHAR(20) UNIQUE NOT NULL
);
```
- config url, name and password of database in `application.properties` file

- run backend
```
mvn spring-boot:run -e
```

## mobile
- open `book-management-mobile` in Xcode
- build and run code
