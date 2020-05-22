# Linux server setup 

Prerequisites:

- Ubuntu >18 Linux server with ssh access and root privileges


## Step 1: First connection, Linux update and setup.

1.1 Ssh to the server using ssh command:

```bash
ssh root@<ip_address>
```

1.2 Update linux:

```bash
apt-get update && apt-get upgrade
```

You might need to use sudo for this command.

1.3 Setup hostname of the server:

```bash
hostnamectl set-hostname <hostname>
```

1.4 Alter the /etc/hosts command to bind the ip address with the hostname.

```bash
nano /etc/hosts
```

Add a line after the first one (tab separation):

```bash
<ip_address>    <hostname>
```

Exit and save the file.

## Step 2: Add user.

2.1 Create a limited user.

```bash
adduser <username>
```

And fill out the necessary information (password and other).

2.2 Add the created user to the sudo group.

```bash
adduser <username> sudo
```

2.3 Exit and login (ssh as a new user).

```bash
exit
ssh <username>@<ip_address>
```

## Step 3: Key-based authentication.

3.1 In the home folder of the linux server, create a directory called '.ssh'.

```bash
mkdir -p ~/.ssh
```

3.2 Go to the local machine and generate the key.

On local:
```bash
ssh-keygen -b 4096
```

This will generate a key pair.

3.3 Copy the public key to the linux server.

On local, in the directory with the key:

```bash
scp id_rsa.pub <username>@<ip_address>:~/.ssh/authorized_keys
```

Note: If you already have autorized_keys file, you need to concatenate the old file and a new file.

3.4 On the linux server in the home directory change some permissions:

```bash
sudo chmod 700 ~/.ssh/
sudo chmod 600 ~/.ssh/*
```

This will enable login without the password.

3.5 Optionally disallow login without a password. Be sure to test ssh without with keys first!

Edit sshd_config file.
```bash
sudo nano /etc/ssh/sshd_config
```

Set:

    PermitRootLogin No

    PasswordAuthentication No 

Restart ssh service.

```bash
sudo systemctl restart sshd
```

## Step 4: Firewall setup.

4.1 Install and setup firewall.

```bash
sudo apt-get install ufw
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh
sudo ufw allow 8000 (for testing)
sudo ufw enable
sudo ufw status # (see whether everything looks ok)
```
