# gneginskiy_infra
#### Homework for lecture #9: Terraform-2
creating 2 images for the app and for DB respectively:

```packer validate -var-file=variables.json.example db.json ```
```packer validate -var-file=variables.json.example app.json ```
```packer build -var-file=variables.json.example db.json ```
```packer build -var-file=variables.json.example app.json ```

write app.tf and db.tf, then split it into modules with their own main.tf, variables.tf and outputs.tf

then run to load modules the following command:
```terraform get```

run from prod and stage directories to create resources on yc:
```terraform apply```


#### Homework for lecture #8: Terraform-1

```terraform init```  to initialize terraform repo

```terraform plan ```to look at what happens when we run main.tf

```terraform apply``` to apply main.tf and create infrastructure.

```terraform show | grep nat_ip_address``` to show nat_ip_address from terraform.tfstate file

```terraform destroy``` to destroy infra

```terraform refresh```  to update outputs

```terraform output external_ip_address_app``` shows output with the key ...

#### Homework for lecture #7: Packer
how to validate packer template:

`packer validate -var-file=variables.json.example ubuntu16.json`

how to run packer template with user vars:

`packer build -var-file=variables.json ./ubuntu16.json `


#### Homework for Lecture #6: Yandex Cloud key services

testapp_IP = 158.160.54.245

testapp_port = 9292

------------------------------------------------------
#### Homework for Lecture #5: Introduction to Cloud Infrastructure and Cloud Services

------------------------------------------------------

bastion_IP = 51.250.75.7

someinternalhost_IP = 10.128.0.34

<br>

VPN server admin panel: [51.250.75.7.sslip.io](51.250.75.7.sslip.io)

------------------------------------------------------

#### Connecting to the internal host via bastion:
Command to log into bastion host: <br>
`ssh appuser@51.250.75.7`

Command to log into bastion host and enable forwarding of the authentication agent connection: <br>
`ssh -A appuser@51.250.75.7`

Once we connected to bastion, then we can connect to internal host: <br>
`ssh appuser@10.128.0.34`

------------------------------------------------------
#### Connecting to the internal host via bastion in a single command

Since using several commands is rather tedious, we can use one of the following
tricks to connect to internal host through bastion with only 1 command.



The command below connects via ssh to bastion host and then executes another `ssh`  command on a remote machine:<br>

`ssh -t -A appuser@51.250.75.7  'ssh appuser@10.128.0.34'`

this allows us to connect to internal host using only a single command.

Also, there's a more sophisticated trick that we probably do not need, but it does the work as well.
The command below creates a tunnel and then connects to internal host via localhost tunnel on 2222 port.

`ssh -A -J appuser@51.250.75.7 -L 2222:10.128.0.34:22 appuser@10.128.0.34 -N -f -q && ssh -p 2222 appuser@localhost`

------------------------------------------------------

we can assign the command to an alias. this can be done by adding the alias in a bash profile<br>

`vi ~/.bash_profile`

and then, add the line below and save file:

`alias ssh_someinternalhost='ssh -t -A appuser@51.250.75.7  "ssh appuser@10.128.0.34"'`

then, we perform the command to set the alias:
`source ~/.bash_profile`

and here we go, we can use this `ssh_someinternalhost` command to connect to internal host.

------------------------------------------------------
To make it look like normal host and like normal SSH command, we can do the following:

we can add the following line to `~/.bash_profile`:<br>

```
alias someinternalhost='-t -A appuser@51.250.75.7  "ssh appuser@10.128.0.34"'
alias ssh='ssh '
```
this little trick allows us to use alias as a parameter for ssh.
thus, ssh someinternalhost will connect us to someinternalhost, even without establishing a tunnel.

------------------------------------------------------
another approach that we could use, is to add creating the tunnel `localhost:2222` <-> `someinternalhost`, and then modify `.ssh/config` like this:

```
Host someinternalhost
    Hostname 127.0.0.1
    Port 2222
    User appuser
```
this would also work.

------------------------------------------------------
The last possible solution would be the following, we modify  `.ssh/config`, and then use `ProxyCommand` and `netcat` combined, to achieve desired behavior:

```
Host bastion
    HostName 51.250.75.7
    User appuser

Host someinternalhost
    HostName 10.128.0.34
    User appuser
    ProxyCommand ssh bastion nc -q0 %h 22
```

`ProxyCommand`: specifies a command to use as a proxy to reach the `someinternalhost`.
This configuration indicates that the SSH connection should first connect to a `bastion` host
and then use the `nc` command to forward the connection to the `someinternalhost` at port 22.
`%h` is a placeholder that will be replaced with the actual hostname of the `someinternalhost`.
