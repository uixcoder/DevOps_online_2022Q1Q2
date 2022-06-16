## Task 6.1

### Task A
```
Create a script that uses the following keys:
1. When starting without parameters, it will display a list of possible keys and their description.
2. The --all key displays the IP addresses and symbolic names of all hosts in the current subnet
3. The --target key displays a list of open system TCP ports.
The code that performs the functionality of each of the subtasks must be placed in a separate function
```
### [Created bash script](task_a.sh)

### Results

![a1](img/a1.png)

![a2](img/a2.png)

![a3](img/a3.png)

### Task B
```
Using Apache log example create a script to answer the following questions:
1. From which ip were the most requests?
2. What is the most requested page?
3. How many requests were there from each ip?
4. What non-existent pages were clients referred to?
5. What time did site get the most requests?
6. What search bots have accessed the site? (UA + IP)
```

### [Created bash script](task_b.sh)

### Results

![b1](img/b1.png)

![b3](img/b3.png)

![b4](img/b4.png)

### Task C
```
Create a data backup script that takes the following data as parameters:
1. Path to the syncing directory.
2. The path to the directory where the copies of the files will be stored.
In case of adding new or deleting old files, the script must add a corresponding entry to the log file
indicating the time, type of operation and file name. [The command to run the script must be added to
crontab with a run frequency of one minute]
```
### [Created bash script](task_c.sh)

### [Sample log file](sync.txt)

### Results

![c1](img/c1.png)

![c2](img/c2.png)

### Results with cron

![c3](img/c3.png)

![c3a](img/c3a.png)

![c4](img/c4.png)

![c5](img/c5.png)

