import platform
import socket
import re
import uuid
import json
import psutil
import logging


def getSystemInfo():
    try:
        info = {}
        info['platform'] = platform.system()
        info['platform-release'] = platform.release()
        info['platform-version'] = platform.version()
        info['architecture'] = platform.machine()
        info['processor'] = platform.processor()
        info['ram'] = str(
            round(psutil.virtual_memory().total / (1024.0 ** 3)))+" GB"
        total = int()
        used = int()
        free = int()
        for disk in psutil.disk_partitions():
            if disk.fstype:
                total += int(psutil.disk_usage(disk.mountpoint).total)
                used += int(psutil.disk_usage(disk.mountpoint).used)
                free += int(psutil.disk_usage(disk.mountpoint).free)
        info['Total disks space'] = str(
            round(total / (1024.0 ** 3), 3)) + "GiB"
        info['Used  disks space'] = str(round(used / (1024.0 ** 3), 3)) + 'GiB'
        info['Free  disks space'] = str(round(free / (1024.0 ** 3), 3)) + 'GiB'
        info['hostname'] = socket.gethostname()
        info['ip-address'] = socket.gethostbyname(socket.gethostname())
        info['mac-address'] = ':'.join(re.findall('..',
                                       '%012x' % uuid.getnode()))
        return json.dumps(info)
    except Exception as e:
        logging.exception(e)


json_object = json.loads(getSystemInfo())

json_formatted_str = json.dumps(json_object, indent=2)

print(json_formatted_str)
