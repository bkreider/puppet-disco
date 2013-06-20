puppet-disco
============

Configures and manages disco.

## Warnings

I haven't run this since Anaconda 0.9.  This should be seen as a framework for a puppet disco module. i

This will get Disco 90% installed on a cluster.  You will still need to configure your Master to take to the disco slaves. 

## Usage
Git clone this repo into your modules directory as *disco*. 

```puppet
include disco

```

## Needs Fixing

* Disco user is created in /opt/anaconda/var/lib - Disco needs a lot of storage, so the home should exist on large drives.
* The private key is hard added into files
* The public key is hard-coded in the manifest
* Using stored resources, a Puppet master could learn about the slaves and then configure the Disco Master appropriately.
