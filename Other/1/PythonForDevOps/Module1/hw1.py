import os
import sys

path = sys.argv[1]
prefix = sys.argv[2]
counts = int(sys.argv[3])
mode = int("0o"+sys.argv[4], 8)

for n in range(1, counts+1):
    dest = os.path.join(path, prefix + str(n))
    try:
        os.mkdir(dest, mode)
    except OSError:
        print('Oops, error!')
    else:
        print('Folder ' + dest + ' is created')
