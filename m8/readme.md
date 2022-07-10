## Python tasks

### 1) Write easy program, which will display current date and time.

[Program source code](8_1.py)

```
import datetime

dt = datetime.datetime.now()

print("Current date and time = %s" % dt)

print("The time is now: = %s:%s:%s" % (dt.hour, dt.minute, dt.second))

print("Today's date:  = %s.%s.%s" % (dt.day, dt.month, dt.year))
```

**Results:**

![p1](img/p1.png)

### 2) Write python program, which will accept comma-separated numbers, and then it should write tuple and list of them:

```
Enter numbers: 1, 2, 7, 43, 9
Output:
List: [‘1’, ‘2’, ‘7’, ‘43’, ‘9’]
Tuple: (‘1’, ‘2’, ‘7’, ‘43’, ‘9’)
```

[Program source code](8_2.py)

```
print("Enter numbers:")

lst = input().split(',')

print("List: ", lst)

print("Tuple: ", tuple(lst))

```

**Results:**

![p2](img/p2.png)

### 3) Write python program, which will ask file name. File should be read, and only even lines should be shown.

[Program source code](8_3.py)

```
print("Enter filename")
filename = input()
# filename=8_1.py
try:
    file = open(filename)
except:
    print("Can't open file!")
else:
    print("Even lines of file:")
    i = 1
    for line in file:
        if i % 2 != 0:
            print(line.rstrip())
        i = i + 1

```

**Results:**

![p3](img/p3.png)

### 4) Write python program, which should read html document, parse it, and show it’s title.

[Program source code](8_4.py)

```
from bs4 import BeautifulSoup
print("Enter filename")
filename = input()
# filename="test.html"
try:
    file = open(filename)
except:
    print("Can't open file!")
else:
    data = BeautifulSoup(file, "html.parser")
    print("Document header:\n", data.head.title.text)
```

[File test.html](test.html)

```
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test document</title>
</head>

<body>

</body>

</html>
```

**Results:**

![p4](img/p4.png)

### 5) Write python program, which will parse user’s text, and replace some emotions with emoji’s (Look: pip install emoji)

[Program source code](8_1.py)

```

```

**Results:**

### 6) Write program, that will show basic PC information (OS, RAM amount, HDD’s, and etc.)

[Program source code](8_1.py)

```

```

**Results:**
