Provision
=========

A tool for provisioning Ubuntu 12.04 with Ruby 1.9.3, Chef and Librarian.


Usage (Vagrant)
---------------

1. Run `vagrant up` to provision a VM with `build.sh`.
2. Run `package.sh` to package the running VM into `package.box`.
3. Use `package.box` as a base box in your Vagrant project.
