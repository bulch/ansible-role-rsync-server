# Ansible Role: Rsync server


[![Actions Status](https://github.com/bulch/ansible-role-rsync-server/actions/workflows/ci.yml/badge.svg)](https://github.com/bulch/ansible-role-rsync-server/actions) [![Actions Status](https://github.com/bulch/ansible-role-rsync-server/actions/workflows/release.yml/badge.svg)](https://github.com/bulch/ansible-role-rsync-server/actions)

[![Ansible Role](https://img.shields.io/ansible/role/61117?style=for-the-badge)](https://galaxy.ansible.com/bulch/rsync_server/) [![Ansible Role Downloaded](https://img.shields.io/ansible/role/d/61117?style=for-the-badge)](https://galaxy.ansible.com/bulch/rsync_server/)

Setup rsync as a server.

## Requirements

None.

## Role Variables

`vars/main.yml`

```
# Varible for install packeges on host
rsync_server_packages:
  - name: 'rsync'
```

`default`
```
rsync_server_timeout: 300                   # rsync timeout, default(300, true)
rsync_server_max_connections: 2             # rsync connections, default(2, true)

rsync_config_manage:
  - name: "rsync-storage-name"              # Rsync storage name for access rsync://${RSYNC_LOGIN}@localhost:873/rsync-storage-name
    configs:
      comment: "Dump folder for rsync"      # Comment for storage
      path: "/var/www/rsync_dumps"          # Path folder storage
      hosts_allow: ["*"]                    # Allowed hosts address
      uid: "nobody"                         # user id files | default('nobody')
      gid: "nogroup"                        # groups user id files | default('nogroup')
      readonly: true                        # default(true) | ternary('true', 'false' )
      list: true                            # default(true) | ternary('yes', 'no' )
      chroot: true                          # default(true) | ternary('true', 'false' )
      exclude: ['lost+found', '.*']         # default(['lost+found', '.*'], true) | join(' ')
    secrets:
      user: "{{ rsync_user }}"              # RSYNC_LOGIN or user for rsync
      password: "{{ rsync_password }}"      # RSYNC_PASSWORD or password for rsync
      filepath: ""                          # default('/etc/rsyncd.secrets')
```

## Example Playbook

```
---
- hosts: all

  strategy: debug

  become: yes

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'
      changed_when: false

  vars_files:
    - vars/secrets.yml
    - vars/vars.yml

  roles:
    - rsync_server

  vars:
    rsync_config_manage:
    - name: "rsync_dumps"
      configs:
        comment: "Dump folder for rsync"
        path: "/var/www/rsync_dumps"
        hosts_allow: ["*"]
      secrets:
        user: "{{ rsync_user }}"
        password: "{{ rsync_password }}"

```

## License

MIT / BSD

## Author Information

This role was created in 2022 by [bulch](https://bulch.ru), <bulch@bulch.ru>
