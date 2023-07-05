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

![Storage partition schema](cropped-lsblk.png).

For pedagogical reasons, we'll not use the guidance provided by the installer. We'll do it manually.

#### Select the block device that will be partitioned
First of all, we have to select the (virtual, in this case) storage device that will be partitioned. In our case, we have to select `SCSI3 (0,0,0) (sda) - 32.2 GB ATA VBOX HARDDISK`. After pressing Yes in the next window, we'll be presented with the following image:

![Greenfield Partition](ss01_first_partition_cropped.png)

What the image says is: the device `VBOX HARDDISK` has the partition pri/log with 32.2 GB of Free Space.

Now we have to partition this pri/log partition adequately.

#### First Partition (/boot)
Pressing ENTER when the pri/log line is selected will present us with the option to `Create a new partition`. The first partition we'll create will be used to store the files that the VM will use to boot up. **Let's set 500MB to this. (500M in the selected field)**. After setting the size, we'll need to select the type of partition. **Select Primary**. This means that this partition will be _bootable_ (accessed by the BIOS or UEFI). **Location: beginning**

Now the system knows that we have a 500MB partition. We need to provide a filesystem to this partition, as well as define a mountpoint. The filesystem will be ext4 and the mount point for this partition is **/boot**. Now we're `Done setting up this partition`.

Notice that now the pri/log partition has a shorter size (exactly the 500MB that we allocated to the previous partition). See the picture below:

![First partition set](ss02_first_partition_set_cropped.png)

#### Encrypting the rest of the device
To comply with the projects requirements we must now encrypt the rest of the device and, after that, create Volume Group and logical partitions. To encrypt the device, select the option `Configure encrypted volumes` -> `Yes` -> `Create encrypted volumes` and select `/sda/dev/`, which refers to the partition with the Free Space. Now we're done `Setting up the partition`.

#### Creating Volume Group and logical partitions
Now we have the following situation. Our (virtual) storage device has:
- A primary partition of 500M
- An encrypted partition of 31.7GB.

We now have to separate this second partition into different **logical** partitions beloging to the same _Volume Group_. For this me must select the `Configure the Logical Volume Manager` option, then `Yes`. Next we have to create a `Create a Volume Group` and, for this project, we'll call it LVMGroup. Next, we have to identify which device will be part of this volume group we created. In this scenario, we must select only the encrypted device (it's likely called /dev/sda5) then `Yes`.

Now we must create the logical partitions with the adequate sizes. The procedure is the same for all the logical volumes (root, home, srv, var, tmp, var-log and swap).

- `Create Logical Volume` -> Select the LVMGroup -> Type the logical volume name (for example root) -> Type the logical volume size.

After doing this _busywork_, our situation is the following: our harddrive is divided in two physical partitions: the primary and the other. The other is an encrypted partition that has 7 logical partitions (all of them are part of the LVGroup Volume Group). Se the image below:

![HD partitioned but whithout mount points](ss03_partitions_wo_mounting_cropped.png)
