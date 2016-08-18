# -*- mode: ruby -*-
# vi: set ft=ruby :


$shell_script = <<SCRIPT
  choco feature enable -n=allowGlobalConfirmation
  Install-PackageProvider NuGet -MinimumVersion '2.8.5.201' -Force
  Import-PackageProvider NuGet -MinimumVersion '2.8.5.201' -Force
  Set-PSRepository -InstallationPolicy Trusted -Name PSGallery
  Install-Module -Name PowerShellModule
  # The below modules get installed by the first partial config
  #Install-Module -Name xPSDesiredStateConfiguration
  #Install-Module -Name cChoco
  Get-DSCResource
  choco feature disable -n=allowGlobalConfirmation
SCRIPT

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  # Local box build from boxcutter/windows
  #config.vm.box = "win2012r2"
  #config.vm.box_url = "http://localserver.domain/vagrant/win2012r2"

  # Box built from the mwrock/packer-templates repo on GitHub
  # This box should have Chocolatey/Boxstarter built in
  config.vm.box = "mwrock/Windows2012R2"

  # Box linked from the mefellows/vagrant-dsc repo development/Vagrantfile on GitHub
  # Probably built from https://github.com/mefellows/packer-community-templates
  #config.vm.box = "mfellows/windows2012r2"
  # Below line keeps box from prompting for updates if authors release a new one
  # This speeds up the 'vagrant up' time if you are on a slow network.
  config.vm.box_check_update = false


  hostname = "vagrantdsc.local"
  ip_address = "10.0.0.30"
  config.vm.guest = :windows
  config.vm.communicator = "winrm"
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
  config.vm.network :forwarded_port, guest: 80,   host: 8000, id: "web" # Port forward for IIS
  config.vm.network :forwarded_port, guest: 443, host: 8443,  id: "ssl" # Port forward for SSL IIS
  config.vm.network :forwarded_port, guest: 22, host: 9222,  id: "ssh" # Port forward for SSL IIS
  config.vm.network "private_network", ip: ip_address

  if Vagrant.has_plugin?("vagrant-multi-hostsupdater")
    config.multihostsupdater.aliases = {ip_address => [hostname]}
  end

  config.vm.provider "virtualbox" do |v|
    v.gui = true
  end

  # Install Chocolatey and some basic DSC Resources
  config.vm.provision "resources", type: "shell", inline: $shell_script

  # Upload Website
  # Use this if you are testing DSC for managing IIS (note the lack of drive letter, this is due to a bug in Vagrant 1.8.4)
  #config.vm.provision "file", source: "website", destination: "MyWebApp"

  # Run DSC
  config.vm.provision "dsc" do |dsc|
    # This the name of your config.
    # If you are using partial configs, you run one, then the other, then optionally reboot.
    MyConfig = 'RequiredModulesConfig'
    #MyConfig = 'RequiredPackagesConfig'

    # Set of module paths relative to the Vagrantfile dir.
    #
    # These paths are added to the DSC Configuration running
    # environment to enable local modules to be addressed.
    #
    # @return [Array] Set of relative module paths.
    #dsc.module_path = ["modules"]

    # The path relative to `dsc.manifests_path` pointing to the Configuration file
    dsc.configuration_file  = "#{MyConfig}.ps1"

    # The path relative to Vagrantfile pointing to the Configuration Data file
    dsc.configuration_data_file  = "manifests/#{MyConfig}.psd1"

    # The Configuration Command to run. Assumed to be the same as the `dsc.configuration_file`
    # (sans extension) if not provided.
    dsc.configuration_name = "#{MyConfig}"

    # Relative path to a pre-generated MOF file.
    #
    # Path is relative to the folder containing the Vagrantfile.
    # dsc.mof_path = "mof"

    # Relative path to the folder containing the root Configuration manifest file.
    # Defaults to 'manifests'. # INCORRECT! if empty defaults to Vagrantfile path
    #
    # Path is relative to the folder containing the Vagrantfile.
    dsc.manifests_path = "manifests"

    # Commandline arguments to the Configuration run
    #
    # Set of Parameters to pass to the DSC Configuration.
    #dsc.configuration_params = {"-NodeName" => "localhost"}

    # The type of synced folders to use when sharing the data
    # required for the provisioner to work properly.
    #
    # By default this will use the default synced folder type.
    # For example, you can set this to "nfs" to use NFS synced folders.
    # dsc.synced_folder_type = ""

    # Temporary working directory on the guest machine.
    # dsc.temp_dir = "c:/tmp/vagrant-dsc"
  end
end
