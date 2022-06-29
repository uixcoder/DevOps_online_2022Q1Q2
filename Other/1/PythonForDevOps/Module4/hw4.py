import rpm
import sys
import os

try:
    path_to_files = sys.argv[1]
except:
    path_to_files = "."
else:
    path_to_files = "."

# file_name = '/media/ivan/SYS/DevOPS/Python/Module4/hw/google-chrome-stable_current_x86_64.rpm'
# file_name = '/media/ivan/SYS/DevOPS/Python/Module4/hw/some_package.el6.x86_64.rpm'

ts = rpm.TransactionSet()
ts.setVSFlags(rpm._RPMVSF_NOSIGNATURES)

file_list = os.listdir(path_to_files)

for current_file in file_list:
    if current_file.endswith('.rpm'):
        fd = os.open(current_file, os.O_RDONLY)
        h = ts.hdrFromFdno(fd)
        print("\n")
        print("RPM package \'" + current_file + "\' info")
        print("NAME..........." + h[rpm.RPMTAG_NAME].decode('ascii'))
        print("SUMMARY........" + h[rpm.RPMTAG_SUMMARY].decode('ascii'))
        print("VERSION........" + h[rpm.RPMTAG_VERSION].decode('ascii'))
        print("RELEASE........" + h[rpm.RPMTAG_RELEASE].decode('ascii'))
        print("ARCH..........." + h[rpm.RPMTAG_ARCH].decode('ascii'))
        print("LIСENSE........" + h[rpm.RPMTAG_LICENSE].decode('ascii'))
        print("GROUP.........." + h[rpm.RPMTAG_GROUP].decode('ascii'))
        print("URL............" + h[rpm.RPMTAG_URL].decode('ascii'))
        print("PACKAGER......." + h[rpm.RPMTAG_PACKAGER].decode('ascii'))
        os.close(fd)
