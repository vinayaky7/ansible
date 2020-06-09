# ansible

## https://iamlinops.blogspot.com/2020/05/ansible.html

### How to use above playbooks in jenkins

How to use Jenkins to run Playbooks

Install Ansible on Jenkins Master or Jenkins Slave, i.e whichever Machine you use to run the job.

Copy id_rsa.pub file of jenkins user to ec2-users authorized_keys to initiate passwordless authentication

between Jenkins node & your Ansible-Client

Check doing ssh from jenkins server as a jenkins user to ec2-user on Ansible-client

Once done

Update your *yaml files with below text to use ec2-user as remote user & become sudo to perform 

root tasks on Ansible-client

---

- hosts: webservers
  remote_user: ec2-user
  become: true
  become_method: sudo
  tasks:
  - name: Create a login user
    user:
      name: jordan
      password: 'supp0rt'
      state: present
      shell: /bin/bash       # Defaults to /bin/bash
      createhome: yes        # Defaults to yes
      home: /home/jordan  # Defaults to /home/<username>


Now, you can use Ansible playbooks in jenkins job to configure Ansible-Clients.