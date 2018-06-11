# Run Ansible

## Introduction
Bit of copy about plays (link of to ansible documentation)
bit of copy about playbooks (link to ansible documentation)

# Useful terms:
- Inventory - these are the hosts that the Ansible will run against. They can be listed provided in a number of different ways. For now it is not essential to know more than this but if you're interested in finding out more [click here](http://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html)

## Learning Objectives

## Exercise
**Note:** Before going any further do the following:
- `cd YOUR_CLONE_OF_THIS REPO`
- `. ./bin/setup`
- `cd ./exercises/IaC/ansible/running_ansible/ansible`

### ansible-playbook
The `ansible-playbook` command is used to execute a group of plays against servers identified in the supplied inventory.

To see what this command can do run: `ansible-playbook --help`. Along with documentation on a large number of options, the following top level documentation should be displayed:
```BASH
Usage: ansible-playbook [options] playbook.yml [playbook2 ...]

Runs Ansible playbooks, executing the defined tasks on the targeted hosts.
```
At the simplest level, all that the `ansible-playbook` command simply requires to be pointed at a playbook. One has been supplied for you in `./ansible/apache.yml`. to use it run:
`ansible-playbook ansible/apach.yml`

You should see the following output:
```bash
PLAY [apache] ******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [install httpd] ***********************************************************
changed: [localhost]

TASK [Start service httpd, if not running] *************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0   

[OK] FINISHED - connect with: cic start lvlup/ci_course:xxxxxxxxxx

```

> So what just happened?  

Well you ran your very first ansible playbook!

> What did it do?

Well the first thing it did to look at the `./ansible/apache.yml` and found the plays defined in there. In the [writing a playbook] you'll look in detail at the what the entries in this file actually do. For now, feel free to take a look at this file, its very small and pretty clear about what it's doing. The terminal output shows us that:
 - It has detected a playbook containing a play called 'apache'.
 ```bash
PLAY [apache] ******************************************************************
```
 - Has detected what hosts (inventory) this playbook is to run against.
 ```bash
TASK [Gathering Facts] *********************************************************
ok: [localhost]
```
 - Has installed apache2
 ```bash
TASK [install httpd] ***********************************************************
changed: [localhost]
```
 - has started apache2
 ```bash
TASK [Start service httpd, if not running] *************************************
changed: [localhost]
```
 - Given us a summary of the number of actions that is has taken.
 ```bash
 PLAY RECAP *********************************************************************
 localhost                  : ok=3    changed=2    unreachable=0    failed=0
 ```
 
> What about the last line of output
```bash
[OK] FINISHED - connect with: cic start lvlup/ci_course:xxxxxxxxxx
```   

This line wasn't outputed by Ansible itself, but actually the courseware supporting this tutorial. This line gives you the command that you can use to connect to the temporary container that was created on your behalf for the Ansible to run against.

#### Connect to the remote environment with the 'cic' command
run the command that was ouputted on your console: `cic start lvlup/ci_course:xxxxxxxxxx`
This outputs something like the following:
```bash
[OK] Starting container: lvlup-ci_course-2e0fbb687b7c
     
     connect to it with the 'cic connect' command.
     E.g. cic connect lvlup-ci_course-2e0fbb687b7c
     For more info run: cic help connect
```

The container built out by the ansible-playbook is now up and running and ready to be looked at. 

To connect the container press `ctrl+z` and then run `bg` to put the process in the background. Then using the actual container name given from the `cic start` run:
```
cic connect lvlup-ci_course-xxxxxxxxxxxx 
```

You will now be in a bash shell on the container itself. From here run: `curl localhost:80` to see that apache is alive and well. `ctrl + d` will disconnect you from the container. 

Run `fg` to bring the active connection to the container back to the foreground and press `ctrl+c` to stop the container.
