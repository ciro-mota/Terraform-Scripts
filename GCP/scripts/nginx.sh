#!/bin/bash

tee /tmp/index.html.j2 <<'EOF'
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>GCP - It Works - {{ page_hostname }}</h1>
<br>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
EOF

tee /tmp/requirements.yml <<'EOF'
---
roles:
  - name: geerlingguy.nginx
    version: "3.3.0"

collections:
  - name: community.general
    version: ">=12.6.0"
  
  - name: devsec.hardening
    version: ">=10.5.2"
EOF

tee /tmp/playbook.yml <<'EOF'
---
- hosts: localhost
  become: true
  gather_facts: true
  vars:
    page_hostname: "{{ ansible_facts['hostname'] | default(inventory_hostname) }}"
    nginx_service_state: stopped
    nginx_service_enabled: true
    nginx_manage_firewall: true
    nginx_firewall_ports:
      - 80
      - 443
    ssh_kex:
    - sntrup761x25519-sha512@openssh.com
    - curve25519-sha256@libssh.org
    - diffie-hellman-group-exchange-sha256
    ssh_server_ports: ['22']
    ssh_permit_root_login: "without-password"
    ssh_use_pam: "true"
    sshd_authenticationmethods: "publickey"
    ssh_authorized_keys_file: ".ssh/authorized_keys"
  tasks:
    - name: Install Nginx
      include_role:
        name: geerlingguy.nginx

    - name: Ensure nginx pid path is /run/nginx.pid (RedHat)
      lineinfile:
        path: /etc/nginx/nginx.conf
        regexp: '^\s*pid\s+'
        line: 'pid /run/nginx.pid;'
      when: ansible_os_family == "RedHat"
      notify: restart nginx

    - name: Ensure nginx conf.d exists (RedHat)
      file:
        path: /etc/nginx/conf.d
        state: directory
        mode: '0755'
      when: ansible_os_family == "RedHat"

    - name: Configure default vhost (RedHat)
      copy:
        dest: /etc/nginx/conf.d/default.conf
        owner: root
        group: root
        mode: '0644'
        content: |
          server {
            listen 80 default_server;
            listen [::]:80 default_server;
            server_name _;

            root /usr/share/nginx/html;
            index index.html;

            location / {
              try_files $uri $uri/ =404;
            }
          }
      when: ansible_os_family == "RedHat"
      notify: reload nginx

    - name: SSH Hardening
      include_role:
        name: devsec.hardening.ssh_hardening

    - name: Copy index.html.j2 to Debian systems using template
      template:
        src: /tmp/index.html.j2
        dest: /var/www/html/index.html
      when: ansible_os_family == "Debian"

    - name: Copy index.html.j2 to RedHat systems using template
      template:
        src: /tmp/index.html.j2
        dest: /usr/share/nginx/html/index.html
        owner: nginx
        group: nginx
        mode: '0644'
      when: ansible_os_family == "RedHat"

    - name: Reset nginx failed state (systemd)
      command: systemctl reset-failed nginx
      changed_when: false
      failed_when: false

    - name: Ensure nginx is started
      service:
        name: nginx
        state: started
        enabled: true

  handlers:
    - name: start nginx
      service:
        name: nginx
        state: started

    - name: restart nginx
      service:
        name: nginx
        state: restarted

    - name: reload nginx
      service:
        name: nginx
        state: reloaded
EOF

if [ -f /etc/debian_version ]; then
  export DEBIAN_FRONTEND=noninteractive
  apt-get -q update && apt-get -qy install ansible
elif [ -f /etc/redhat-release ]; then
  dnf check-update > /dev/null || true
  dnf install -y ansible-core
else
  echo "Unsuported Distro."
fi

ansible-galaxy install -r /tmp/requirements.yml
ansible-playbook /tmp/playbook.yml