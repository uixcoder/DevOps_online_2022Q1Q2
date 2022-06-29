import os
import sys
import json

path_to_files = sys.argv[1]
json_file_name = sys.argv[2]

result = {
    'id': 0,
    'number': '0',
    'committer_name': '',
    'committer_email': ''
}

file_list = os.listdir(path_to_files)

for current_file in file_list:
    current_file_descriptor = open(path_to_files + '/' + current_file)
    json_data = json.load(current_file_descriptor)
    if json_data['result'] != 0:
        if int(json_data['number']) > int(result['number']):
            result['id'] = json_data['id']
            result['number'] = json_data['number']
            result['committer_name'] = json_data['committer_name']
            result['committer_email'] = json_data['committer_email']
    current_file_descriptor.close()

json_file_descriptor = open(json_file_name, 'w+')
json_file_descriptor.write(json.JSONEncoder().encode(result))
json_file_descriptor.close()
