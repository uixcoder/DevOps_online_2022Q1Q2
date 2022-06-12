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
