### Setup Server
#### Way 1:
**Run these commands to backup the server:**

From the server:
```sh
sudo apt install apt-clone
mkdir ~/packages-installed
sudo apt-clone clone ~/packages-installed
apt-clone info ~/packages-installed/apt-clone-state-ubuntuserver.tar.gz
```

From home machine:
```sh
rsync -uvrP root@<server>:/root/packages-installed ~/backup
```

**Run these commands to setup the server:**
```sh
rsync -uvrP ~/backup/packages-installed root@<server>:/root/
sudo apt-clone restore apt-clone-state-ubuntuserver.tar.gz
```

===================================================================================

#### Way 2:
**Run these commands to backup the server:**

From the server:
```sh
sudo dpkg --get-selections > pkgs_selection.lst
sudo apt-mark showauto > pkgs_auto.lst
sudo apt-mark showmanual > pkgs_manual.lst
```

**Run these commands to setup the server:**
```sh
sudo apt-get install dselect
sudo dselect update
sudo dpkg --set-selections < pkgs_selection.lst
sudo apt-get dselect-upgrade
sudo apt-mark auto $(cat pkgs_auto.lst)
sudo apt-mark manual $(cat pkgs_manual.lst)
```
