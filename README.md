# Ansible Role: Rsync server


[![Actions Status](https://github.com/bulch/ansible-role-rsync-server/actions/workflows/ci.yml/badge.svg)](https://github.com/bulch/ansible-role-rsync-server/actions) [![Actions Status](https://github.com/bulch/ansible-role-rsync-server/actions/workflows/release.yml/badge.svg)](https://github.com/bulch/ansible-role-rsync-server/actions)

[![Ansible Role](https://img.shields.io/ansible/role/61117?style=for-the-badge)](https://galaxy.ansible.com/bulch/rsync_server/) [![Ansible Role Downloaded](https://img.shields.io/ansible/role/d/61117?style=for-the-badge)](https://galaxy.ansible.com/bulch/rsync_server/)

Setup rsync as a server.

## Requirements

None.

## Role Variables

Default tvaribles

```
rsync_config_file: "/etc/rsyncd.conf"
rsync_config_port: 873

rsync_server_timeout: 300
rsync_server_max_connections: 2

rsync_config_manage: []
```


## Example Playbook

```
---
- name: Example Playbook
  hosts: all
  strategy: debug
  become: yes
  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'
      changed_when: false
  vars_files:
    - vars/secrets.yml
  roles:
    - rsync_server
  vars:
    rsync_config_manage:
    - name: "example-storage"
      configs:
        comment: "Example storage"
        path: "/var/www/example-storage"
        hosts_allow: ["*"]
      secrets:
        user: "{{ my_secter_rsync_user }}"
        password: "{{ my_secter_rsync_password }}"
```

Rsync list for test

```bash
RSYNC_PASSWORD=068tg5jLVv4 rsync --list-only rsync://9D0EeojsHCU@localhost:873/example-storage
```

## License

MIT / BSD

## Author Information

This role was created in 2022 by [bulch](https://bulch.ru), <bulch@bulch.ru>
