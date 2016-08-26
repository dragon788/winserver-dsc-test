# winserver-dsc-test
## Testing DSC and Vagrant-DSC
This Vagrantfile serves as a quick way to get up and running with PowerShell DSC and Vagrant.

The inspiration for this came from https://github.com/mefellows/vagrant-dsc and the `development` folder there.

I wanted to test with a remote pull server as well as testing locally, and when I discovered that you need a way to get the
modules onto your system and/or pull server if they aren't already there, I put together a couple resources I found to magically
install the modules in two phases, first by getting the module that installs things from the gallery, and second by actually
installing the modules I needed for my projects. This avoids the human error factor of putting them in the wrong folder or
the wrong layout.

I am also using this to experiment with partial configs. Normally with DSC it attempts to perform the entire configuration 
in one shot, but this doesn't work very well if you have steps that require a reboot to actually take effect, so the partial
configurations allow you to do pre-requisite steps and once the system has confirmed that a config is complete it will move
onto the next one that depended upon the prior.
