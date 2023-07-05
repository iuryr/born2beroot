# Born2beroot ROADMAP

In this file I'll document the necessary steps to attain the Virtual Machine compliant to the project requirements.

We'll use the Debian 12 (codename _bookworm_) distribution. An .iso file can be downloaded [here](https://www.debian.org/download).

## 1. Creating the VM
Using Oracle Virtual Box, let's create a nem Virtual Machine with the following characteristics:
- Linux Debian distribution
- 2GB (aka 2048MB) RAM
- 30GB HD (after creating a new virtual disk, specifically a VirtualBox Disk Image). It is advisable that this file to be dinamically allocated.

## 2. Booting the VM for the first time
As of now, the VM is created, but it is not operational. When we boot it the first time, we'll have to install the operating system following the project's requirements.

Immediately after booting, VirtualBox will ask us to point to the relevant .iso file. Then we'll begin the installation process.

### 2.1 Select the install mode
The installation programa will prompt us to select one installation mode. Let's not use the Graphical Interface. **Select Install**
After that, select appropriately the language, keyboard and timezone options. We'll use English language, Brazil/SP timezone, and brazilian keyboard layout.

#### Hostname
The system we are installing must have a name that identifies it to the network. As per project's requirement, it's name must be our login followed by 42. In my case, the hostname is iusantos42. No domain name is necessary.

#### Root password
Now we must configure the root user (a kind of master user) password.

#### Create normal user
The system prompts us the give a full name, user name and password for a normal user. Since the project requires that a user with our login to be present, I'll create a user called iusantos.

### 2.2 Partitioning the Hard drive
As of now, our (virtual) hard drive is completely empty. We have to configure it to have the format specified in the project. Consider the image below:
[Storage partition schema](cropped_lsblk.png).
