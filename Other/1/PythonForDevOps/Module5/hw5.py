import os
import sqlite3

sql_select_server = '''SELECT Servers.id, Projects.proj_name, Servers.dns_name, 
		Servers.ip_address, ServerTypes.type_name 
		FROM (((ServerProjects
		INNER JOIN Projects ON Projects.id=ServerProjects.projects_id)
		INNER JOIN Servers ON ServerProjects.servers_id=Servers.id)
		INNER JOIN ServerTypes ON Servers.servertypes_id=ServerTypes.id)
		WHERE (Projects.proj_name=?) AND (ServerTypes.type_name=?);'''
sql_insert_ports = '''INSERT INTO ServerPorts (servers_id, port_type, port_number) VALUES (?, ?, ?);'''
sql_select_server_ports = '''SELECT ServerPorts.id FROM ServerPorts WHERE (servers_id=?) AND (port_number=?);'''


def check_server_ports(conn, params):
    result = conn.execute(sql_select_server_ports, params).fetchall()
    return len(result)


try:
    db = os.path.join(os.path.dirname(__file__), 'demo.db')
    conn = sqlite3.connect(db)
except:
    print('Can\'t connect to Database ...')


selected_servers = conn.execute(
    sql_select_server, ('Project3', 'apache')).fetchall()

print('-----------------')
print('Selected servers:')

for row in selected_servers:
    print('-----------------')
    print('Server id: ' + str(row[0]))
    print('Project name: ' + row[1])
    print('Server DNS name: ' + row[2])
    print('Server IP address: ' + row[3])
    print('Server type: ' + row[4])

print('-----------------')
print('Adding new port 443 to selected servers...')
for row in selected_servers:
    if (check_server_ports(conn, (row[0], 443)) != 0):
        print('Server with id = ' +
              str(row[0]) + ' is already in database. Nothing to add ...')
    else:
        try:
            conn.execute(sql_insert_ports, (row[0], 'tcp', 443))
            conn.commit()
            print('Server with id = ' + str(row[0]) + ' successfully added.')
        except:
            print('Error adding data to database ...')

conn.close()
