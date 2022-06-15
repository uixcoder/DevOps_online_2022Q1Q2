## EPAM University Programs
## DevOps external course
## Module 7 Database Administration

##TASK 7.1
###PART 1
![1](img/1.png)
#### 1.Download MySQL server for your OS on VM.
![3](img/3.png)
#### 2.Install MySQL server on VM.
![3](img/3.png)

[Add new user](https://www.digitalocean.com/community/tutorials/mysql-ru)

```
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'USERNAME'@'%' IDENTIFIED BY 'PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;

mysql -u [username] -p
```

#### 3.Select a subject area and describe the database schema, (minimum 3 tables)

[Database Schema](create_db_schema.sql) 

[Original database schema](https://o7planning.org/10235/sample-mysql-database-for-learning-sql#a23366)


#### 4.Create a database on the server through the console.

![4](img/4.png)

![5](img/5.png)

#### 5. Fill in tables.

[Database Fill Script](fill_db.sql)

![6](img/6.png)

#### 6.Construct and execute SELECT operator with WHERE, GROUP BY and ORDER BY.
```
SELECT 
    acc.product_cd,
    COUNT(acc.product_cd) AS Count_Acc,
    SUM(acc.avail_balance) AS Sum_Avail_Balance,
    AVG(acc.avail_balance) AS Avg_Avail_Balance
FROM
    account acc
GROUP BY acc.product_cd
HAVING COUNT(acc.product_cd) > 3
ORDER BY Sum_Avail_Balance;
```
![7](img/7.png)

![7a](img/7a.png)

#### 7.Execute other different SQL queries DDL, DML, DCL.

![8](img/8.png)

##### DDL - Data Definition Language.

```
create table PC_Users (
        user_id integer not null auto_increment,
        avail_balance float,
        status varchar(10),
        primary key (user_id)
);
```
![8a](img/8a.png)

```
alter table PC_Users 
    add min_balance float;
describe PC_Users;
```
![8c](img/8c.png)

```
drop table PC_Users;
```

![8b](img/8b.png)

##### DML - Data Manipulation Language.

```
insert into branch (branch_id, name, address, city, state, Zip_Code) values (null, 'Datastorage', '7777 Sec St.', 'Walt', 'MA', '02452');
```

![8d](img/8d.png)

```
update branch 
set 
    Zip_Code = '111111'
where
    name = 'Datastorage';
```

![8e](img/8e.png)

```
delete from branch 
where
    name = 'Datastorage';
```

![8f](img/8f.png)

#### 8.Create a database of new users with different privileges. Connect to the
database as a new user and verify that the privileges allow or deny certain
actions.

##### DCL - Data Control Language.

Create new user and update its password.

```
create user 'user1'@'localhost';
update mysql.user set authentication_string = password('NEW_USER_PASSWORD') where user = 'user1' and host = 'localhost';
flush privileges;
```

![9a](img/9a.png)

![9b](img/9b.png)

![9c](img/9c.png)

```
grant select on business.* to 'user1'@'localhost';
```

![9d](img/9d.png)

![9e](img/9e.png)

![9f](img/9f.png)

```
grant select,insert on business.* to 'user1'@'localhost';
```

![9g](img/9g.png)

```
revoke insert on business.* from 'user1'@'localhost';
```

![9h1](img/9h1.png)

![9g2](img/9g2.png)


```
revoke all on business.* from 'user1'@'localhost';
```

![9j](img/9j.png)

#### 9.Make a selection from the main table DB MySQL.

```
SELECT 
    acc.product_cd,
    COUNT(acc.product_cd) AS Count_Acc,
    SUM(acc.avail_balance) AS Sum_Avail_Balance,
    AVG(acc.avail_balance) AS Avg_Avail_Balance
FROM
    account acc
GROUP BY acc.product_cd
HAVING COUNT(acc.product_cd) > 3
ORDER BY Sum_Avail_Balance;
```
![7](img/7.png)

![7a](img/7a.png)

### PART 2
#### 10.Make backup of your database.
```
mysqldump -u ivan -p business > business.sql
```

![10](img/10.png)

[Created dump file](business.sql)

#### 11.Delete the table and/or part of the data in the table.

![11a](img/11a.png)

![11b](img/11b.png)

![11c](img/11c.png)

#### 12.Restore your database.

```
mysql -u ivan -p business < business.sql
```

![12](img/12.png)

#### 13.Transfer your local database to RDS AWS.

![13a](img/13a.png)

![13](img/13.png)

![13b](img/13b.png)

#### 14.Connect to your database.

![13c](img/13c.png)

#### 15.Execute SELECT operator similar step 6.

![13d](img/13d.png)

#### 16.Create the dump of your database.

![16a](img/16a.png)

![16b](img/16b.png)

![16c](img/16c.png)

[Created dump files](./Dump20220615)

### PART 3 – MongoDB

[Install on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-ubuntu-18-04-ru)

```
$ sudo apt-get install -y mongodb
$ sudo systemctl status mongodb
```

![17a1](img/17a1.png)

`$ mongo --eval 'db.runCommand({ connectionStatus: 1 })'`

![17a2](img/17a2.png)


#### 17. Create a database. Use the use command to connect to a new database (If it doesn't exist, Mongo will create it when you write to it).

![17a](img/17a.png)

#### 18. Create a collection. Use db.createCollection to create a collection. I'll leave the
subject up to you. Run show dbs and show collections to view your database andcollections.

![18a](img/18a.png)

![18b](img/18b.png)

#### 19. Create some documents. Insert a couple of documents into your collection. I'll
leave the subject matter up to you, perhaps cars or hats.

![19](img/19.png)

#### 20. Use find() to list documents out.

![20](img/20.png)