[DSCLocalConfigurationManager()]
configuration DSCPullClientConfig
{
   Node localhost
   {
      Settings
      {
          RefreshMode = "Push"
          RebootNodeIfNeeded = $true
      }

      ConfigurationRepositoryWeb PullSvc1
      {
          ServerURL = 'http://pullserver.mydomain/PSDSCPullServer.svc'
          AllowUnSecureConnection = $true
      }

      PartialConfiguration RequiredModulesConfig
      {
         Description = 'Configuration to add required modules'
         RefreshMode = 'Push'
         #ConfigurationSource = '[ConfigurationRepositoryWeb]PullSvc1'
      }

      PartialConfiguration RequiredPackagesConfig
      {
         Description = 'Configuration to add required packages and roles'
         RefreshMode = 'Push'
         #ConfigurationSource = '[ConfigurationRepositoryWeb]PullSvc1'
         DependsOn = '[PartialConfiguration]RequiredModulesConfig'
      }
   }
}

DSCPullClientConfig
