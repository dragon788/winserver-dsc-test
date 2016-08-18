Configuration RequiredPackagesConfig
{
    Import-DSCResource -ModuleName xPSDesiredStateConfiguration, cChoco

    Node localhost
    #Node $AllNodes.NodeName
    {
        LocalConfigurationManager
        {
            DebugMode = 'ForceModuleImport'
        }

        cChocoPackageInstaller installDotNet46
        {
            Name = "dotnet4.6.1"
        }
    }
}

RequiredPackagesConfig -ConfigurationData $ConfigData
