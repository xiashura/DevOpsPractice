import json
import jinja2
import sys

path_file = sys.argv

file_state = open(path_file[1],"r")

json_read = file_state.read()
state = json.loads(json_read)

template_loader = jinja2.FileSystemLoader(searchpath="./infra")
template_env = jinja2.Environment(loader=template_loader)
TEMPLATE_FILE = "output_vars.yml.j2"
template = template_env.get_template(TEMPLATE_FILE)

for host in state["outputs"]["instance"]["value"]:
  output_text = template.render(value=host)    
  output_vars_file_name = "./host_vars/" + host["name"] + "/output_vars.yml" 
  output_vars_file = open(output_vars_file_name,"w")
  output_vars_file.write(output_text)
  output_vars_file.close()
  


