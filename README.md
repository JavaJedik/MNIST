# MNIST

```bash
sudo apt update && sudo apt upgrade -y
```

## Adatbázis

A database mappában van az mnist_dump.sql fájl, amit be kell importálni a MariaDB adatbázisba.

```bash
sudo apt install mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql_secure_installation

sudo mysql
SELECT User FROM mysql.user;
CREATE DATABASE mnist;
USE mnist;
CREATE USER 'mnist'@'localhost' IDENTIFIED BY '9999';
GRANT SELECT, INSERT, UPDATE, DELETE ON mnist.* TO 'mnist'@'localhost';
FLUSH PRIVILEGES;
exit;
sudo mysql mnist < mnist.sql
```

## Frontend

```bash
sudo apt install npm
npm install react-scripts --save
```

## Backend (Ha azóta van újabb verzió, lehet azzal is jó.)

```bash
sudo apt install openjdk-17-jdk
```
