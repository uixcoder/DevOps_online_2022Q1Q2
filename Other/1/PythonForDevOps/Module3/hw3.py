import sys
import paramiko
import getpass

host_name = sys.argv[1]
port_name = int(sys.argv[2])
path = sys.argv[3]
prefix = sys.argv[4]
counts = int(sys.argv[5])
mode = sys.argv[6]

print('Enter username:')
user_name = input()
print('Enter user \"' + user_name + '\" password:')
user_password = getpass.getpass()

# start ssh connection
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(host_name, port_name, user_name, user_password,
            look_for_keys=False, allow_agent=False)

# # test command 'ls -al' remotely and received output format
# stdin, stdout, stderr = ssh.exec_command('ls -al')
# res = stdout.read()
# print(type(res))
# print(res)
# print(type(str(res)))
# print(str(res))
# print(res.decode('utf-8'))


# # remove previously created 'path/prefix*' directories
stdin, stdout, stderr = ssh.exec_command('rmdir ' + path + '/' + prefix + '*')
res = stdout.read().decode('utf-8') + stderr.read().decode('utf-8')
if res == '':
    print('\nOld directories ' + path + '/' +
          prefix + '* successfully removed...')

# create required directories
for n in range(1, counts+1):
    stdin, stdout, stderr = ssh.exec_command(
        'mkdir -m ' + mode + ' ' + path + '/' + prefix + str(n))
    res = stdout.read().decode('utf-8') + stderr.read().decode('utf-8')
    if res == '':
        print('\nDirectory ' + path + '/' + prefix +
              str(n) + ' successfully created ...')
    else:
        print(res)

# close ssh connection
ssh = ssh.invoke_shell()
ssh.close()
