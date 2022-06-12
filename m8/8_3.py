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
