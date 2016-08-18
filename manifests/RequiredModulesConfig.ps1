Configuration RequiredModulesConfig
{
    Import-DSCResource -ModuleName PowerShellModule
    Node localhost
    #Node $AllNodes.NodeName
    {
        LocalConfigurationManager
        {
            DebugMode = 'ForceModuleImport'
        }

        PSModuleResource cChoco
        {
            Ensure = 'present'
            Module_Name = 'cChoco'
        }

        PSModuleResource xPSDesiredStateConfiguration 
        {
            Ensure = 'present'
            Module_Name = 'xPSDesiredStateConfiguration'
        }
    }
}

RequiredModulesConfig -ConfigurationData $ConfigData
