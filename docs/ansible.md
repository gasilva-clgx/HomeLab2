# Ansible Variables

ANSIBLE_CONFIG=ansible/ansible.cfg 
ANSIBLE_ROLES_PATH=./ansible/roles/
ANSIBLE_STDOUT_CALLBACK=debug 
ANSIBLE_HOST_KEY_CHECKING=False



To fix the warning message:

```
[WARNING]: sftp transfer mechanism failed on [knode1.psilva.org]. Use ANSIBLE_DEBUG=1 to see detailed information
```

add this to your ansible.cfg usually on `/etc/ansible/ansible.cfg`
```
[ssh_connection]
scp_if_ssh=True
```

